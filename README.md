# BOOKWORMS
#### [Contextualização](#contextualização) - [Escopo do Projeto](#escopo-do-projeto) - [Justificativa Técnica](#justificativa-técnica) - [Referência Bibliográfica](#referência-bibliográfica)
#

### Contextualização

        Segundo ROCHA (2025), o hábito de leitura no cenário brasileiro está em queda, pois, em um país com mais de 200 milhões de habitantes, os não leitores representam 53% da população. De 2007 para 2024 o percentual de leitores caiu em 8%, correspondendo a 47% da população brasileira. Observa-se não apenas uma queda no percentual de leitores, mas também uma drástica diminuição da capacidade de concentração e compreensão. Esse cenário mostra o avanço do analfabetismo funcional, que se trata da dificuldade em interpretar textos simples e praticar não só a leitura como a escrita no dia a dia. Como consequência, há impactos no desenvolvimento pessoal, especialmente no pensamento crítico e na participação plena na sociedade.

        Além disso, em uma publicação no site da Companhia das Letras, são apresentados dados sobre o aumento do uso das redes sociais e, consequentemente, a substituição da leitura como forma de lazer. De 2007 para 2024, entre as dificuldades para ler apontadas pelos entrevistados, a falta de paciência subiu de 11% para 25%, e a falta de concentração passou de 7% para 14%, no mesmo período em que o uso da internet no tempo livre saltou de 7% para 78% (COMPANHIA DAS LETRAS, 2024).	

        A considerar os dados acima e a ODS 4 da ONU, que tem como objetivo assegurar a educação inclusiva, equitativa e de qualidade, além de promover oportunidades de aprendizagem ao longo da vida para todas e todos, o BookWorms surge como uma proposta para estimular o hábito de leitura através da gamificação, competição e socialização desse passa tempo, motivando as pessoas a saírem de redes sociais, como Reels do Instagram, Tiktok e Youtube Shorts e interagirem em uma comunidade virtual de leitura.
	
        Após uma pesquisa de mercado, feita em salas de aula e através de um Formulário Google (com 109 respostas), o público-alvo validou e mostrou-se interessado no desenvolvimento do projeto.

#

### Escopo do Projeto
* RF01 - Permitir que o usuário crie registros de leitura;
* RF02 - Permitir que o usuário crie e cumpra metas pessoais;
* RF03 - Permitir que o usuário crie clubes de leitura;
* RF04 - Permitir que o usuário defina qual será a leitura do clube (decisão do líder do clube, decisão da maioria ou aleatório);
* RF05 - Permitir que o usuário edite informações do clube;
* RF06 - Permitir que o usuário entre em vários clubes;
* RF07 - Permitir que o usuário exclua o clube;
* RF08 - Permitir que o usuário crie metas no clube;
* RF09 - Permitir que o usuário consulte e participe de rankings gamificados;
* RF10 - Permitir que o usuário responda formulários com questões relacionadas aos livros lidos;
* RF11 - Permitir que o usuário publique comentários em fóruns específicos para cada livro;

#

### Cronograma de Execução
<img width="637" height="687" alt="image" src="https://github.com/user-attachments/assets/70f13f90-68fd-459a-bf53-055f857ccf1b" />

* A equipe trabalhará unificada nos objetivos, mas de forma simultânea: enquanto um integrante faz o Diagrama de Sequência do RF01, outro faz o do RF02, por exemplo;

* As Sprints ocorrerão semanalmente, com a data inicial exata a ser definida.

#



### Justificativa Técnica

        A linguagem escolhida para o Backend foi o Java, pois seu ecossistema OpenJDK dispõe de uma comunidade ativa e código aberto, garantindo, assim, uma inovação contínua que é uma vantagem para o projeto BookWorms, além de contar com grande estabilidade e performance. Gerenciada pela Oracle, possui um suporte robusto, é extremamente versátil, dominante até em aplicações web, sendo uma das principais linguagens quando se pensa em Programação Orientada a Objetos, dada sua linguagem fortemente tipada e implementação dos Pilares POO (Abstração, Herança, Polimorfismo e Encapsulamento).

        Sobre o banco de dados, o projeto utilizará o relacional MySql sob o padrão arquitetural API REST, como o MySQL se tornou o banco de dados mais popular, possui uma ampla documentação que cobre muitos aspectos de desenvolvimento. Também conta com bons mecanismos de segurança, pois assegura que só pessoas autorizadas possuam acesso ao servidor, além de possibilitar diferentes níveis de permissões a diferentes tipos de usuários.

        A equipe escolheu um banco de dados relacional ao levar em conta que os requisitos do projeto estão fortemente unidos uns aos outros, 	como a conexão direta entre, por exemplo, Usuário, Clube de Leitura e Registros de Leitura e o Java, por ser uma linguagem tão presente no mercado, tem um fácil acesso a materiais de estudo e apoio, o que ajudará a equipe a pesquisar por soluções em suas comunidades. Por último, como a equipe do projeto é nova no desenvolvimento de softwares, também preferiu optar por utilizar tecnologias que os membros já estão familiarizados, bem como sua aderência no mercado de trabalho.

#

### Diagrama de Classes (UML)

<img width="1048" height="772" alt="WhatsApp Image 2026-09-04 at 09 52 17" src="https://github.com/user-attachments/assets/4fe5777a-daa8-48d6-b39e-4d97dffbcb55" />


* Herança: As classes Lider_Clube e Membro herdam de Usuario atributos e métodos, pois são um tipo de Usuario, porém possuem suas próprias ações dentro do sistema.
* Composição 1:N: A composição 1:N acontece entre as classes de Forum e Comentario, o que significa que 0 ou muitos Comentarios compõem um Forum, se o Forum deixar de existir, os Comentarios que o compõem também deixaram.
* Composição 1:1: A composição 1:1 ocorre entre as classes Livro e Forum, onde o Forum compõe a classe Livro. O que significa que se o Livro existe então existe um único Forum para esse livro, caso ele deixe de existir o Forum também é apagado.
* Polimorfismo: O poliformismo está presente na classe de Ranking, onde RankingHora, RankingEXP, RankingPagina, RankingLivro herdam de Ranking atributos e métodos, que são executados de forma diversificada, para cada tipo de Ranking.

#
### Diagrama de Banco de Dados (DER)

<img width="931" height="816" alt="banco de dados" src="https://github.com/user-attachments/assets/60d56c00-52c8-4d3b-a5df-e810e51c6184" />

* Tabela Usuario: dados necessários do usuário;
* Tabela Registro de Leitura: registra os dados que serão informados pelo usuário a cada "sessão" de leitura realizada;
* Tabela Clube de Leitura: registro dos clubes existentes com tabela associativa para os membros inscritos em si;
* Tabela Livro: cadastro de livros que serão utilizados como foreign key para o livro escolhido na sessão de livro escolhido do grupo e do livro lido pelo usuário no registro;
* Tabela Inscricao_Leitura (Associativa): resolve o relacionamento de muitos para muitos entre Usuários e Clubes de Leituras, pois armazena id_usuario e id_clube_leitura;
* Tabela Inscricao_Forum (Associativa): resolve o relacionamento de muitos para muitos entre Usuários e Fóruns, pois armazena id_usuario e id_forum;
* Tabela Quiz: baseada na RF10, são os formulários que os usuários poderão responder e serão criadas pelos líderes dos clubes, por isso id_criador como foreign key de Usuario;
* Tabela Ranking: tabela única “pai” com colunas discriminatórias (qtd_hora, qtd_exp, qtd_pag, qtd_livro) para diferenciar as classes filhas distintas da herança.

#
### Referência Bibliográfica

COMPANHIA DAS LETRAS. Não-leitores são maioria no Brasil pela primeira vez, 2024. Disponível em: https://www.companhiadasletras.com.br/blogDaLetrinhas/Post/6903/ 

ROCHA, L. Cultura da leitura em declínio e o avanço do analfabetismo funcional no Brasil, 2025. Disponível em: https://www12.senado.leg.br/noticias/infomaterias/2025/10/cultura-da-leitura-em-declinio-e-o-avanco-do-analfabetismo-funcional-no-brasil 
