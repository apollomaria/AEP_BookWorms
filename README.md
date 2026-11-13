
# BOOKWORMS
##### [Contextualização](#contextualização) - [Escopo](#escopo-do-projeto) - [Cronograma](#cronograma-de-execução) - [Atribuições](#atribuições) - [Justificativa](#justificativa-técnica) - [Diagrama UML](#diagrama-de-classes-uml) - [DER](#diagrama-de-banco-de-dados-der) - [Referências](#referências-bibliográficas)
#

### Contextualização

        Segundo ROCHA (2025), o hábito de leitura no cenário brasileiro está em queda, pois, em um país com mais de 200 milhões de habitantes, os não leitores representam 53% da população. De 2007 para 2024 o percentual de leitores caiu em 8%, correspondendo a 47% da população brasileira. Observa-se não apenas uma queda no percentual de leitores, mas também uma drástica diminuição da capacidade de concentração e compreensão. Esse cenário mostra o avanço do analfabetismo funcional, que se trata da dificuldade em interpretar textos simples e praticar não só a leitura como a escrita no dia a dia. Como consequência, há impactos no desenvolvimento pessoal, especialmente no pensamento crítico e na participação plena na sociedade.

        Além disso, em uma publicação no site da Companhia das Letras, são apresentados dados sobre o aumento do uso das redes sociais e, consequentemente, a substituição da leitura como forma de lazer. De 2007 para 2024, entre as dificuldades para ler apontadas pelos entrevistados, a falta de paciência subiu de 11% para 25%, e a falta de concentração passou de 7% para 14%, no mesmo período em que o uso da internet no tempo livre saltou de 7% para 78% (COMPANHIA DAS LETRAS, 2024).	

        A considerar os dados acima e a ODS 4 da ONU, que tem como objetivo assegurar a educação inclusiva, equitativa e de qualidade, além de promover oportunidades de aprendizagem ao longo da vida para todas e todos, o BookWorms surge como uma proposta para estimular o hábito de leitura através da gamificação, competição e socialização desse passa tempo, motivando as pessoas a saírem de redes sociais, como Reels do Instagram, Tiktok e Youtube Shorts e interagirem em uma comunidade virtual de leitura.
	
        Após uma pesquisa de mercado, feita em salas de aula e através de um Formulário Google (com 109 respostas), o público-alvo (jovens adultos e adolescentes) validou e mostrou-se interessado no desenvolvimento do projeto.

#

### Escopo do Projeto
* **RF-001:** Permitir que o usuário crie registros de leitura;
* **RF-002:** Permitir que o usuário crie e cumpra metas pessoais;
* **RF-003:** Permitir que o usuário crie clubes de leitura;
* **RF-004:** Permitir que o usuário defina qual será a leitura do clube (decisão do líder do clube, decisão da maioria ou aleatório);
* **RF-005:** Permitir que o usuário edite informações do clube;
* **RF-006:** Permitir que o usuário entre em vários clubes;
* **RF-007:** Permitir que o usuário exclua o clube;
* **RF-008:** Permitir que o usuário crie metas no clube;
* **RF-009:** Permitir que o usuário consulte e participe de rankings gamificados;
* **RF-010:** Permitir que o usuário responda formulários com questões relacionadas aos livros lidos;
* **RF-011:** Permitir que o usuário publique comentários em fóruns específicos para cada livro;

#

### Cronograma de Execução
<img width="637" height="687" alt="image" src="https://github.com/user-attachments/assets/70f13f90-68fd-459a-bf53-055f857ccf1b" />


* As Sprints ocorrerão semanalmente, com a data inicial exata a ser definida.

### Atribuições

| **BACK END** | **FRONT END** | **BANCO DE DADOS** | **TESTES** | **ARTEFATOS** |
|:------------:|:-------------:|:------------------:|:----------:|:-------------:|
|    Nicole    |     Milton    |       Mateus       |   Apollo   |     Apollo    |


* Gerente de Projeto: Apollo
* Scrum Master: Apollo


#



### Justificativa Técnica

        A linguagem escolhida para o Backend foi o TypeScript em conjunto com o framework NestJS sobre o ambiente Node.js, enquanto no Frontend optou-se pelo React com JavaScript e CSS. O ecossistema Node.js e TypeScript possui código aberto e uma comunidade muito ativa, garantindo evolução constante, boa performance e estabilidade para o projeto BookWorms. Mantido pela Microsoft, o TypeScript adiciona tipagem estática e forte ao JavaScript, o que, somado à arquitetura modular do NestJS, torna o desenvolvimento de aplicações web mais organizado e seguro, permitindo aplicar na prática os pilares da Programação Orientada a Objetos (Abstração, Herança, Polimorfismo e Encapsulamento) por meio de classes, interfaces e injeção de dependência.

        Sobre o banco de dados, o projeto utiliza o gerenciador relacional PostgreSQL comunicando-se com a aplicação sob o padrão arquitetural API REST. Por ser um dos bancos de dados relacionais de código aberto mais consolidados do mercado, o PostgreSQL conta com uma documentação ampla que cobre desde configurações básicas até recursos avançados de integridade e transações. Além disso, oferece ótimos mecanismos de segurança e confiabilidade, assegurando que apenas usuários autorizados tenham acesso ao servidor, com suporte a diferentes níveis de permissão e validação rigorosa das regras directas nas tabelas.

        A equipe escolheu um banco de dados relacional por levar em conta que os requisitos do projeto estão fortemente conectados entre si, como o vínculo direto entre Usuário, Clube de Leitura e Registros de Leitura. Da mesma forma, o uso de TypeScript, NestJS e React, por serem tecnologias amplamente adotadas atualmente, facilita o acesso a materiais de estudo, fóruns e documentação, ajudando o grupo na busca por soluções durante o desenvolvimento. Por último, como a equipe ainda está em formação na área de desenvolvimento de software, optou-se por trabalhar com ferramentas baseadas na linguagem JavaScript, com a qual os integrantes já possuem maior familiaridade e que apresentam grande demanda no mercado de trabalho.


#

### Diagrama de Classes (UML)

<img width="1600" height="1072" alt="WhatsApp Image 2026-11-13 at 16 17 53" src="https://github.com/user-attachments/assets/22fea5a4-d560-40c9-838b-b6640b8b62c7" /><br>

- **HERANÇA:** as classes `Lider_Clube` e `Membro` herdam de `Usuario` atributos e métodos, pois são um tipo de `Usuario`, porém possuem suas próprias ações dentro do sistema.
- **COMPOSIÇÃO 1:N (Forum e Comentario):** 0 ou muitos `Comentario` compõem um `Forum`. Se o `Forum` deixar de existir, os `Comentario` que o compõem também deixam.
- **COMPOSIÇÃO 1:N (Usuario e Infracao):** 0 ou muitas `Infracao` compõem um `Usuario`. Se o `Usuario` deixar de existir, suas `Infracao` também deixam.
- **COMPOSIÇÃO 1:1 (Livro e Forum):** o `Livro` compõe o `Forum`, o que significa que cada `Livro` possui um único `Forum`. Se o `Livro` deixar de existir, o `Forum` também é apagado.
- **ASSOCIAÇÃO:** `Usuario` se relaciona com `Registro_Leitura`, `Forum` e `Clube_Leitura`, e `Registro_Leitura` se relaciona com `Livro`. Os relacionamentos de muitos para muitos entre `Usuario` e `Clube_Leitura` e entre `Usuario` e `Forum` são resolvidos pelas classes associativas `Inscricao_Leitura` e `Inscricao_Forum`. `Lider_Clube` se associa a `Clube_Leitura` (1:1) e a `Quiz` (1:0..*).
- **CLASSE ABSTRATA:** `Ranking` é uma classe abstrata, cujos métodos `consultarRanking()` e `calcularPontuacao()` não têm implementação própria e precisam ser implementados pelas subclasses.
- **POLIMORFISMO:** está presente na classe `Ranking`, onde `RankingHora`, `RankingEXP`, `RankingPagina` e `RankingLivro` herdam de `Ranking` atributos e métodos, que são executados de forma diversificada para cada tipo de ranking. Também ocorre no método `sairClube()`, definido em `Usuario` e implementado de forma diferente por `Lider_Clube` e `Membro`.

#
### Diagrama de Banco de Dados (DER)


<img width="1600" height="1085" alt="WhatsApp Image 2026-11-13 at 16 18 07" src="https://github.com/user-attachments/assets/27b5908f-d546-426f-ae2e-d1b32521e66e" /><br>


- **Tabela Usuario:** dados necessários do usuário;
- **Tabela Registro de Leitura:** registra os dados que serão informados pelo usuário a cada "sessão" de leitura realizada;
- **Tabela Clube de Leitura:** registro dos clubes existentes com tabela associativa para os membros inscritos em si;
- **Tabela Livro:** cadastro de livros que serão utilizados como foreign key para o livro escolhido na sessão de livro escolhido do grupo e do livro lido pelo usuário no registro;
- **Tabela Inscricao_Leitura (Associativa), chamada `clube_membros` no DER:** resolve o relacionamento de muitos para muitos entre Usuários e Clubes de Leitura, pois armazena `usuario_id` e `clube_id` como chave primária composta, além da data de entrada no clube (`entrou_em`);
- **Tabela Inscricao_Forum (Associativa):** resolve o relacionamento de muitos para muitos entre Usuários e Fóruns, pois armazena `id_usuario` e `id_forum`, além da data de inscrição (`data_inscricao`);
- **Tabela Quiz:** baseada na RF10, são os formulários que os usuários poderão responder e serão criados pelos líderes dos clubes, por isso `id_criador` como foreign key de Usuario;
- **Tabela Ranking:** tabela única "pai" com colunas discriminatórias (`qtd_hora`, `qtd_exp`, `qtd_pag`, `qtd_livro`) para diferenciar as classes filhas distintas da herança, com `id_usuario` como foreign key de Usuario, já que cada registro de ranking pertence a um usuário;
- **Tabela Forum:** cadastro dos fóruns de discussão, vinculados a um livro (`id_livro` como foreign key de Livro) e com o contador de membros inscritos (`qtd_membro`);
- **Tabela Comentario:** registra as mensagens publicadas pelos usuários dentro de um fórum, por isso `id_usuario` e `id_forum` como foreign keys, além do conteúdo do comentário e da quantidade de estrelas recebidas (`qtd_estrela`);
- **Tabela Infracoes:** registra as infrações cometidas pelos usuários, armazenando o motivo, se a infração está ativa e a data de criação (`criada_em`), com `usuario_id` como foreign key de Usuario.


#
### Referências Bibliográficas

COMPANHIA DAS LETRAS. Não-leitores são maioria no Brasil pela primeira vez, 2024. Disponível em: https://www.companhiadasletras.com.br/blogDaLetrinhas/Post/6903/ 

ROCHA, L. Cultura da leitura em declínio e o avanço do analfabetismo funcional no Brasil, 2025. Disponível em: https://www12.senado.leg.br/noticias/infomaterias/2025/10/cultura-da-leitura-em-declinio-e-o-avanco-do-analfabetismo-funcional-no-brasil 

=======
# 📚 BookWorms — MVP

App social e gamificado de leitura. Esta versão (MVP) tem:

- **Conta:** cadastro, login e consulta de conta.
- **Registros de leitura:** criar, listar, editar e excluir.

```
backend/    API em NestJS + TypeScript, conversa com o PostgreSQL (biblioteca pg, SQL direto, sem ORM)
frontend/   Site em React + Vite
database/   bookworms_schema.sql — o único arquivo SQL do projeto (todas as tabelas)
README.md   este arquivo
```

Como as peças se conectam:

```
Navegador (frontend, porta 5173)  →  API (backend, porta 3000)  →  PostgreSQL (porta 5432)
```

---

## 1. O que instalar (Windows, macOS ou Linux)

| Programa | Versão | Onde baixar |
|---|---|---|
| **Node.js** (já inclui o `npm`) | 22 ou superior (LTS). Só para rodar os testes automáticos é preciso 24.9+ | https://nodejs.org |
| **PostgreSQL** | 14 ou superior | https://www.postgresql.org/download |
| **Git** (para clonar o projeto) | qualquer | https://git-scm.com |
| Editor (opcional) | VS Code | https://code.visualstudio.com |

Instalando o PostgreSQL:
- **Windows:** use o instalador oficial. Ele pede uma senha para o superusuário `postgres`: **anote-a** (é só sua). Mantenha a porta **5432**. Ele instala também o **SQL Shell (psql)**.
- **macOS:** `brew install postgresql@16 && brew services start postgresql@16` (ou o app Postgres.app).
- **Linux (Ubuntu/Debian):** `sudo apt update && sudo apt install -y postgresql postgresql-contrib`.

Confira no terminal (no Windows: PowerShell ou Prompt de Comando):
```bash
node -v        # deve mostrar v22 ou maior
npm -v
psql --version # se "não reconhecido" no Windows, use o "SQL Shell (psql)" do menu Iniciar
```

> **Terminal:** os comandos abaixo funcionam em qualquer sistema, salvo onde indicado.

---

## 2. Banco de dados

### 2.1 Entrar no PostgreSQL como administrador
- **Linux:** `sudo -u postgres psql`
- **macOS:** `psql postgres`
- **Windows:** abra o **SQL Shell (psql)**, aperte Enter nas perguntas (servidor, banco, porta, usuário `postgres`) e digite a senha que você definiu na instalação. (Ou, no terminal: `psql -U postgres`.)

### 2.2 Criar o usuário e o banco
Dentro do `psql`, troque `escolha_sua_senha` por uma senha **sua** (ela só existirá na sua máquina):
```sql
CREATE USER bookworms_user WITH PASSWORD 'escolha_sua_senha';
CREATE DATABASE bookworms OWNER bookworms_user;
\q
```
O `OWNER bookworms_user` é importante: assim o usuário é dono das tabelas e não precisa de permissões extras.

### 2.3 Criar as tabelas
Na pasta do projeto (a que tem `README.md`):
```bash
psql -h localhost -U bookworms_user -d bookworms -f database/bookworms_schema.sql
```
A senha é digitada no prompt (nada aparece enquanto você digita; é normal).

### 2.4 Conferir
```bash
psql -h localhost -U bookworms_user -d bookworms -c "\dt"
```
Devem aparecer 5 tabelas: `clube_membros`, `clubes`, `infracoes`, `registros_leitura`, `usuarios`.

---

## 3. Backend (API)

```bash
cd backend
```
Crie o arquivo `.env` a partir do modelo:

| Sistema | Comando |
|---|---|
| Linux / macOS | `cp .env.example .env` |
| Windows (Prompt de Comando) | `copy .env.example .env` |
| Windows (PowerShell) | `Copy-Item .env.example .env` |

Abra o `.env` no editor e preencha com os **seus** dados locais:
```
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=bookworms_user
DB_PASSWORD=a_senha_que_voce_escolheu_no_passo_2.2
DB_DATABASE=bookworms
PORT=3000
CORS_ORIGIN=http://localhost:5173
```
Depois:
```bash
npm install
npm run start:dev
```
Deixe esse terminal aberto. Teste no navegador: http://localhost:3000/users/teste-conexao — deve aparecer algo como `{"banco":"bookworms","usuario":"bookworms_user"}`.

---

## 4. Frontend (site)

Abra **outro terminal**:
```bash
cd frontend
```
Crie o `.env` (mesmos comandos de cópia da tabela acima) — o conteúdo padrão já serve:
```
VITE_API_URL=http://localhost:3000
```
```bash
npm install
npm run dev
```
Abra **http://localhost:5173** no navegador.

---

## 5. Como testar se está tudo conectado

1. Acesse `http://localhost:5173/#/criar-conta`, preencha (com a data de nascimento) e clique em **Criar Conta**.
2. Confira que o usuário foi gravado no banco:
   ```bash
   psql -h localhost -U bookworms_user -d bookworms -c "SELECT id, nome_usuario, email, data_nascimento FROM usuarios;"
   ```
3. Saia da conta e entre pelo botão **Login** (e-mail ou nome de usuário). Uma senha errada deve ser recusada.
4. Em `http://localhost:5173/#/criar-registro`, crie um registro de leitura. Recarregue a página (F5): ele continua lá, porque vem do banco.
5. Confira no banco:
   ```bash
   psql -h localhost -U bookworms_user -d bookworms -c "SELECT id, usuario_id, titulo_livro, paginas_lidas, data_leitura FROM registros_leitura;"
   ```

Testes automáticos do backend (não usam o seu banco; exigem Node 24.9+):
```bash
cd backend
npm test
npm run test:e2e
```

---

## 6. Rotas da API (backend)

| Método e rota | O que faz |
|---|---|
| `POST /users/cadastro` | cria conta (`nome, email, dataNascimento, senha, confirmarSenha`) |
| `POST /auth/login` | login (`login` = e-mail ou nome de usuário, `senha`) |
| `GET /users/:id` | consulta a conta |
| `POST /reading-logs` | cria registro de leitura |
| `GET /reading-logs/user/:usuarioId` | lista os registros do usuário |
| `GET /reading-logs/:id?usuarioId=` | detalha um registro |
| `PUT /reading-logs/:id` | edita (só o autor) |
| `DELETE /reading-logs/:id?usuarioId=` | exclui (só o autor) |

---

## 7. Erros comuns

| Sintoma | Causa provável | O que fazer |
|---|---|---|
| Site mostra "Não foi possível conectar ao servidor" (`ECONNREFUSED`, `Failed to fetch`) | backend desligado, ou `VITE_API_URL` errada | inicie o backend (passo 3); confira `frontend/.env` e reinicie o `npm run dev` |
| Erro de **CORS** no console do navegador | site aberto em outro endereço (ex.: `127.0.0.1:5173`) | abra por `http://localhost:5173` ou ajuste `CORS_ORIGIN` no `backend/.env` |
| `password authentication failed` no backend | senha do `backend/.env` diferente da do usuário do banco | corrija o `.env` e reinicie o backend |
| `ECONNREFUSED 127.0.0.1:5432` | PostgreSQL parado ou porta diferente | inicie o serviço do PostgreSQL; confira `DB_PORT` |
| `relation "..." does not exist` | tabelas não criadas | rode o passo 2.3 |
| `relation "..." already exists` ao rodar o `.sql` | o banco já tem as tabelas (você já rodou o passo 2.3) | não precisa rodar de novo; para recomeçar, apague e recrie o banco vazio (`DROP DATABASE bookworms;` e o passo 2.2, só na sua máquina de teste) |
| `permission denied for table ...` | banco criado com outro dono | recrie o banco com `OWNER bookworms_user` (passo 2.2) |
| `psql` não reconhecido (Windows) | psql fora do PATH | use o **SQL Shell (psql)** ou adicione `C:\Program Files\PostgreSQL\<versão>\bin` ao PATH |
| Mudei o `.env` e nada mudou | o `.env` só é lido ao iniciar | pare (Ctrl+C) e inicie de novo |
| **404** | rota errada ou backend antigo rodando | reinicie o backend |
| **400** | dado inválido | a tela mostra a mensagem |
| **401** | senha/usuário incorretos | confira os dados |
| **403** | conta desativada, ou registro de outra pessoa | esperado pelas regras |
| **409** | e-mail ou nome de usuário já cadastrados | use outros |
| **500** | erro no servidor/banco | veja o terminal do backend |

---

## 8. Estado do projeto e limitações

- **Funcionando e ligado ao banco:** cadastro, login, consulta de conta, registros de leitura.
- **Clubes:** as tabelas existem no banco, mas as telas de clubes **ainda não** usam o backend (mostram dados locais que somem ao recarregar). Posts, metas, livros e ranking também ainda não estão ligados.
- **Sem token de login (JWT):** o site envia o `usuarioId` nas requisições; quem souber um id consegue agir como aquele usuário pela API. Serve para o MVP/estudo, **não** para produção.
- **EXP/nível:** os documentos não definem a regra de cálculo, então registrar leitura **não** altera o EXP.
- O backend não exige tamanho mínimo de senha (a tela exige 8 caracteres).

