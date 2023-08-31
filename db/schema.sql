--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9
-- Dumped by pg_dump version 14.9

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
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: actions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.actions (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    uuid text DEFAULT public.uuid_generate_v4() NOT NULL,
    application_id integer NOT NULL,
    type text NOT NULL,
    description text,
    payload text NOT NULL,
    current_status text NOT NULL,
    status_reason text,
    report bytea,
    credential_id integer NOT NULL
);


--
-- Name: actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.actions_id_seq OWNED BY public.actions.id;


--
-- Name: applications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.applications (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    uuid text DEFAULT public.uuid_generate_v4() NOT NULL,
    full_name text NOT NULL,
    description text,
    managed_realm text NOT NULL,
    managed_projects text NOT NULL
);


--
-- Name: applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.applications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.applications_id_seq OWNED BY public.applications.id;


--
-- Name: credentials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credentials (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    uuid text DEFAULT public.uuid_generate_v4() NOT NULL,
    client_key text NOT NULL,
    client_secret text NOT NULL,
    description text,
    is_active boolean DEFAULT true NOT NULL
);


--
-- Name: credentials_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.credentials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: credentials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.credentials_id_seq OWNED BY public.credentials.id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reports (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    server_id integer NOT NULL,
    uuid text DEFAULT public.uuid_generate_v4() NOT NULL,
    subject text NOT NULL,
    body bytea
);


--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- Name: servers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.servers (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    uuid text DEFAULT public.uuid_generate_v4() NOT NULL,
    hostname text NOT NULL,
    ip text NOT NULL,
    latest_version text
);


--
-- Name: servers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.servers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: servers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.servers_id_seq OWNED BY public.servers.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    uuid text DEFAULT public.uuid_generate_v4() NOT NULL,
    access_token text NOT NULL,
    refresh_token text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    email text NOT NULL,
    github_token text NOT NULL,
    category text NOT NULL,
    uuid text DEFAULT public.uuid_generate_v4() NOT NULL,
    passphrase text NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: actions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actions ALTER COLUMN id SET DEFAULT nextval('public.actions_id_seq'::regclass);


--
-- Name: applications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.applications ALTER COLUMN id SET DEFAULT nextval('public.applications_id_seq'::regclass);


--
-- Name: credentials id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credentials ALTER COLUMN id SET DEFAULT nextval('public.credentials_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- Name: servers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servers ALTER COLUMN id SET DEFAULT nextval('public.servers_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: actions actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (id);


--
-- Name: actions actions_uuid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_uuid_key UNIQUE (uuid);


--
-- Name: applications applications_full_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_full_name_key UNIQUE (full_name);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: applications applications_uuid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_uuid_key UNIQUE (uuid);


--
-- Name: credentials credentials_client_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_client_key_key UNIQUE (client_key);


--
-- Name: credentials credentials_client_secret_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_client_secret_key UNIQUE (client_secret);


--
-- Name: credentials credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_pkey PRIMARY KEY (id);


--
-- Name: credentials credentials_uuid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_uuid_key UNIQUE (uuid);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: reports reports_uuid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_uuid_key UNIQUE (uuid);


--
-- Name: servers servers_hostname_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_hostname_key UNIQUE (hostname);


--
-- Name: servers servers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_pkey PRIMARY KEY (id);


--
-- Name: servers servers_uuid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_uuid_key UNIQUE (uuid);


--
-- Name: sessions sessions_access_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_access_token_key UNIQUE (access_token);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_refresh_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_refresh_token_key UNIQUE (refresh_token);


--
-- Name: sessions sessions_uuid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_uuid_key UNIQUE (uuid);


--
-- Name: users users_category_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_category_key UNIQUE (category);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_uuid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_uuid_key UNIQUE (uuid);


--
-- Name: applications_full_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX applications_full_name_index ON public.applications USING btree (full_name);


--
-- Name: applications_uuid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX applications_uuid_index ON public.applications USING btree (uuid);


--
-- Name: credentials_client_key_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX credentials_client_key_index ON public.credentials USING btree (client_key);


--
-- Name: credentials_uuid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX credentials_uuid_index ON public.credentials USING btree (uuid);


--
-- Name: servers_hostname_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX servers_hostname_index ON public.servers USING btree (hostname);


--
-- Name: servers_latest_version_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX servers_latest_version_index ON public.servers USING btree (latest_version);


--
-- Name: servers_uuid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX servers_uuid_index ON public.servers USING btree (uuid);


--
-- Name: sessions_access_token_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX sessions_access_token_index ON public.sessions USING btree (access_token);


--
-- Name: sessions_refresh_token_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX sessions_refresh_token_index ON public.sessions USING btree (refresh_token);


--
-- Name: sessions_uuid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX sessions_uuid_index ON public.sessions USING btree (uuid);


--
-- Name: users_category_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_category_index ON public.users USING btree (category);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: users_uuid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_uuid_index ON public.users USING btree (uuid);


--
-- Name: actions actions_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.applications(id);


--
-- Name: actions actions_credential_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_credential_id_fkey FOREIGN KEY (credential_id) REFERENCES public.credentials(id);


--
-- Name: applications applications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: credentials credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: reports reports_server_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_server_id_fkey FOREIGN KEY (server_id) REFERENCES public.servers(id);


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9
-- Dumped by pg_dump version 14.9

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: earaujoassis
--

CREATE TABLE public.schema_migrations (
    filename text NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO earaujoassis;

--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: earaujoassis
--

COPY public.schema_migrations (filename) FROM stdin;
20190603023609_create_users.rb
20190604040124_add_public_id_to_users.rb
20190604041713_create_applications.rb
20190607040743_create_servers.rb
20190701224547_add_client_key_and_secret_to_users.rb
20190704235004_add_latest_version_string_to_servers.rb
20190705035600_create_reports.rb
20190710024256_additional_fields_for_applications.rb
20190710025334_create_actions.rb
20210612195315_modify_applications_to_gitops.rb
20210613231216_add_passphrase_to_user.rb
20210614033711_create_credentials.rb
20210614044214_associate_actions_to_credentials.rb
20210620040146_users_passphrase_not_null.rb
20210626052930_create_sessions.rb
\.


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: earaujoassis
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (filename);


--
-- PostgreSQL database dump complete
--

