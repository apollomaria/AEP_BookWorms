CREATE DATABASE BOOKWORMS_AEP;
USE BOOKWORMS_AEP;

CREATE TABLE USUARIO (
	id_usuario int,
    usuario varchar(30) not null,
    data_nascimento DATE not null,
    email varchar(100) not null,
    senha varchar(40) not null,
    tipo varchar(20)
);


CREATE TABLE REGISTRO_LEITURA (
	id_registro_leitura int,
    id_usuario int,
    id_livro int,
    qtd_pagina_lida int not null,
    data_lida date not null
);

CREATE TABLE CLUBE_LEITURA (
	id_clube_leitura int,
    id_livro int,
    qtd_membros int not null
);

CREATE TABLE LIVRO (
	id_livro int,
    autor varchar(60) not null,
    isbn varchar(13) unique not null,
	qtd_pag int not null,
    genero varchar(50)
);

CREATE TABLE INSCRICAO_LEITURA (
	id_usuario int, 
    id_clube_leitura int,
    data_inscricao date not null
);

CREATE TABLE INSCRICAO_FORUM (
	id_usuario int, 
    id_forum int,
    data_inscricao date not null
);

CREATE TABLE QUIZ (
	id_quiz int,
    id_criador int,
    topico varchar(25)
);

CREATE TABLE FORUM (
	id_forum int,
    id_livro int,
    qtd_membro int
);

CREATE TABLE COMENTARIO (
	id_comentario int,
    id_usuario int,
    id_forum int,
    qtd_estrela int not null
);

CREATE TABLE RANKING (
	id_ranking int,
    id_usuario int, -- fk
    qtd_hora int not null,
    qtd_exp int not null,
    qtd_pag int not null,
    qtd_livro int not null
);

-- DEFINIÇÃO DAS PRIMARY KEYS
ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY (id_usuario);
ALTER TABLE registro_leitura ADD CONSTRAINT registro_leitura_pk PRIMARY KEY (id_registro_leitura);
ALTER TABLE clube_leitura ADD CONSTRAINT clube_leitura_pk PRIMARY KEY (id_clube_leitura);
ALTER TABLE livro ADD CONSTRAINT livro_pk PRIMARY KEY (id_livro);
ALTER TABLE quiz ADD CONSTRAINT quiz_pk PRIMARY KEY (id_quiz);
ALTER TABLE forum ADD CONSTRAINT forum_pk PRIMARY KEY (id_forum);
ALTER TABLE comentario ADD CONSTRAINT comentario_pk PRIMARY KEY (id_comentario);
ALTER TABLE ranking ADD CONSTRAINT ranking_pk PRIMARY KEY (id_ranking);


-- DEFINIÇÃO DAS FOREIGN KEY
ALTER TABLE REGISTRO_LEITURA ADD CONSTRAINT registro_leitura_id_usuario_fk foreign key (id_usuario) REFERENCES usuario (id_usuario);
ALTER TABLE REGISTRO_LEITURA ADD CONSTRAINT registro_leitura_id_livro_fk foreign key (id_livro) REFERENCES livro (id_livro);

ALTER TABLE INSCRICAO_LEITURA ADD CONSTRAINT inscricao_leitura_id_usuario_fk foreign key (id_usuario) REFERENCES usuario (id_usuario);
ALTER TABLE INSCRICAO_LEITURA ADD CONSTRAINT inscricao_leitura_id_clube_leitura_fk foreign key (id_clube_leitura) REFERENCES clube_leitura (id_clube_leitura);

ALTER TABLE INSCRICAO_FORUM ADD CONSTRAINT inscricao_forum_id_usuario_fk foreign key (id_usuario) REFERENCES usuario (id_usuario);
ALTER TABLE INSCRICAO_FORUM ADD CONSTRAINT inscricao_forum_id_forum_fk foreign key (id_forum) REFERENCES forum (id_forum);

ALTER TABLE FORUM ADD CONSTRAINT forum_id_livro_fk FOREIGN KEY (id_livro) REFERENCES Livro (id_livro);

ALTER TABLE CLUBE_LEITURA ADD CONSTRAINT clube_leitura_id_usuario_fk foreign key (id_livro) REFERENCES livro (id_livro);

ALTER TABLE QUIZ ADD CONSTRAINT quiz_id_usuario_fk foreign key (id_criador) REFERENCES usuario (id_usuario);

ALTER TABLE COMENTARIO ADD CONSTRAINT comentario_id_usuario_fk foreign key (id_usuario) REFERENCES usuario (id_usuario);
ALTER TABLE COMENTARIO ADD CONSTRAINT comentario_id_forum_fk FOREIGN KEY (id_forum) REFERENCES forum (id_forum);

ALTER TABLE RANKING ADD CONSTRAINT ranking_id_usuario_fk FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario);

