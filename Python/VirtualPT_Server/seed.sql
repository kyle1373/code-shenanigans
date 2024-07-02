--
-- PostgreSQL database dump
--

-- Dumped from database version 14.10
-- Dumped by pg_dump version 16.3

-- Started on 2024-07-01 20:18:40 PDT

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
-- TOC entry 7 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 4405 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 18394)
-- Name: assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assignments (
    assignment_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    patient_id uuid,
    therapist_id uuid,
    exercise_type text,
    exercise_sets text,
    exercise_reps text,
    "timestamp" timestamp without time zone DEFAULT now(),
    active boolean DEFAULT true,
    exercise_duration text,
    active_until timestamp without time zone
);


ALTER TABLE public.assignments OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 19490)
-- Name: dailystatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dailystatus (
    status_id uuid DEFAULT public.uuid_generate_v4(),
    patient_id uuid,
    date timestamp without time zone DEFAULT now(),
    pain text,
    rom text
);


ALTER TABLE public.dailystatus OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 18941)
-- Name: exercises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercises (
    exercise_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    exercise_name text,
    exercise_alt text,
    exercise_type text,
    exercise_url text,
    exercise_key text,
    exercise_int integer NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now()
);


ALTER TABLE public.exercises OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 18940)
-- Name: exercises_exercise_int_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exercises_exercise_int_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exercises_exercise_int_seq OWNER TO postgres;

--
-- TOC entry 4407 (class 0 OID 0)
-- Dependencies: 218
-- Name: exercises_exercise_int_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exercises_exercise_int_seq OWNED BY public.exercises.exercise_int;


--
-- TOC entry 230 (class 1259 OID 20600)
-- Name: manualsegments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manualsegments (
    seg_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    session_id uuid,
    start text,
    stop text,
    user_id uuid,
    "timestamp" timestamp without time zone DEFAULT now()
);


ALTER TABLE public.manualsegments OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 18408)
-- Name: repetitions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.repetitions (
    repetition_id uuid DEFAULT public.uuid_generate_v4(),
    session_id uuid,
    start text,
    stop text,
    result text,
    angle1 text,
    angle2 text,
    feedback1 text,
    feedback2 text,
    "timestamp" timestamp without time zone DEFAULT now()
);


ALTER TABLE public.repetitions OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 18376)
-- Name: sessionlabels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessionlabels (
    rep_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    session_id uuid,
    label_name text,
    label_value text,
    "timestamp" timestamp without time zone DEFAULT now(),
    labeler_id uuid
);


ALTER TABLE public.sessionlabels OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 17876)
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    session_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    s3_url text,
    exercise_type text,
    date timestamp without time zone DEFAULT now(),
    site text,
    pain text,
    rom text,
    subject_id uuid,
    therapist_id text,
    skeletonized boolean DEFAULT false,
    snapshot boolean DEFAULT false
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 18097)
-- Name: skeletons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skeletons (
    skeleton_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    session_id uuid,
    file_name text,
    bbox text,
    skel_2d text,
    skel_3d text,
    "timestamp" timestamp without time zone DEFAULT now()
);


ALTER TABLE public.skeletons OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 20490)
-- Name: useractivity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.useractivity (
    activity_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid,
    activity_type text,
    "timestamp" timestamp without time zone DEFAULT now()
);


ALTER TABLE public.useractivity OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 20499)
-- Name: userprofile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userprofile (
    profile_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid,
    preferred_name text,
    preferred_email text,
    preferred_phone text,
    height text,
    weight text,
    birthday text,
    focus_area text,
    "timestamp" timestamp without time zone DEFAULT now(),
    img_link text
);


ALTER TABLE public.userprofile OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 18385)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_type text,
    user_name text,
    user_email text,
    "timestamp" timestamp without time zone DEFAULT now(),
    therapist_id uuid,
    cognito_id text,
    active boolean DEFAULT false,
    code text,
    push_token text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 19754)
-- Name: users2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users2 (
    user_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_type text,
    user_name text,
    user_email text,
    therapist_id uuid,
    cognito_id text,
    push_token text,
    active boolean DEFAULT false,
    code text,
    "timestamp" timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users2 OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 19895)
-- Name: viewtasks; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.viewtasks AS
 SELECT a.assignment_id,
    a.patient_id,
    a.therapist_id,
    a.exercise_type,
    a.exercise_sets,
    a.exercise_reps,
    a."timestamp",
    a.active,
    a.exercise_duration,
    exercises.exercise_name
   FROM (public.assignments a
     JOIN public.exercises ON ((a.exercise_type = exercises.exercise_key)))
  WHERE (a.active IS TRUE)
  ORDER BY a."timestamp" DESC;


ALTER VIEW public.viewtasks OWNER TO postgres;

--
-- TOC entry 4227 (class 2604 OID 18945)
-- Name: exercises exercise_int; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises ALTER COLUMN exercise_int SET DEFAULT nextval('public.exercises_exercise_int_seq'::regclass);


--
-- TOC entry 4249 (class 2606 OID 18402)
-- Name: assignments assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_pkey PRIMARY KEY (assignment_id);


--
-- TOC entry 4251 (class 2606 OID 18950)
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (exercise_id);


--
-- TOC entry 4259 (class 2606 OID 20608)
-- Name: manualsegments manualsegments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manualsegments
    ADD CONSTRAINT manualsegments_pkey PRIMARY KEY (seg_id);


--
-- TOC entry 4245 (class 2606 OID 18384)
-- Name: sessionlabels sessionlabels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessionlabels
    ADD CONSTRAINT sessionlabels_pkey PRIMARY KEY (rep_id);


--
-- TOC entry 4241 (class 2606 OID 17884)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (session_id);


--
-- TOC entry 4243 (class 2606 OID 18105)
-- Name: skeletons skeletons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skeletons
    ADD CONSTRAINT skeletons_pkey PRIMARY KEY (skeleton_id);


--
-- TOC entry 4255 (class 2606 OID 20498)
-- Name: useractivity useractivity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useractivity
    ADD CONSTRAINT useractivity_pkey PRIMARY KEY (activity_id);


--
-- TOC entry 4257 (class 2606 OID 20508)
-- Name: userprofile userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userprofile
    ADD CONSTRAINT userprofile_pkey PRIMARY KEY (profile_id);


--
-- TOC entry 4253 (class 2606 OID 19763)
-- Name: users2 users2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users2
    ADD CONSTRAINT users2_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4247 (class 2606 OID 18393)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4406 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-07-01 20:18:47 PDT

--
-- PostgreSQL database dump complete
--

