/**
 * UC002 – Gerenciar Registros de Leitura (RF 010 a RF 013).
 *
 * Tabela: registros_leitura (já existente no banco do projeto): titulo_livro,
 * total_paginas (opcional após a migração 001), duracao_segundos, observacoes.
 * A API continua falando em minutosLidos/anotacoes; aqui convertemos para as
 * colunas reais (minutos x 60 = segundos; anotacoes = observacoes).
 */
import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { lerDataCivil } from '../users/idade';
import { CreateReadingLogDto } from './dto/create-reading-log.dto';
import { UpdateReadingLogDto } from './dto/update-reading-log.dto';

// Colunas devolvidas ao cliente. to_char entrega a data como texto AAAA-MM-DD, para
// o JavaScript não aplicar fuso horário e "voltar" um dia.
const SELECT_REGISTRO = `
  SELECT r.id, r.usuario_id,
         r.titulo_livro, r.total_paginas,
         r.paginas_lidas,
         to_char(r.data_leitura, 'YYYY-MM-DD') AS data_leitura,
         r.duracao_segundos,
         (r.duracao_segundos / 60) AS minutos_lidos,
         COALESCE(r.observacoes, '') AS anotacoes,
         r.criado_em, r.atualizado_em
    FROM registros_leitura r`;

@Injectable()
export class ReadingLogsService {
  constructor(private readonly databaseService: DatabaseService) {}

  // ------------------------------------------------------------------ RF 010
  async criar(dados: CreateReadingLogDto) {
    // Pré-condição: usuário autenticado (existe e está ativo).
    await this.exigirUsuarioAtivo(dados.usuarioId);

    const titulo = dados.tituloLivro.trim();
    if (!titulo) {
      throw new BadRequestException('O título do livro é obrigatório.');
    }
    this.exigirDataValida(dados.dataLeitura);

    // Passo 3 do fluxo e A1: páginas lidas não podem exceder o total do livro
    // (validado só quando o total é informado).
    this.exigirPaginasDentroDoTotal(dados.paginasLidas, dados.totalPaginas ?? null);

    const inserido = await this.databaseService.query(
      `INSERT INTO registros_leitura
              (usuario_id, titulo_livro, paginas_lidas, total_paginas, data_leitura,
               duracao_segundos, observacoes)
       VALUES ($1, $2, $3, $4, $5, $6, $7)
       RETURNING id`,
      [
        dados.usuarioId,
        titulo,
        dados.paginasLidas,
        dados.totalPaginas ?? null,
        dados.dataLeitura,
        (dados.minutosLidos ?? 0) * 60,
        dados.anotacoes?.trim() ?? '',
      ],
    );

    // Passo 4 do fluxo cita "atualizar estatísticas e EXP". Nenhuma regra de EXP
    // existe nos documentos recebidos (UC016 está fora do escopo), então NÃO
    // inventamos cálculo: o EXP do usuário não é alterado. Pendência documentada.
    const registro = await this.buscarDoUsuario(inserido.rows[0].id, dados.usuarioId);
    return { mensagem: 'Registro de leitura salvo com sucesso!', registro };
  }

  // ------------------------------------------------------------------ RF 011
  async listar(usuarioId: number) {
    await this.exigirUsuarioAtivo(usuarioId);

    const resultado = await this.databaseService.query(
      `${SELECT_REGISTRO}
        WHERE r.usuario_id = $1
        ORDER BY r.data_leitura DESC, r.id DESC`,
      [usuarioId],
    );

    // A1: sem registros -> lista vazia (o frontend mostra a mensagem indicativa).
    return { registros: resultado.rows };
  }

  async detalhar(id: number, usuarioId: number) {
    await this.exigirUsuarioAtivo(usuarioId);
    const registro = await this.buscarDoUsuario(id, usuarioId);
    return { registro };
  }

  // ------------------------------------------------------------------ RF 012
  async atualizar(id: number, dados: UpdateReadingLogDto) {
    await this.exigirUsuarioAtivo(dados.usuarioId);
    // Pré-condição: o usuário ser o autor (404 se não existe, 403 se é de outra pessoa).
    const atual = await this.buscarDoUsuario(id, dados.usuarioId);

    const tituloNovo = dados.tituloLivro?.trim();
    if (dados.tituloLivro !== undefined && !tituloNovo) {
      throw new BadRequestException('O título do livro não pode ficar vazio.');
    }
    const tituloFinal = tituloNovo ?? atual.titulo_livro;
    // Total: o informado agora; senão o já gravado, exceto se o livro mudou
    // (o total antigo não vale para outro livro).
    const livroMudou = tituloFinal.toLowerCase() !== atual.titulo_livro.toLowerCase();
    const totalPaginas: number | null =
      dados.totalPaginas !== undefined
        ? dados.totalPaginas
        : livroMudou
          ? null
          : atual.total_paginas;

    const paginasLidas = dados.paginasLidas ?? atual.paginas_lidas;
    const dataLeitura = dados.dataLeitura ?? atual.data_leitura;
    if (dados.dataLeitura !== undefined) this.exigirDataValida(dados.dataLeitura);

    // A1: dados inconsistentes -> 400 e o usuário ajusta.
    this.exigirPaginasDentroDoTotal(paginasLidas, totalPaginas);

    await this.databaseService.query(
      `UPDATE registros_leitura
          SET titulo_livro = $1, paginas_lidas = $2, total_paginas = $3, data_leitura = $4,
              duracao_segundos = $5, observacoes = $6, atualizado_em = now()
        WHERE id = $7 AND usuario_id = $8`,
      [
        tituloFinal,
        paginasLidas,
        totalPaginas,
        dataLeitura,
        dados.minutosLidos !== undefined ? dados.minutosLidos * 60 : atual.duracao_segundos,
        dados.anotacoes !== undefined ? dados.anotacoes.trim() : atual.anotacoes,
        id,
        dados.usuarioId,
      ],
    );

    const registro = await this.buscarDoUsuario(id, dados.usuarioId);
    return { mensagem: 'Registro de leitura atualizado com sucesso!', registro };
  }

  // ------------------------------------------------------------------ RF 013
  // A confirmação do usuário (passo 1 e 2 / A1 cancelamento) é feita na tela; a API
  // só recebe o pedido já confirmado.
  async excluir(id: number, usuarioId: number) {
    await this.exigirUsuarioAtivo(usuarioId);
    await this.buscarDoUsuario(id, usuarioId); // 404/403 se não for o autor

    await this.databaseService.query(
      'DELETE FROM registros_leitura WHERE id = $1 AND usuario_id = $2',
      [id, usuarioId],
    );

    // "Recalcula o progresso de leitura": não há progresso persistido nesta versão
    // (nada a recalcular). Pendência documentada.
    return { mensagem: 'Registro de leitura excluído com sucesso!' };
  }

  // ------------------------------------------------------------- auxiliares
  private async exigirUsuarioAtivo(usuarioId: number) {
    const r = await this.databaseService.query(
      'SELECT id FROM usuarios WHERE id = $1 AND ativo = true',
      [usuarioId],
    );
    if (r.rows.length === 0) {
      throw new UnauthorizedException(
        'Usuário não autenticado ou conta inexistente/desativada.',
      );
    }
  }

  private exigirDataValida(data: string) {
    if (!lerDataCivil(data)) {
      throw new BadRequestException('A data da leitura informada é inválida.');
    }
  }

  private exigirPaginasDentroDoTotal(paginasLidas: number, total: number | null) {
    if (total !== null && paginasLidas > total) {
      throw new BadRequestException(
        `As páginas lidas (${paginasLidas}) excedem o total de páginas do livro (${total}).`,
      );
    }
  }

  // Devolve o registro se for do usuário; 404 se não existir; 403 se for de outro.
  private async buscarDoUsuario(id: number, usuarioId: number) {
    const r = await this.databaseService.query(`${SELECT_REGISTRO} WHERE r.id = $1`, [id]);
    const registro = r.rows[0];
    if (!registro) {
      throw new NotFoundException('Registro de leitura não encontrado.');
    }
    if (registro.usuario_id !== usuarioId) {
      throw new ForbiddenException('Você só pode acessar os seus próprios registros.');
    }
    return registro;
  }
}
