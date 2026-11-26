--
-- PostgreSQL database dump
--

\restrict U7okGadqDP3kpo6qOtNzCr5r34u0sR8fhqiMMfDbq8Vhtfcd7LNyZ35kMXHeApv

-- Dumped from database version 18.6 (Ubuntu 18.6-0ubuntu0.26.04.1)
-- Dumped by pg_dump version 18.6 (Ubuntu 18.6-0ubuntu0.26.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.wallet_transaction DROP CONSTRAINT IF EXISTS plaza_transaction_user_id_d861ca11_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.booking_ticketbooking DROP CONSTRAINT IF EXISTS plaza_ticketbooking_user_id_74395bac_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.booking_ticketbooking DROP CONSTRAINT IF EXISTS plaza_ticketbooking_event_id_e56bdb09_fk_plaza_event_id;
ALTER TABLE IF EXISTS ONLY public.booking_slotbooking DROP CONSTRAINT IF EXISTS plaza_slotbooking_user_id_47b2ab52_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.booking_slotbooking DROP CONSTRAINT IF EXISTS plaza_slotbooking_slot_id_2382e8c2_fk_plaza_eventslot_id;
ALTER TABLE IF EXISTS ONLY public.events_eventslot DROP CONSTRAINT IF EXISTS plaza_eventslot_event_id_6e8314dd_fk_plaza_event_id;
ALTER TABLE IF EXISTS ONLY public.events_eventschedule DROP CONSTRAINT IF EXISTS plaza_eventschedule_event_id_34059f0d_fk_plaza_event_id;
ALTER TABLE IF EXISTS ONLY public.events_event DROP CONSTRAINT IF EXISTS plaza_event_created_by_id_0028bd58_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_user_id_c564eba6_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_user_id_6a12ed8b_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_group_id_97559544_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
DROP INDEX IF EXISTS public.plaza_transaction_user_id_d861ca11;
DROP INDEX IF EXISTS public.plaza_ticketbooking_user_id_74395bac;
DROP INDEX IF EXISTS public.plaza_ticketbooking_event_id_e56bdb09;
DROP INDEX IF EXISTS public.plaza_slotbooking_user_id_47b2ab52;
DROP INDEX IF EXISTS public.plaza_slotbooking_slot_id_2382e8c2;
DROP INDEX IF EXISTS public.plaza_eventslot_event_id_6e8314dd;
DROP INDEX IF EXISTS public.plaza_eventschedule_event_id_34059f0d;
DROP INDEX IF EXISTS public.plaza_event_created_by_id_0028bd58;
DROP INDEX IF EXISTS public.django_session_session_key_c0390e0f_like;
DROP INDEX IF EXISTS public.django_session_expire_date_a5c62663;
DROP INDEX IF EXISTS public.django_admin_log_user_id_c564eba6;
DROP INDEX IF EXISTS public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX IF EXISTS public.auth_user_username_6821ab7c_like;
DROP INDEX IF EXISTS public.auth_user_user_permissions_user_id_a95ead1b;
DROP INDEX IF EXISTS public.auth_user_user_permissions_permission_id_1fbb5f2c;
DROP INDEX IF EXISTS public.auth_user_groups_user_id_6a12ed8b;
DROP INDEX IF EXISTS public.auth_user_groups_group_id_97559544;
DROP INDEX IF EXISTS public.auth_permission_content_type_id_2f476e4b;
DROP INDEX IF EXISTS public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX IF EXISTS public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX IF EXISTS public.auth_group_name_a6ea08ec_like;
ALTER TABLE IF EXISTS ONLY public.wallet_transaction DROP CONSTRAINT IF EXISTS plaza_transaction_pkey;
ALTER TABLE IF EXISTS ONLY public.booking_ticketbooking DROP CONSTRAINT IF EXISTS plaza_ticketbooking_pkey;
ALTER TABLE IF EXISTS ONLY public.booking_slotbooking DROP CONSTRAINT IF EXISTS plaza_slotbooking_pkey;
ALTER TABLE IF EXISTS ONLY public.events_eventslot DROP CONSTRAINT IF EXISTS plaza_eventslot_pkey;
ALTER TABLE IF EXISTS ONLY public.events_eventschedule DROP CONSTRAINT IF EXISTS plaza_eventschedule_pkey;
ALTER TABLE IF EXISTS ONLY public.events_event DROP CONSTRAINT IF EXISTS plaza_event_pkey;
ALTER TABLE IF EXISTS ONLY public.django_session DROP CONSTRAINT IF EXISTS django_session_pkey;
ALTER TABLE IF EXISTS ONLY public.django_migrations DROP CONSTRAINT IF EXISTS django_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user DROP CONSTRAINT IF EXISTS auth_user_username_key;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user DROP CONSTRAINT IF EXISTS auth_user_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_user_id_group_id_94350c0c_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_name_key;
DROP TABLE IF EXISTS public.wallet_transaction;
DROP TABLE IF EXISTS public.events_eventslot;
DROP TABLE IF EXISTS public.events_eventschedule;
DROP TABLE IF EXISTS public.events_event;
DROP TABLE IF EXISTS public.django_session;
DROP TABLE IF EXISTS public.django_migrations;
DROP TABLE IF EXISTS public.django_content_type;
DROP TABLE IF EXISTS public.django_admin_log;
DROP TABLE IF EXISTS public.booking_ticketbooking;
DROP TABLE IF EXISTS public.booking_slotbooking;
DROP TABLE IF EXISTS public.auth_user_user_permissions;
DROP TABLE IF EXISTS public.auth_user_groups;
DROP TABLE IF EXISTS public.auth_user;
DROP TABLE IF EXISTS public.auth_permission;
DROP TABLE IF EXISTS public.auth_group_permissions;
DROP TABLE IF EXISTS public.auth_group;
-- *not* dropping schema, since initdb creates it
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: booking_slotbooking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_slotbooking (
    id bigint CONSTRAINT plaza_slotbooking_id_not_null NOT NULL,
    status character varying(10) CONSTRAINT plaza_slotbooking_status_not_null NOT NULL,
    created_at timestamp with time zone CONSTRAINT plaza_slotbooking_created_at_not_null NOT NULL,
    slot_id bigint,
    user_id integer CONSTRAINT plaza_slotbooking_user_id_not_null NOT NULL,
    event_name character varying(100),
    slot_end_time timestamp with time zone,
    slot_start_time timestamp with time zone,
    consumed character varying(10) CONSTRAINT plaza_slotbooking_consumed_not_null NOT NULL
);


--
-- Name: booking_ticketbooking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_ticketbooking (
    id bigint CONSTRAINT plaza_ticketbooking_id_not_null NOT NULL,
    quantity integer CONSTRAINT plaza_ticketbooking_quantity_not_null NOT NULL,
    total_amount numeric(10,2) CONSTRAINT plaza_ticketbooking_total_amount_not_null NOT NULL,
    status character varying(10) CONSTRAINT plaza_ticketbooking_status_not_null NOT NULL,
    created_at timestamp with time zone CONSTRAINT plaza_ticketbooking_created_at_not_null NOT NULL,
    event_id bigint,
    user_id integer CONSTRAINT plaza_ticketbooking_user_id_not_null NOT NULL,
    event_name character varying(100),
    consumed character varying(10) CONSTRAINT plaza_ticketbooking_consumed_not_null NOT NULL,
    CONSTRAINT plaza_ticketbooking_quantity_check CHECK ((quantity >= 0))
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


--
-- Name: events_event; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_event (
    id bigint CONSTRAINT plaza_event_id_not_null NOT NULL,
    type character varying(10) CONSTRAINT plaza_event_type_not_null NOT NULL,
    start_time timestamp with time zone CONSTRAINT plaza_event_start_time_not_null NOT NULL,
    end_time timestamp with time zone CONSTRAINT plaza_event_end_time_not_null NOT NULL,
    duration integer CONSTRAINT plaza_event_duration_not_null NOT NULL,
    name character varying(50) CONSTRAINT plaza_event_name_not_null NOT NULL,
    "desc" text CONSTRAINT plaza_event_desc_not_null NOT NULL,
    location character varying(100) CONSTRAINT plaza_event_location_not_null NOT NULL,
    created_at timestamp with time zone CONSTRAINT plaza_event_created_at_not_null NOT NULL,
    created_by_id integer CONSTRAINT plaza_event_created_by_id_not_null NOT NULL,
    capacity integer,
    price numeric(10,2) CONSTRAINT plaza_event_price_not_null NOT NULL,
    CONSTRAINT plaza_event_capacity_check CHECK ((capacity >= 0)),
    CONSTRAINT plaza_event_duration_check CHECK ((duration >= 0))
);


--
-- Name: events_eventschedule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_eventschedule (
    id bigint CONSTRAINT plaza_eventschedule_id_not_null NOT NULL,
    date date CONSTRAINT plaza_eventschedule_date_not_null NOT NULL,
    start_time time without time zone CONSTRAINT plaza_eventschedule_start_time_not_null NOT NULL,
    end_time time without time zone CONSTRAINT plaza_eventschedule_end_time_not_null NOT NULL,
    event_id bigint CONSTRAINT plaza_eventschedule_event_id_not_null NOT NULL
);


--
-- Name: events_eventslot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_eventslot (
    id bigint CONSTRAINT plaza_eventslot_id_not_null NOT NULL,
    start_time timestamp with time zone CONSTRAINT plaza_eventslot_start_time_not_null NOT NULL,
    end_time timestamp with time zone CONSTRAINT plaza_eventslot_end_time_not_null NOT NULL,
    is_available boolean CONSTRAINT plaza_eventslot_is_available_not_null NOT NULL,
    event_id bigint CONSTRAINT plaza_eventslot_event_id_not_null NOT NULL
);


--
-- Name: plaza_event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.events_event ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.plaza_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: plaza_eventschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.events_eventschedule ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.plaza_eventschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: plaza_eventslot_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.events_eventslot ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.plaza_eventslot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: plaza_slotbooking_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.booking_slotbooking ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.plaza_slotbooking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: plaza_ticketbooking_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.booking_ticketbooking ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.plaza_ticketbooking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: wallet_transaction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wallet_transaction (
    id bigint CONSTRAINT plaza_transaction_id_not_null NOT NULL,
    amount numeric(10,2) CONSTRAINT plaza_transaction_amount_not_null NOT NULL,
    transaction_type character varying(10) CONSTRAINT plaza_transaction_transaction_type_not_null NOT NULL,
    created_at timestamp with time zone CONSTRAINT plaza_transaction_created_at_not_null NOT NULL,
    user_id integer CONSTRAINT plaza_transaction_user_id_not_null NOT NULL
);


--
-- Name: plaza_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.wallet_transaction ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.plaza_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group (id, name) FROM stdin;
1	Normal
2	Organization
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	3	add_permission
6	Can change permission	3	change_permission
7	Can delete permission	3	delete_permission
8	Can view permission	3	view_permission
9	Can add group	2	add_group
10	Can change group	2	change_group
11	Can delete group	2	delete_group
12	Can view group	2	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add event	7	add_event
26	Can change event	7	change_event
27	Can delete event	7	delete_event
28	Can view event	7	view_event
29	Can add event slot	8	add_eventslot
30	Can change event slot	8	change_eventslot
31	Can delete event slot	8	delete_eventslot
32	Can view event slot	8	view_eventslot
33	Can add transaction	9	add_transaction
34	Can change transaction	9	change_transaction
35	Can delete transaction	9	delete_transaction
36	Can view transaction	9	view_transaction
37	Can add event schedule	10	add_eventschedule
38	Can change event schedule	10	change_eventschedule
39	Can delete event schedule	10	delete_eventschedule
40	Can view event schedule	10	view_eventschedule
41	Can add slot booking	11	add_slotbooking
42	Can change slot booking	11	change_slotbooking
43	Can delete slot booking	11	delete_slotbooking
44	Can view slot booking	11	view_slotbooking
45	Can add ticket booking	12	add_ticketbooking
46	Can change ticket booking	12	change_ticketbooking
47	Can delete ticket booking	12	delete_ticketbooking
48	Can view ticket booking	12	view_ticketbooking
49	Can add transaction	13	add_transaction
50	Can change transaction	13	change_transaction
51	Can delete transaction	13	delete_transaction
52	Can view transaction	13	view_transaction
53	Can add ticket booking	15	add_ticketbooking
54	Can change ticket booking	15	change_ticketbooking
55	Can delete ticket booking	15	delete_ticketbooking
56	Can view ticket booking	15	view_ticketbooking
57	Can add slot booking	14	add_slotbooking
58	Can change slot booking	14	change_slotbooking
59	Can delete slot booking	14	delete_slotbooking
60	Can view slot booking	14	view_slotbooking
61	Can add event	16	add_event
62	Can change event	16	change_event
63	Can delete event	16	delete_event
64	Can view event	16	view_event
65	Can add event slot	18	add_eventslot
66	Can change event slot	18	change_eventslot
67	Can delete event slot	18	delete_eventslot
68	Can view event slot	18	view_eventslot
69	Can add event schedule	17	add_eventschedule
70	Can change event schedule	17	change_eventschedule
71	Can delete event schedule	17	delete_eventschedule
72	Can view event schedule	17	view_eventschedule
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$1500000$rtxSsaAwlB8G1REUA3H2Ny$vVDcbCyMjVpUus6WJXMl12r62UBpI+X0D4WaX5zCsTE=	2026-11-23 18:44:53.799541+00	t	vihaan			vihaankulkarni3090@gmail.com	t	t	2026-10-29 15:30:52.739457+00
2	pbkdf2_sha256$1500000$XlSrsQ5Aa97geAriA6x388$XM5CBKK8PfLOSL166qbva+Fby2V9OhYp+aqNu0HzWAo=	2026-11-24 14:50:05.692808+00	f	jane_doe	Jane	Doe		f	t	2026-10-29 15:32:16+00
3	pbkdf2_sha256$1500000$1G8WJ48b8NsvIxwLE0MWEC$J12/YFHvJLxQeuudp6dhswuYf8EhStHHBA1CJPBTMHg=	2026-11-22 15:16:41.864755+00	f	john_doe	John	Doe		f	t	2026-10-29 15:32:47+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
1	2	2
2	3	1
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: booking_slotbooking; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.booking_slotbooking (id, status, created_at, slot_id, user_id, event_name, slot_end_time, slot_start_time, consumed) FROM stdin;
2	CONFIRMED	2026-11-03 14:07:34.017471+00	1	1	Football Turf 1	2026-11-06 06:30:00+00	2026-11-06 06:00:00+00	No
3	CONFIRMED	2026-11-03 14:08:20.278038+00	2	1	Football Turf 1	2026-11-06 07:00:00+00	2026-11-06 06:30:00+00	No
4	CONFIRMED	2026-11-03 14:08:32.43803+00	3	1	Football Turf 1	2026-11-06 07:30:00+00	2026-11-06 07:00:00+00	No
5	CONFIRMED	2026-11-03 14:09:10.740082+00	4	1	Football Turf 1	2026-11-06 08:00:00+00	2026-11-06 07:30:00+00	No
6	CONFIRMED	2026-11-03 14:10:01.173804+00	5	1	Football Turf 1	2026-11-06 08:30:00+00	2026-11-06 08:00:00+00	No
7	CONFIRMED	2026-11-03 14:10:09.890529+00	6	1	Football Turf 1	2026-11-06 09:00:00+00	2026-11-06 08:30:00+00	No
8	CONFIRMED	2026-11-03 14:13:30.545571+00	7	1	Football Turf 1	2026-11-06 09:30:00+00	2026-11-06 09:00:00+00	No
9	CONFIRMED	2026-11-05 09:55:15.369826+00	61	1	Gokarting	2026-11-12 13:20:00+00	2026-11-12 13:00:00+00	No
10	CONFIRMED	2026-11-05 11:26:22.274158+00	17	1	Football Turf 1	2026-11-06 14:30:00+00	2026-11-06 14:00:00+00	No
11	CONFIRMED	2026-11-07 17:31:58.810127+00	82	2	basketball	2026-11-16 15:30:00+00	2026-11-16 15:00:00+00	No
12	CONFIRMED	2026-11-16 14:36:29.233812+00	83	1	basketball	2026-11-16 16:00:00+00	2026-11-16 15:30:00+00	No
13	CONFIRMED	2026-11-20 22:36:55.053987+00	94	2	box cricket	2026-11-23 12:30:00+00	2026-11-23 12:00:00+00	No
14	CONFIRMED	2026-11-20 22:37:01.547205+00	95	2	box cricket	2026-11-23 13:00:00+00	2026-11-23 12:30:00+00	No
15	CONFIRMED	2026-11-21 12:23:26.513333+00	96	2	box cricket	2026-11-23 13:30:00+00	2026-11-23 13:00:00+00	No
16	CONFIRMED	2026-11-22 15:16:52.225553+00	97	3	box cricket	2026-11-23 14:00:00+00	2026-11-23 13:30:00+00	No
17	CONFIRMED	2026-11-23 18:45:07.982115+00	109	1	box cricket	2026-11-24 14:00:00+00	2026-11-24 13:30:00+00	NO
\.


--
-- Data for Name: booking_ticketbooking; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.booking_ticketbooking (id, quantity, total_amount, status, created_at, event_id, user_id, event_name, consumed) FROM stdin;
3	10	20000.00	CONFIRMED	2026-11-03 13:33:55.341272+00	5	1	Concert 2	YES
2	5	10000.00	CONSUMED	2026-11-03 13:33:21.705812+00	4	1	Concert 1	YES
6	1	2000.00	CONSUMED	2026-11-03 14:05:48.923249+00	4	1	Concert 1	YES
8	1	500.00	CONFIRMED	2026-11-05 11:28:47.640178+00	6	1	Concert 3	No
10	1	1000.00	CONFIRMED	2026-11-21 12:24:30.679786+00	9	2	Concert4	No
11	1	1000.00	CONFIRMED	2026-11-21 15:31:13.855809+00	9	2	Concert4	No
4	1	2000.00	CONFIRMED	2026-11-03 14:01:31.711752+00	4	1	Concert 1	YES
7	1	2000.00	CONFIRMED	2026-11-05 09:41:16.989366+00	4	2	Concert 1	YES
9	1	1000.00	CONFIRMED	2026-11-20 22:29:02.895883+00	9	2	Concert4	YES
12	1	1000.00	CONFIRMED	2026-11-21 15:37:22.399802+00	9	1	Concert4	No
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2026-10-29 15:31:53.443298+00	1	Normal	1	[{"added": {}}]	2	1
2	2026-10-29 15:32:03.129714+00	2	Organization	1	[{"added": {}}]	2	1
3	2026-10-29 15:32:16.999015+00	2	jane_doe	1	[{"added": {}}]	4	1
4	2026-10-29 15:32:38.328425+00	2	jane_doe	2	[{"changed": {"fields": ["First name", "Last name", "Groups"]}}]	4	1
5	2026-10-29 15:32:47.415345+00	3	john_doe	1	[{"added": {}}]	4	1
6	2026-10-29 15:32:59.970235+00	3	john_doe	2	[{"changed": {"fields": ["First name", "Last name", "Groups"]}}]	4	1
7	2026-10-29 16:09:22.375471+00	1	Football Turf 1	1	[{"added": {}}, {"added": {"name": "event schedule", "object": "Football Turf 1 - 2026-11-06"}}, {"added": {"name": "event schedule", "object": "Football Turf 1 - 2026-11-07"}}]	7	1
8	2026-10-29 16:19:21.096136+00	1	Football Turf 1	2	[]	7	1
9	2026-10-29 16:19:47.968048+00	1	Football Turf 1	3		7	1
10	2026-10-29 16:21:23.798937+00	3	Football Turf 1	1	[{"added": {}}, {"added": {"name": "event schedule", "object": "Football Turf 1 - 2026-11-06"}}, {"added": {"name": "event schedule", "object": "Football Turf 1 - 2026-11-07"}}]	7	1
11	2026-10-29 17:43:18.222891+00	4	Concert 1	1	[{"added": {}}]	7	1
12	2026-10-29 19:45:30.028607+00	4	Concert 1	2	[{"changed": {"fields": ["Price"]}}]	7	1
13	2026-10-29 19:45:38.934592+00	3	Football Turf 1	2	[{"changed": {"fields": ["Price"]}}]	7	1
14	2026-10-30 07:00:43.134437+00	5	Concert 2	1	[{"added": {}}]	7	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	group
3	auth	permission
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	plaza	event
8	plaza	eventslot
9	plaza	transaction
10	plaza	eventschedule
11	plaza	slotbooking
12	plaza	ticketbooking
13	wallet	transaction
14	booking	slotbooking
15	booking	ticketbooking
16	events	event
17	events	eventschedule
18	events	eventslot
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-10-29 15:30:27.649964+00
2	auth	0001_initial	2026-10-29 15:30:27.682642+00
3	admin	0001_initial	2026-10-29 15:30:27.691139+00
4	admin	0002_logentry_remove_auto_add	2026-10-29 15:30:27.694937+00
5	admin	0003_logentry_add_action_flag_choices	2026-10-29 15:30:27.698767+00
6	contenttypes	0002_remove_content_type_name	2026-10-29 15:30:27.706527+00
7	auth	0002_alter_permission_name_max_length	2026-10-29 15:30:27.710525+00
8	auth	0003_alter_user_email_max_length	2026-10-29 15:30:27.713889+00
9	auth	0004_alter_user_username_opts	2026-10-29 15:30:27.717289+00
10	auth	0005_alter_user_last_login_null	2026-10-29 15:30:27.721383+00
11	auth	0006_require_contenttypes_0002	2026-10-29 15:30:27.722845+00
12	auth	0007_alter_validators_add_error_messages	2026-10-29 15:30:27.727191+00
13	auth	0008_alter_user_username_max_length	2026-10-29 15:30:27.732754+00
14	auth	0009_alter_user_last_name_max_length	2026-10-29 15:30:27.736812+00
15	auth	0010_alter_group_name_max_length	2026-10-29 15:30:27.741244+00
16	auth	0011_update_proxy_permissions	2026-10-29 15:30:27.744876+00
17	auth	0012_alter_user_first_name_max_length	2026-10-29 15:30:27.749256+00
18	plaza	0001_initial	2026-10-29 15:30:27.768083+00
19	sessions	0001_initial	2026-10-29 15:30:27.773626+00
20	plaza	0002_eventschedule	2026-10-29 15:40:50.340813+00
21	plaza	0003_event_capacity_alter_event_duration	2026-10-29 16:34:02.375831+00
22	plaza	0004_event_price_slotbooking_ticketbooking	2026-10-29 19:44:46.008015+00
23	plaza	0005_slotbooking_event_name_slotbooking_slot_end_time_and_more	2026-11-03 13:10:38.04226+00
24	plaza	0006_slotbooking_consumed_ticketbooking_consumed_and_more	2026-11-03 15:58:51.733591+00
25	plaza	0007_alter_slotbooking_status	2026-11-03 15:58:51.745108+00
26	plaza	0008_alter_event_type_alter_slotbooking_consumed_and_more	2026-11-23 12:32:29.523902+00
27	plaza	0009_move_models_to_new_apps	2026-11-23 18:30:11.036472+00
28	booking	0001_initial	2026-11-23 18:30:11.05099+00
29	events	0001_initial	2026-11-23 18:30:11.063573+00
30	wallet	0001_initial	2026-11-23 18:30:11.069834+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
eok8g2ee1jscc8pt6lijqntlf3mld8u6	.eJxVjMEOwiAQRP-FsyFlXSl49N5vICwLUjWQlPZk_HdL0oPeJvPezFs4v63ZbS0ubmZxFUqcfjvy4RlLB_zw5V5lqGVdZpJdkQdtcqocX7fD_TvIvuV9DdrahJpQ6QENRU3nZHiwCsEzakOc7GUnbAhHSD3qAACJPcKISny-w7827w:1xOvPx:8u2KWl2xeT6qDDeJS02kHp2Kw0hJJqr9S_Zzye_MXno	2026-11-19 11:14:05.99571+00
6w9omazbeydlkplgz8g8zz999d46xc3a	.eJxVjMEOwiAQRP-FsyFlXSl49N5vICwLUjWQlPZk_HdL0oPeJvPezFs4v63ZbS0ubmZxFUqcfjvy4RlLB_zw5V5lqGVdZpJdkQdtcqocX7fD_TvIvuV9DdrahJpQ6QENRU3nZHiwCsEzakOc7GUnbAhHSD3qAACJPcKISny-w7827w:1xVZ25:HWNB_NzGb5tTmL2M-M95iqQlDPhlaF0Yz0TbuPW1xDc	2026-12-07 18:44:53.81366+00
lumhd5okllry7xteuef7c5l8onkb2wuj	.eJxVjE0OwiAYBe_C2hBAhODSvWcg3x9SNZCUdmW8uzbpQrdvZt5LZViXmtchc55YnZVTh98NgR7SNsB3aLeuqbdlnlBvit7p0NfO8rzs7t9BhVG_tYiPyRYwhY-G0AWHwdkEXiwBF8PoqRh0gv6EXMjGGE0JhNZbDAnU-wMNNzkC:1xVrqP:f54akeFFfQwpvOWbSqP8H4JEQb_1C46N3S-6Bc3BHeI	2026-12-08 14:50:05.698204+00
\.


--
-- Data for Name: events_event; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.events_event (id, type, start_time, end_time, duration, name, "desc", location, created_at, created_by_id, capacity, price) FROM stdin;
3	SLOT	2026-11-06 06:00:00+00	2026-11-09 18:00:00+00	30	Football Turf 1	Football turf , max players 10	Horse Stables	2026-10-29 16:21:23.783737+00	2	\N	400.00
5	TICKET	2026-11-09 00:00:00+00	2026-11-11 04:00:00+00	240	Concert 2	Concert 2	South Park	2026-10-30 07:00:43.130565+00	2	0	2000.00
7	SLOT	2026-11-12 00:00:00+00	2026-11-13 20:00:00+00	20	Gokarting	gokarting outdoors , petrol gokarts	F9	2026-11-05 08:27:09.514782+00	2	\N	2000.00
8	SLOT	2026-11-16 12:00:00+00	2026-11-17 20:00:00+00	30	basketball	Basketball Court , max capacity 10	GymG	2026-11-05 08:30:20.976625+00	2	\N	200.00
4	TICKET	2026-11-06 19:00:00+00	2026-11-07 00:00:00+00	300	Concert 1	Musical Concert	South Park	2026-10-29 17:43:18.219855+00	2	2	2000.00
6	TICKET	2026-11-11 10:30:00+00	2026-11-12 02:30:00+00	240	Concert 3	third concert	South Park	2026-11-03 20:00:10.059914+00	2	19	500.00
10	SLOT	2026-11-23 12:00:00+00	2026-11-25 12:00:00+00	30	box cricket	box cricket	GymG	2026-11-20 22:36:48.246445+00	2	10	200.00
9	TICKET	2026-11-22 21:45:00+00	2026-11-22 23:45:00+00	120	Concert4	concert	Southpark	2026-11-20 22:19:41.725946+00	2	6	1000.00
\.


--
-- Data for Name: events_eventschedule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.events_eventschedule (id, date, start_time, end_time, event_id) FROM stdin;
5	2026-11-06	06:00:00	18:00:00	3
6	2026-11-07	06:00:00	18:00:00	3
7	2026-11-12	13:00:00	17:00:00	7
8	2026-11-12	13:00:00	17:00:00	7
9	2026-11-13	15:00:00	18:00:00	7
10	2026-11-16	15:00:00	18:00:00	8
11	2026-11-17	15:00:00	18:00:00	8
12	2026-11-23	12:00:00	18:00:00	10
13	2026-11-24	12:00:00	18:00:00	10
14	2026-11-25	12:00:00	18:00:00	10
\.


--
-- Data for Name: events_eventslot; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.events_eventslot (id, start_time, end_time, is_available, event_id) FROM stdin;
8	2026-11-06 09:30:00+00	2026-11-06 10:00:00+00	t	3
9	2026-11-06 10:00:00+00	2026-11-06 10:30:00+00	t	3
10	2026-11-06 10:30:00+00	2026-11-06 11:00:00+00	t	3
11	2026-11-06 11:00:00+00	2026-11-06 11:30:00+00	t	3
12	2026-11-06 11:30:00+00	2026-11-06 12:00:00+00	t	3
13	2026-11-06 12:00:00+00	2026-11-06 12:30:00+00	t	3
14	2026-11-06 12:30:00+00	2026-11-06 13:00:00+00	t	3
15	2026-11-06 13:00:00+00	2026-11-06 13:30:00+00	t	3
16	2026-11-06 13:30:00+00	2026-11-06 14:00:00+00	t	3
18	2026-11-06 14:30:00+00	2026-11-06 15:00:00+00	t	3
19	2026-11-06 15:00:00+00	2026-11-06 15:30:00+00	t	3
20	2026-11-06 15:30:00+00	2026-11-06 16:00:00+00	t	3
21	2026-11-06 16:00:00+00	2026-11-06 16:30:00+00	t	3
22	2026-11-06 16:30:00+00	2026-11-06 17:00:00+00	t	3
23	2026-11-06 17:00:00+00	2026-11-06 17:30:00+00	t	3
24	2026-11-06 17:30:00+00	2026-11-06 18:00:00+00	t	3
25	2026-11-07 06:00:00+00	2026-11-07 06:30:00+00	t	3
26	2026-11-07 06:30:00+00	2026-11-07 07:00:00+00	t	3
27	2026-11-07 07:00:00+00	2026-11-07 07:30:00+00	t	3
28	2026-11-07 07:30:00+00	2026-11-07 08:00:00+00	t	3
29	2026-11-07 08:00:00+00	2026-11-07 08:30:00+00	t	3
30	2026-11-07 08:30:00+00	2026-11-07 09:00:00+00	t	3
31	2026-11-07 09:00:00+00	2026-11-07 09:30:00+00	t	3
32	2026-11-07 09:30:00+00	2026-11-07 10:00:00+00	t	3
33	2026-11-07 10:00:00+00	2026-11-07 10:30:00+00	t	3
34	2026-11-07 10:30:00+00	2026-11-07 11:00:00+00	t	3
35	2026-11-07 11:00:00+00	2026-11-07 11:30:00+00	t	3
36	2026-11-07 11:30:00+00	2026-11-07 12:00:00+00	t	3
37	2026-11-07 12:00:00+00	2026-11-07 12:30:00+00	t	3
38	2026-11-07 12:30:00+00	2026-11-07 13:00:00+00	t	3
39	2026-11-07 13:00:00+00	2026-11-07 13:30:00+00	t	3
40	2026-11-07 13:30:00+00	2026-11-07 14:00:00+00	t	3
41	2026-11-07 14:00:00+00	2026-11-07 14:30:00+00	t	3
42	2026-11-07 14:30:00+00	2026-11-07 15:00:00+00	t	3
43	2026-11-07 15:00:00+00	2026-11-07 15:30:00+00	t	3
44	2026-11-07 15:30:00+00	2026-11-07 16:00:00+00	t	3
45	2026-11-07 16:00:00+00	2026-11-07 16:30:00+00	t	3
46	2026-11-07 16:30:00+00	2026-11-07 17:00:00+00	t	3
47	2026-11-07 17:00:00+00	2026-11-07 17:30:00+00	t	3
48	2026-11-07 17:30:00+00	2026-11-07 18:00:00+00	t	3
94	2026-11-23 12:00:00+00	2026-11-23 12:30:00+00	f	10
1	2026-11-06 06:00:00+00	2026-11-06 06:30:00+00	f	3
2	2026-11-06 06:30:00+00	2026-11-06 07:00:00+00	f	3
3	2026-11-06 07:00:00+00	2026-11-06 07:30:00+00	f	3
4	2026-11-06 07:30:00+00	2026-11-06 08:00:00+00	f	3
5	2026-11-06 08:00:00+00	2026-11-06 08:30:00+00	f	3
6	2026-11-06 08:30:00+00	2026-11-06 09:00:00+00	f	3
7	2026-11-06 09:00:00+00	2026-11-06 09:30:00+00	f	3
49	2026-11-12 13:00:00+00	2026-11-12 13:20:00+00	t	7
50	2026-11-12 13:20:00+00	2026-11-12 13:40:00+00	t	7
51	2026-11-12 13:40:00+00	2026-11-12 14:00:00+00	t	7
52	2026-11-12 14:00:00+00	2026-11-12 14:20:00+00	t	7
53	2026-11-12 14:20:00+00	2026-11-12 14:40:00+00	t	7
54	2026-11-12 14:40:00+00	2026-11-12 15:00:00+00	t	7
55	2026-11-12 15:00:00+00	2026-11-12 15:20:00+00	t	7
56	2026-11-12 15:20:00+00	2026-11-12 15:40:00+00	t	7
57	2026-11-12 15:40:00+00	2026-11-12 16:00:00+00	t	7
58	2026-11-12 16:00:00+00	2026-11-12 16:20:00+00	t	7
59	2026-11-12 16:20:00+00	2026-11-12 16:40:00+00	t	7
60	2026-11-12 16:40:00+00	2026-11-12 17:00:00+00	t	7
62	2026-11-12 13:20:00+00	2026-11-12 13:40:00+00	t	7
63	2026-11-12 13:40:00+00	2026-11-12 14:00:00+00	t	7
64	2026-11-12 14:00:00+00	2026-11-12 14:20:00+00	t	7
65	2026-11-12 14:20:00+00	2026-11-12 14:40:00+00	t	7
66	2026-11-12 14:40:00+00	2026-11-12 15:00:00+00	t	7
67	2026-11-12 15:00:00+00	2026-11-12 15:20:00+00	t	7
68	2026-11-12 15:20:00+00	2026-11-12 15:40:00+00	t	7
69	2026-11-12 15:40:00+00	2026-11-12 16:00:00+00	t	7
70	2026-11-12 16:00:00+00	2026-11-12 16:20:00+00	t	7
71	2026-11-12 16:20:00+00	2026-11-12 16:40:00+00	t	7
72	2026-11-12 16:40:00+00	2026-11-12 17:00:00+00	t	7
73	2026-11-13 15:00:00+00	2026-11-13 15:20:00+00	t	7
74	2026-11-13 15:20:00+00	2026-11-13 15:40:00+00	t	7
75	2026-11-13 15:40:00+00	2026-11-13 16:00:00+00	t	7
76	2026-11-13 16:00:00+00	2026-11-13 16:20:00+00	t	7
77	2026-11-13 16:20:00+00	2026-11-13 16:40:00+00	t	7
78	2026-11-13 16:40:00+00	2026-11-13 17:00:00+00	t	7
79	2026-11-13 17:00:00+00	2026-11-13 17:20:00+00	t	7
80	2026-11-13 17:20:00+00	2026-11-13 17:40:00+00	t	7
81	2026-11-13 17:40:00+00	2026-11-13 18:00:00+00	t	7
84	2026-11-16 16:00:00+00	2026-11-16 16:30:00+00	t	8
85	2026-11-16 16:30:00+00	2026-11-16 17:00:00+00	t	8
86	2026-11-16 17:00:00+00	2026-11-16 17:30:00+00	t	8
87	2026-11-16 17:30:00+00	2026-11-16 18:00:00+00	t	8
88	2026-11-17 15:00:00+00	2026-11-17 15:30:00+00	t	8
89	2026-11-17 15:30:00+00	2026-11-17 16:00:00+00	t	8
90	2026-11-17 16:00:00+00	2026-11-17 16:30:00+00	t	8
91	2026-11-17 16:30:00+00	2026-11-17 17:00:00+00	t	8
92	2026-11-17 17:00:00+00	2026-11-17 17:30:00+00	t	8
93	2026-11-17 17:30:00+00	2026-11-17 18:00:00+00	t	8
61	2026-11-12 13:00:00+00	2026-11-12 13:20:00+00	f	7
17	2026-11-06 14:00:00+00	2026-11-06 14:30:00+00	f	3
82	2026-11-16 15:00:00+00	2026-11-16 15:30:00+00	f	8
83	2026-11-16 15:30:00+00	2026-11-16 16:00:00+00	f	8
98	2026-11-23 14:00:00+00	2026-11-23 14:30:00+00	t	10
99	2026-11-23 14:30:00+00	2026-11-23 15:00:00+00	t	10
100	2026-11-23 15:00:00+00	2026-11-23 15:30:00+00	t	10
101	2026-11-23 15:30:00+00	2026-11-23 16:00:00+00	t	10
102	2026-11-23 16:00:00+00	2026-11-23 16:30:00+00	t	10
103	2026-11-23 16:30:00+00	2026-11-23 17:00:00+00	t	10
104	2026-11-23 17:00:00+00	2026-11-23 17:30:00+00	t	10
105	2026-11-23 17:30:00+00	2026-11-23 18:00:00+00	t	10
106	2026-11-24 12:00:00+00	2026-11-24 12:30:00+00	t	10
107	2026-11-24 12:30:00+00	2026-11-24 13:00:00+00	t	10
108	2026-11-24 13:00:00+00	2026-11-24 13:30:00+00	t	10
95	2026-11-23 12:30:00+00	2026-11-23 13:00:00+00	f	10
96	2026-11-23 13:00:00+00	2026-11-23 13:30:00+00	f	10
97	2026-11-23 13:30:00+00	2026-11-23 14:00:00+00	f	10
110	2026-11-24 14:00:00+00	2026-11-24 14:30:00+00	t	10
111	2026-11-24 14:30:00+00	2026-11-24 15:00:00+00	t	10
112	2026-11-24 15:00:00+00	2026-11-24 15:30:00+00	t	10
113	2026-11-24 15:30:00+00	2026-11-24 16:00:00+00	t	10
114	2026-11-24 16:00:00+00	2026-11-24 16:30:00+00	t	10
115	2026-11-24 16:30:00+00	2026-11-24 17:00:00+00	t	10
116	2026-11-24 17:00:00+00	2026-11-24 17:30:00+00	t	10
117	2026-11-24 17:30:00+00	2026-11-24 18:00:00+00	t	10
118	2026-11-25 12:00:00+00	2026-11-25 12:30:00+00	t	10
119	2026-11-25 12:30:00+00	2026-11-25 13:00:00+00	t	10
120	2026-11-25 13:00:00+00	2026-11-25 13:30:00+00	t	10
121	2026-11-25 13:30:00+00	2026-11-25 14:00:00+00	t	10
122	2026-11-25 14:00:00+00	2026-11-25 14:30:00+00	t	10
123	2026-11-25 14:30:00+00	2026-11-25 15:00:00+00	t	10
124	2026-11-25 15:00:00+00	2026-11-25 15:30:00+00	t	10
125	2026-11-25 15:30:00+00	2026-11-25 16:00:00+00	t	10
126	2026-11-25 16:00:00+00	2026-11-25 16:30:00+00	t	10
127	2026-11-25 16:30:00+00	2026-11-25 17:00:00+00	t	10
128	2026-11-25 17:00:00+00	2026-11-25 17:30:00+00	t	10
129	2026-11-25 17:30:00+00	2026-11-25 18:00:00+00	t	10
109	2026-11-24 13:30:00+00	2026-11-24 14:00:00+00	f	10
\.


--
-- Data for Name: wallet_transaction; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wallet_transaction (id, amount, transaction_type, created_at, user_id) FROM stdin;
1	100.00	CREDIT	2026-11-03 11:44:54.024614+00	2
2	40000.00	CREDIT	2026-11-03 13:30:44.432845+00	1
3	10000.00	DEBIT	2026-11-03 13:33:21.707123+00	1
4	20000.00	DEBIT	2026-11-03 13:33:55.341792+00	1
5	2000.00	DEBIT	2026-11-03 14:01:31.7182+00	1
6	2000.00	DEBIT	2026-11-03 14:05:48.924173+00	1
7	400.00	DEBIT	2026-11-03 14:07:34.018028+00	1
8	400.00	DEBIT	2026-11-03 14:08:20.278597+00	1
9	400.00	DEBIT	2026-11-03 14:08:32.43852+00	1
10	400.00	DEBIT	2026-11-03 14:09:10.740597+00	1
11	400.00	DEBIT	2026-11-03 14:10:01.174365+00	1
12	400.00	DEBIT	2026-11-03 14:10:09.891193+00	1
13	400.00	DEBIT	2026-11-03 14:13:30.546494+00	1
14	800.00	CREDIT	2026-11-03 14:14:12.818714+00	1
15	10000.00	CREDIT	2026-11-05 09:41:12.7558+00	2
16	2000.00	DEBIT	2026-11-05 09:41:16.992285+00	2
17	2000.00	DEBIT	2026-11-05 09:55:15.376174+00	1
18	400.00	DEBIT	2026-11-05 11:26:22.276313+00	1
19	500.00	DEBIT	2026-11-05 11:28:47.641812+00	1
20	30.00	CREDIT	2026-11-07 17:05:29.331535+00	1
21	200.00	DEBIT	2026-11-07 17:31:58.820663+00	2
22	200.00	DEBIT	2026-11-16 14:36:29.237815+00	1
23	100.00	CREDIT	2026-11-16 14:38:26.109402+00	1
24	1000.00	DEBIT	2026-11-20 22:29:02.900783+00	2
25	200.00	DEBIT	2026-11-20 22:36:55.057311+00	2
26	200.00	DEBIT	2026-11-20 22:37:01.547968+00	2
27	20.00	CREDIT	2026-11-21 12:23:20.614672+00	2
28	200.00	DEBIT	2026-11-21 12:23:26.516634+00	2
29	1000.00	DEBIT	2026-11-21 12:24:30.681406+00	2
30	100.00	CREDIT	2026-11-21 12:56:31.710148+00	2
31	1000.00	DEBIT	2026-11-21 15:31:13.862441+00	2
32	1000.00	DEBIT	2026-11-21 15:37:22.400885+00	1
33	100.00	CREDIT	2026-11-22 12:37:29.416536+00	1
34	200.00	CREDIT	2026-11-22 12:37:40.694263+00	1
35	1000.00	CREDIT	2026-11-22 15:09:14.078125+00	3
36	200.00	DEBIT	2026-11-22 15:16:52.229963+00	3
37	200.00	DEBIT	2026-11-23 18:45:07.985338+00	1
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 2, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 72, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 2, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 3, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 14, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 18, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 30, true);


--
-- Name: plaza_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.plaza_event_id_seq', 11, true);


--
-- Name: plaza_eventschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.plaza_eventschedule_id_seq', 15, true);


--
-- Name: plaza_eventslot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.plaza_eventslot_id_seq', 129, true);


--
-- Name: plaza_slotbooking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.plaza_slotbooking_id_seq', 17, true);


--
-- Name: plaza_ticketbooking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.plaza_ticketbooking_id_seq', 12, true);


--
-- Name: plaza_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.plaza_transaction_id_seq', 37, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: events_event plaza_event_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_event
    ADD CONSTRAINT plaza_event_pkey PRIMARY KEY (id);


--
-- Name: events_eventschedule plaza_eventschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_eventschedule
    ADD CONSTRAINT plaza_eventschedule_pkey PRIMARY KEY (id);


--
-- Name: events_eventslot plaza_eventslot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_eventslot
    ADD CONSTRAINT plaza_eventslot_pkey PRIMARY KEY (id);


--
-- Name: booking_slotbooking plaza_slotbooking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_slotbooking
    ADD CONSTRAINT plaza_slotbooking_pkey PRIMARY KEY (id);


--
-- Name: booking_ticketbooking plaza_ticketbooking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_ticketbooking
    ADD CONSTRAINT plaza_ticketbooking_pkey PRIMARY KEY (id);


--
-- Name: wallet_transaction plaza_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallet_transaction
    ADD CONSTRAINT plaza_transaction_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: plaza_event_created_by_id_0028bd58; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX plaza_event_created_by_id_0028bd58 ON public.events_event USING btree (created_by_id);


--
-- Name: plaza_eventschedule_event_id_34059f0d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX plaza_eventschedule_event_id_34059f0d ON public.events_eventschedule USING btree (event_id);


--
-- Name: plaza_eventslot_event_id_6e8314dd; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX plaza_eventslot_event_id_6e8314dd ON public.events_eventslot USING btree (event_id);


--
-- Name: plaza_slotbooking_slot_id_2382e8c2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX plaza_slotbooking_slot_id_2382e8c2 ON public.booking_slotbooking USING btree (slot_id);


--
-- Name: plaza_slotbooking_user_id_47b2ab52; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX plaza_slotbooking_user_id_47b2ab52 ON public.booking_slotbooking USING btree (user_id);


--
-- Name: plaza_ticketbooking_event_id_e56bdb09; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX plaza_ticketbooking_event_id_e56bdb09 ON public.booking_ticketbooking USING btree (event_id);


--
-- Name: plaza_ticketbooking_user_id_74395bac; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX plaza_ticketbooking_user_id_74395bac ON public.booking_ticketbooking USING btree (user_id);


--
-- Name: plaza_transaction_user_id_d861ca11; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX plaza_transaction_user_id_d861ca11 ON public.wallet_transaction USING btree (user_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: events_event plaza_event_created_by_id_0028bd58_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_event
    ADD CONSTRAINT plaza_event_created_by_id_0028bd58_fk_auth_user_id FOREIGN KEY (created_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: events_eventschedule plaza_eventschedule_event_id_34059f0d_fk_plaza_event_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_eventschedule
    ADD CONSTRAINT plaza_eventschedule_event_id_34059f0d_fk_plaza_event_id FOREIGN KEY (event_id) REFERENCES public.events_event(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: events_eventslot plaza_eventslot_event_id_6e8314dd_fk_plaza_event_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_eventslot
    ADD CONSTRAINT plaza_eventslot_event_id_6e8314dd_fk_plaza_event_id FOREIGN KEY (event_id) REFERENCES public.events_event(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: booking_slotbooking plaza_slotbooking_slot_id_2382e8c2_fk_plaza_eventslot_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_slotbooking
    ADD CONSTRAINT plaza_slotbooking_slot_id_2382e8c2_fk_plaza_eventslot_id FOREIGN KEY (slot_id) REFERENCES public.events_eventslot(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: booking_slotbooking plaza_slotbooking_user_id_47b2ab52_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_slotbooking
    ADD CONSTRAINT plaza_slotbooking_user_id_47b2ab52_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: booking_ticketbooking plaza_ticketbooking_event_id_e56bdb09_fk_plaza_event_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_ticketbooking
    ADD CONSTRAINT plaza_ticketbooking_event_id_e56bdb09_fk_plaza_event_id FOREIGN KEY (event_id) REFERENCES public.events_event(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: booking_ticketbooking plaza_ticketbooking_user_id_74395bac_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_ticketbooking
    ADD CONSTRAINT plaza_ticketbooking_user_id_74395bac_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wallet_transaction plaza_transaction_user_id_d861ca11_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallet_transaction
    ADD CONSTRAINT plaza_transaction_user_id_d861ca11_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict U7okGadqDP3kpo6qOtNzCr5r34u0sR8fhqiMMfDbq8Vhtfcd7LNyZ35kMXHeApv

