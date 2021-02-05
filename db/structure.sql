SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: achievements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.achievements (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description character varying NOT NULL,
    pones_count integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT now() NOT NULL
);


--
-- Name: achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.achievements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.achievements_id_seq OWNED BY public.achievements.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: boons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.boons (
    id bigint NOT NULL,
    pone_id bigint NOT NULL,
    granted_by_id bigint NOT NULL,
    reason character varying,
    points_count integer NOT NULL,
    created_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT now() NOT NULL
);


--
-- Name: boons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.boons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: boons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.boons_id_seq OWNED BY public.boons.id;


--
-- Name: pone_credentials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pone_credentials (
    id bigint NOT NULL,
    type character varying NOT NULL,
    pone_id bigint NOT NULL,
    data jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT now() NOT NULL
);


--
-- Name: pone_credentials_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pone_credentials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pone_credentials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pone_credentials_id_seq OWNED BY public.pone_credentials.id;


--
-- Name: pones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pones (
    id bigint NOT NULL,
    name public.citext NOT NULL,
    slug character varying NOT NULL,
    points_count integer DEFAULT 0 NOT NULL,
    daily_giftable_points_count integer DEFAULT 0 NOT NULL,
    verified_at timestamp without time zone,
    created_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT now() NOT NULL
);


--
-- Name: pones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pones_id_seq OWNED BY public.pones.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: achievements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievements ALTER COLUMN id SET DEFAULT nextval('public.achievements_id_seq'::regclass);


--
-- Name: boons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.boons ALTER COLUMN id SET DEFAULT nextval('public.boons_id_seq'::regclass);


--
-- Name: pone_credentials id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pone_credentials ALTER COLUMN id SET DEFAULT nextval('public.pone_credentials_id_seq'::regclass);


--
-- Name: pones id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pones ALTER COLUMN id SET DEFAULT nextval('public.pones_id_seq'::regclass);


--
-- Name: achievements achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: boons boons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.boons
    ADD CONSTRAINT boons_pkey PRIMARY KEY (id);


--
-- Name: pone_credentials pone_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pone_credentials
    ADD CONSTRAINT pone_credentials_pkey PRIMARY KEY (id);


--
-- Name: pones pones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pones
    ADD CONSTRAINT pones_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_achievements_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_achievements_on_name ON public.achievements USING btree (name);


--
-- Name: index_boons_on_granted_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_boons_on_granted_by_id ON public.boons USING btree (granted_by_id);


--
-- Name: index_boons_on_pone_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_boons_on_pone_id ON public.boons USING btree (pone_id);


--
-- Name: index_pone_credentials_on_pone_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pone_credentials_on_pone_id ON public.pone_credentials USING btree (pone_id);


--
-- Name: index_pones_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_pones_on_name ON public.pones USING btree (name);


--
-- Name: index_pones_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_pones_on_slug ON public.pones USING btree (slug);


--
-- Name: pone_credentials fk_rails_11e792e613; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pone_credentials
    ADD CONSTRAINT fk_rails_11e792e613 FOREIGN KEY (pone_id) REFERENCES public.pones(id);


--
-- Name: boons fk_rails_6d75f2081e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.boons
    ADD CONSTRAINT fk_rails_6d75f2081e FOREIGN KEY (pone_id) REFERENCES public.pones(id);


--
-- Name: boons fk_rails_a46c897fdb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.boons
    ADD CONSTRAINT fk_rails_a46c897fdb FOREIGN KEY (granted_by_id) REFERENCES public.pones(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20210204221112'),
('20210204222146'),
('20210204231345'),
('20210205035320');


