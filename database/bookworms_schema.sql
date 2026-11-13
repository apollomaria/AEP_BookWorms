-- =============================================================================
-- BookWorms — banco de dados completo (PostgreSQL 14 ou superior)
--
-- Cria todas as tabelas, chaves, índices e regras do projeto, para quem está
-- começando do zero. Rode em um banco NOVO e VAZIO (o README.md explica como).
--
-- Tabelas: usuarios, registros_leitura, clubes, clube_membros, infracoes.
-- =============================================================================

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';


--
-- Name: clube_membros; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clube_membros (
    usuario_id integer NOT NULL,
    clube_id integer NOT NULL,
    entrou_em timestamp with time zone DEFAULT now() NOT NULL,
    papel character varying(10) DEFAULT 'membro'::character varying NOT NULL,
    CONSTRAINT clube_membros_papel_check CHECK (papel IN ('lider', 'membro'))
);


--
-- Name: clubes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clubes (
    id integer NOT NULL,
    nome character varying(60) NOT NULL,
    descricao text DEFAULT ''::text NOT NULL,
    padrao boolean DEFAULT false NOT NULL,
    tipo_acesso character varying(10) DEFAULT 'publico'::character varying NOT NULL,
    CONSTRAINT clubes_tipo_acesso_check CHECK (tipo_acesso IN ('publico', 'privado'))
);


--
-- Name: clubes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clubes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clubes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.clubes_id_seq OWNED BY public.clubes.id;


--
-- Name: infracoes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.infracoes (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    motivo text NOT NULL,
    ativa boolean DEFAULT true NOT NULL,
    criada_em timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: infracoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.infracoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: infracoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.infracoes_id_seq OWNED BY public.infracoes.id;


--
-- Name: registros_leitura; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.registros_leitura (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    titulo_livro character varying(255) NOT NULL,
    paginas_lidas integer NOT NULL,
    total_paginas integer,
    data_leitura date NOT NULL,
    observacoes text,
    duracao_segundos integer DEFAULT 0 NOT NULL,
    criado_em timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    atualizado_em timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT paginas_validas CHECK ((paginas_lidas <= total_paginas)),
    CONSTRAINT registros_leitura_duracao_segundos_check CHECK ((duracao_segundos >= 0)),
    CONSTRAINT registros_leitura_paginas_lidas_check CHECK ((paginas_lidas > 0)),
    CONSTRAINT registros_leitura_total_paginas_check CHECK ((total_paginas > 0))
);


--
-- Name: registros_leitura_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.registros_leitura_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: registros_leitura_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registros_leitura_id_seq OWNED BY public.registros_leitura.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nome_usuario character varying(20) NOT NULL,
    email character varying(254) NOT NULL,
    senha_hash text NOT NULL,
    data_nascimento date NOT NULL,
    nivel integer DEFAULT 1 NOT NULL,
    exp integer DEFAULT 0 NOT NULL,
    foto_perfil text,
    banner text,
    bio character varying(500) DEFAULT ''::character varying NOT NULL,
    tema character varying(20) DEFAULT 'claro'::character varying NOT NULL,
    verificada boolean DEFAULT false NOT NULL,
    codigo_verificacao_hash text,
    codigo_verificacao_expira_em timestamp with time zone,
    privacidade_definida boolean DEFAULT false NOT NULL,
    priv_registros character varying(10) DEFAULT 'publico'::character varying NOT NULL,
    priv_estatisticas character varying(10) DEFAULT 'publico'::character varying NOT NULL,
    priv_clubes character varying(10) DEFAULT 'publico'::character varying NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    criado_em timestamp with time zone DEFAULT now() NOT NULL,
    atualizado_em timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT usuarios_priv_clubes_check CHECK (((priv_clubes)::text = ANY ((ARRAY['publico'::character varying, 'seguidores'::character varying, 'privado'::character varying])::text[]))),
    CONSTRAINT usuarios_priv_estatisticas_check CHECK (((priv_estatisticas)::text = ANY ((ARRAY['publico'::character varying, 'seguidores'::character varying, 'privado'::character varying])::text[]))),
    CONSTRAINT usuarios_priv_registros_check CHECK (((priv_registros)::text = ANY ((ARRAY['publico'::character varying, 'seguidores'::character varying, 'privado'::character varying])::text[]))),
    CONSTRAINT usuarios_tema_check CHECK (((tema)::text = ANY ((ARRAY['claro'::character varying, 'escuro'::character varying])::text[])))
);


--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: clubes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clubes ALTER COLUMN id SET DEFAULT nextval('public.clubes_id_seq'::regclass);


--
-- Name: infracoes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.infracoes ALTER COLUMN id SET DEFAULT nextval('public.infracoes_id_seq'::regclass);


--
-- Name: registros_leitura id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registros_leitura ALTER COLUMN id SET DEFAULT nextval('public.registros_leitura_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Name: clube_membros clube_membros_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clube_membros
    ADD CONSTRAINT clube_membros_pkey PRIMARY KEY (usuario_id, clube_id);


--
-- Name: clubes clubes_nome_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clubes
    ADD CONSTRAINT clubes_nome_key UNIQUE (nome);


--
-- Name: clubes clubes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clubes
    ADD CONSTRAINT clubes_pkey PRIMARY KEY (id);


--
-- Name: infracoes infracoes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.infracoes
    ADD CONSTRAINT infracoes_pkey PRIMARY KEY (id);


--
-- Name: registros_leitura registros_leitura_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registros_leitura
    ADD CONSTRAINT registros_leitura_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: clube_membros_um_lider_uq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX clube_membros_um_lider_uq ON public.clube_membros USING btree (clube_id) WHERE ((papel)::text = 'lider'::text);


--
-- Name: idx_registros_leitura_usuario; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_registros_leitura_usuario ON public.registros_leitura USING btree (usuario_id);


--
-- Name: usuarios_email_uq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX usuarios_email_uq ON public.usuarios USING btree (lower((email)::text));


--
-- Name: usuarios_nome_usuario_uq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX usuarios_nome_usuario_uq ON public.usuarios USING btree (lower((nome_usuario)::text));


--
-- Name: clube_membros clube_membros_clube_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clube_membros
    ADD CONSTRAINT clube_membros_clube_id_fkey FOREIGN KEY (clube_id) REFERENCES public.clubes(id) ON DELETE CASCADE;


--
-- Name: clube_membros clube_membros_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clube_membros
    ADD CONSTRAINT clube_membros_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: infracoes infracoes_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.infracoes
    ADD CONSTRAINT infracoes_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: registros_leitura registros_leitura_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registros_leitura
    ADD CONSTRAINT registros_leitura_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;
