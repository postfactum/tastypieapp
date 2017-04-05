--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO lostclus;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO lostclus;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO lostclus;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO lostclus;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO lostclus;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO lostclus;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(75) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO lostclus;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO lostclus;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO lostclus;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO lostclus;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO lostclus;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO lostclus;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: campaigns_campaign; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE campaigns_campaign (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    type smallint NOT NULL,
    domain character varying(200) NOT NULL,
    is_active boolean NOT NULL,
    is_scanning_enabled boolean NOT NULL,
    is_url_rewriting_enabled boolean NOT NULL
);


ALTER TABLE campaigns_campaign OWNER TO lostclus;

--
-- Name: campaigns_campaign_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE campaigns_campaign_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE campaigns_campaign_id_seq OWNER TO lostclus;

--
-- Name: campaigns_campaign_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE campaigns_campaign_id_seq OWNED BY campaigns_campaign.id;


--
-- Name: campaigns_competitor; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE campaigns_competitor (
    id integer NOT NULL,
    campaign_id integer NOT NULL,
    name character varying(200) NOT NULL,
    domain character varying(200) NOT NULL
);


ALTER TABLE campaigns_competitor OWNER TO lostclus;

--
-- Name: campaigns_competitor_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE campaigns_competitor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE campaigns_competitor_id_seq OWNER TO lostclus;

--
-- Name: campaigns_competitor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE campaigns_competitor_id_seq OWNED BY campaigns_competitor.id;


--
-- Name: campaigns_matching; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE campaigns_matching (
    id integer NOT NULL,
    product_id integer NOT NULL,
    competitor_id integer NOT NULL,
    url character varying(200) NOT NULL,
    price double precision
);


ALTER TABLE campaigns_matching OWNER TO lostclus;

--
-- Name: campaigns_matching_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE campaigns_matching_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE campaigns_matching_id_seq OWNER TO lostclus;

--
-- Name: campaigns_matching_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE campaigns_matching_id_seq OWNED BY campaigns_matching.id;


--
-- Name: campaigns_product; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE campaigns_product (
    id integer NOT NULL,
    campaign_id integer NOT NULL,
    url character varying(200) NOT NULL,
    title character varying(500) NOT NULL,
    price double precision
);


ALTER TABLE campaigns_product OWNER TO lostclus;

--
-- Name: campaigns_product_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE campaigns_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE campaigns_product_id_seq OWNER TO lostclus;

--
-- Name: campaigns_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE campaigns_product_id_seq OWNED BY campaigns_product.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    content_type_id integer,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO lostclus;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO lostclus;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO lostclus;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO lostclus;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO lostclus;

--
-- Name: south_migrationhistory; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE south_migrationhistory (
    id integer NOT NULL,
    app_name character varying(255) NOT NULL,
    migration character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE south_migrationhistory OWNER TO lostclus;

--
-- Name: south_migrationhistory_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE south_migrationhistory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE south_migrationhistory_id_seq OWNER TO lostclus;

--
-- Name: south_migrationhistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE south_migrationhistory_id_seq OWNED BY south_migrationhistory.id;


--
-- Name: tastypie_apiaccess; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE tastypie_apiaccess (
    id integer NOT NULL,
    identifier character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    request_method character varying(10) NOT NULL,
    accessed integer NOT NULL,
    CONSTRAINT tastypie_apiaccess_accessed_check CHECK ((accessed >= 0))
);


ALTER TABLE tastypie_apiaccess OWNER TO lostclus;

--
-- Name: tastypie_apiaccess_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE tastypie_apiaccess_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tastypie_apiaccess_id_seq OWNER TO lostclus;

--
-- Name: tastypie_apiaccess_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE tastypie_apiaccess_id_seq OWNED BY tastypie_apiaccess.id;


--
-- Name: tastypie_apikey; Type: TABLE; Schema: public; Owner: lostclus
--

CREATE TABLE tastypie_apikey (
    id integer NOT NULL,
    user_id integer NOT NULL,
    key character varying(256) NOT NULL,
    created timestamp with time zone NOT NULL
);


ALTER TABLE tastypie_apikey OWNER TO lostclus;

--
-- Name: tastypie_apikey_id_seq; Type: SEQUENCE; Schema: public; Owner: lostclus
--

CREATE SEQUENCE tastypie_apikey_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tastypie_apikey_id_seq OWNER TO lostclus;

--
-- Name: tastypie_apikey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lostclus
--

ALTER SEQUENCE tastypie_apikey_id_seq OWNED BY tastypie_apikey.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: campaigns_campaign id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_campaign ALTER COLUMN id SET DEFAULT nextval('campaigns_campaign_id_seq'::regclass);


--
-- Name: campaigns_competitor id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_competitor ALTER COLUMN id SET DEFAULT nextval('campaigns_competitor_id_seq'::regclass);


--
-- Name: campaigns_matching id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_matching ALTER COLUMN id SET DEFAULT nextval('campaigns_matching_id_seq'::regclass);


--
-- Name: campaigns_product id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_product ALTER COLUMN id SET DEFAULT nextval('campaigns_product_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: south_migrationhistory id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY south_migrationhistory ALTER COLUMN id SET DEFAULT nextval('south_migrationhistory_id_seq'::regclass);


--
-- Name: tastypie_apiaccess id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY tastypie_apiaccess ALTER COLUMN id SET DEFAULT nextval('tastypie_apiaccess_id_seq'::regclass);


--
-- Name: tastypie_apikey id; Type: DEFAULT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY tastypie_apikey ALTER COLUMN id SET DEFAULT nextval('tastypie_apikey_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add migration history	7	add_migrationhistory
20	Can change migration history	7	change_migrationhistory
21	Can delete migration history	7	delete_migrationhistory
22	Can add api access	8	add_apiaccess
23	Can change api access	8	change_apiaccess
24	Can delete api access	8	delete_apiaccess
25	Can add api key	9	add_apikey
26	Can change api key	9	change_apikey
27	Can delete api key	9	delete_apikey
28	Can add Skill	10	add_skill
29	Can change Skill	10	change_skill
30	Can delete Skill	10	delete_skill
31	Can add Contact	11	add_contact
32	Can change Contact	11	change_contact
33	Can delete Contact	11	delete_contact
34	Can add Campaign	12	add_campaign
35	Can change Campaign	12	change_campaign
36	Can delete Campaign	12	delete_campaign
37	Can add Product	13	add_product
38	Can change Product	13	change_product
39	Can delete Product	13	delete_product
40	Can add Competitor	14	add_competitor
41	Can change Competitor	14	change_competitor
42	Can delete Competitor	14	delete_competitor
43	Can add Matching	15	add_matching
44	Can change Matching	15	change_matching
45	Can delete Matching	15	delete_matching
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('auth_permission_id_seq', 45, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$12000$kPMn0pSUPa6g$wp6D2jS/sxFoLQEXD1bwQtNLosj6ZP+Djyn05Fb68Mw=	2016-10-05 10:43:25.359896+03	f	bob				f	t	2016-10-05 10:43:25.359931+03
3	pbkdf2_sha256$12000$P7Dl424t10T4$3gI3UVL9h11W4LFR57QZ4lVjaoljB569LxXOqsK+2Zk=	2016-10-05 10:47:16.243886+03	f	john				f	t	2016-10-05 10:47:16.244017+03
1	pbkdf2_sha256$12000$aYFgXKttGRHm$gCUHsSgY875MzlBBsTrzM10mZVPT+HKKkSxeLPo/hC8=	2017-03-03 11:02:22.57756+02	t	admin			admin@example.com	t	t	2016-10-05 10:23:23.89721+03
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('auth_user_id_seq', 3, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: campaigns_campaign; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY campaigns_campaign (id, name, type, domain, is_active, is_scanning_enabled, is_url_rewriting_enabled) FROM stdin;
1	Campaign 1	0	example.com	t	t	t
2	Campaign 2	1	example.com	t	t	t
\.


--
-- Name: campaigns_campaign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('campaigns_campaign_id_seq', 2, true);


--
-- Data for Name: campaigns_competitor; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY campaigns_competitor (id, campaign_id, name, domain) FROM stdin;
1	1	Competitor 1	c1.example.com
2	1	Competitor 2	c2.example.com
\.


--
-- Name: campaigns_competitor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('campaigns_competitor_id_seq', 2, true);


--
-- Data for Name: campaigns_matching; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY campaigns_matching (id, product_id, competitor_id, url, price) FROM stdin;
\.


--
-- Name: campaigns_matching_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('campaigns_matching_id_seq', 1, false);


--
-- Data for Name: campaigns_product; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY campaigns_product (id, campaign_id, url, title, price) FROM stdin;
1	1	http://example.com/product/1/	Product 1	\N
2	1	http://example.com/product/2/	Product 2	\N
3	1	http://example.com/product/3/	Product 3	\N
\.


--
-- Name: campaigns_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('campaigns_product_id_seq', 3, true);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY django_admin_log (id, action_time, user_id, content_type_id, object_id, object_repr, action_flag, change_message) FROM stdin;
1	2016-10-05 10:43:25.405023+03	1	4	2	bob	1	
2	2016-10-05 10:47:16.295409+03	1	4	3	john	1	
3	2016-10-05 10:47:56.36822+03	1	10	1	Python: 8	1	
4	2016-10-05 10:48:51.534051+03	1	9	1	12345 for admin	1	
5	2017-03-03 11:03:03.80198+02	1	12	1	Campaign 1	1	
6	2017-03-03 11:03:17.549167+02	1	12	2	Campaign 2	1	
7	2017-03-03 11:04:04.193755+02	1	13	1	Product 1	1	
8	2017-03-03 11:04:22.394118+02	1	13	2	Product 2	1	
9	2017-03-03 11:05:00.420341+02	1	13	3	Product 3	1	
10	2017-03-03 11:05:23.163674+02	1	14	1	Competitor 1	1	
11	2017-03-03 11:05:39.561296+02	1	14	2	Competitor 2	1	
12	2017-03-03 11:56:39.666968+02	1	12	1	Campaign 1	1	
13	2017-03-03 11:56:52.610614+02	1	12	2	Campaign 2	1	
14	2017-03-03 11:57:09.875131+02	1	13	1	Product 1	1	
15	2017-03-03 11:57:20.228983+02	1	13	2	Product 2	1	
16	2017-03-03 11:57:26.728272+02	1	13	3	Product 3	1	
17	2017-03-03 11:57:49.090749+02	1	14	1	Competitor 1	1	
18	2017-03-03 11:58:03.042761+02	1	14	2	Competitor 2	1	
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 18, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY django_content_type (id, name, app_label, model) FROM stdin;
1	log entry	admin	logentry
2	permission	auth	permission
3	group	auth	group
4	user	auth	user
5	content type	contenttypes	contenttype
6	session	sessions	session
7	migration history	south	migrationhistory
8	api access	tastypie	apiaccess
9	api key	tastypie	apikey
10	Skill	candidates	skill
11	Contact	candidates	contact
12	Campaign	campaigns	campaign
13	Product	campaigns	product
14	Competitor	campaigns	competitor
15	Matching	campaigns	matching
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('django_content_type_id_seq', 15, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
hfuipc2bt7xc7jfu5o8f359bslab3ce2	ZTRmM2Y4ODg3OTk2ZTgxYjVjYjFlNGVkZTFmN2E1MzQyM2I1Nzc0ZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=	2016-10-19 10:25:17.812247+03
bey5mhdsbqnyc16lzof01kkrh9s21jc8	ZTRmM2Y4ODg3OTk2ZTgxYjVjYjFlNGVkZTFmN2E1MzQyM2I1Nzc0ZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=	2017-03-17 11:02:22.58041+02
\.


--
-- Data for Name: south_migrationhistory; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY south_migrationhistory (id, app_name, migration, applied) FROM stdin;
1	tastypie	0001_initial	2016-10-05 10:23:24.101019+03
2	tastypie	0002_add_apikey_index	2016-10-05 10:23:24.119248+03
3	candidates	0001_initial	2016-10-05 10:23:24.184991+03
5	campaigns	0001_initial	2017-03-03 11:56:15.052854+02
\.


--
-- Name: south_migrationhistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('south_migrationhistory_id_seq', 5, true);


--
-- Data for Name: tastypie_apiaccess; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY tastypie_apiaccess (id, identifier, url, request_method, accessed) FROM stdin;
\.


--
-- Name: tastypie_apiaccess_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('tastypie_apiaccess_id_seq', 1, false);


--
-- Data for Name: tastypie_apikey; Type: TABLE DATA; Schema: public; Owner: lostclus
--

COPY tastypie_apikey (id, user_id, key, created) FROM stdin;
1	1	12345	2016-10-05 10:48:15+03
\.


--
-- Name: tastypie_apikey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lostclus
--

SELECT pg_catalog.setval('tastypie_apikey_id_seq', 1, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: campaigns_campaign campaigns_campaign_name_key; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_campaign
    ADD CONSTRAINT campaigns_campaign_name_key UNIQUE (name);


--
-- Name: campaigns_campaign campaigns_campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_campaign
    ADD CONSTRAINT campaigns_campaign_pkey PRIMARY KEY (id);


--
-- Name: campaigns_competitor campaigns_competitor_campaign_id_60043d4369e3aaf8_uniq; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_competitor
    ADD CONSTRAINT campaigns_competitor_campaign_id_60043d4369e3aaf8_uniq UNIQUE (campaign_id, name);


--
-- Name: campaigns_competitor campaigns_competitor_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_competitor
    ADD CONSTRAINT campaigns_competitor_pkey PRIMARY KEY (id);


--
-- Name: campaigns_matching campaigns_matching_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_matching
    ADD CONSTRAINT campaigns_matching_pkey PRIMARY KEY (id);


--
-- Name: campaigns_matching campaigns_matching_product_id_1c816bbac20ba6ea_uniq; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_matching
    ADD CONSTRAINT campaigns_matching_product_id_1c816bbac20ba6ea_uniq UNIQUE (product_id, competitor_id, url);


--
-- Name: campaigns_product campaigns_product_campaign_id_24b8b060ab728f9_uniq; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_product
    ADD CONSTRAINT campaigns_product_campaign_id_24b8b060ab728f9_uniq UNIQUE (campaign_id, url);


--
-- Name: campaigns_product campaigns_product_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_product
    ADD CONSTRAINT campaigns_product_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_key; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_key UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: south_migrationhistory south_migrationhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY south_migrationhistory
    ADD CONSTRAINT south_migrationhistory_pkey PRIMARY KEY (id);


--
-- Name: tastypie_apiaccess tastypie_apiaccess_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY tastypie_apiaccess
    ADD CONSTRAINT tastypie_apiaccess_pkey PRIMARY KEY (id);


--
-- Name: tastypie_apikey tastypie_apikey_pkey; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY tastypie_apikey
    ADD CONSTRAINT tastypie_apikey_pkey PRIMARY KEY (id);


--
-- Name: tastypie_apikey tastypie_apikey_user_id_key; Type: CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY tastypie_apikey
    ADD CONSTRAINT tastypie_apikey_user_id_key UNIQUE (user_id);


--
-- Name: auth_group_name_like; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX auth_group_name_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX auth_group_permissions_group_id ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX auth_group_permissions_permission_id ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX auth_permission_content_type_id ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX auth_user_groups_group_id ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX auth_user_groups_user_id ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX auth_user_user_permissions_permission_id ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX auth_user_user_permissions_user_id ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_like; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX auth_user_username_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: campaigns_campaign_domain; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX campaigns_campaign_domain ON campaigns_campaign USING btree (domain);


--
-- Name: campaigns_campaign_domain_like; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX campaigns_campaign_domain_like ON campaigns_campaign USING btree (domain varchar_pattern_ops);


--
-- Name: campaigns_campaign_is_active; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX campaigns_campaign_is_active ON campaigns_campaign USING btree (is_active);


--
-- Name: campaigns_campaign_is_scanning_enabled; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX campaigns_campaign_is_scanning_enabled ON campaigns_campaign USING btree (is_scanning_enabled);


--
-- Name: campaigns_campaign_is_url_rewriting_enabled; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX campaigns_campaign_is_url_rewriting_enabled ON campaigns_campaign USING btree (is_url_rewriting_enabled);


--
-- Name: campaigns_campaign_name_like; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX campaigns_campaign_name_like ON campaigns_campaign USING btree (name varchar_pattern_ops);


--
-- Name: campaigns_competitor_campaign_id; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX campaigns_competitor_campaign_id ON campaigns_competitor USING btree (campaign_id);


--
-- Name: campaigns_competitor_domain; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX campaigns_competitor_domain ON campaigns_competitor USING btree (domain);


--
-- Name: campaigns_competitor_domain_like; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX campaigns_competitor_domain_like ON campaigns_competitor USING btree (domain varchar_pattern_ops);


--
-- Name: campaigns_matching_competitor_id; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX campaigns_matching_competitor_id ON campaigns_matching USING btree (competitor_id);


--
-- Name: campaigns_matching_product_id; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX campaigns_matching_product_id ON campaigns_matching USING btree (product_id);


--
-- Name: campaigns_product_campaign_id; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX campaigns_product_campaign_id ON campaigns_product USING btree (campaign_id);


--
-- Name: django_admin_log_content_type_id; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX django_admin_log_content_type_id ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX django_admin_log_user_id ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX django_session_expire_date ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_like; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX django_session_session_key_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: tastypie_apikey_key; Type: INDEX; Schema: public; Owner: lostclus
--

CREATE INDEX tastypie_apikey_key ON tastypie_apikey USING btree (key);


--
-- Name: auth_group_permissions auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: campaigns_competitor campaign_id_refs_id_268d3e9d; Type: FK CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_competitor
    ADD CONSTRAINT campaign_id_refs_id_268d3e9d FOREIGN KEY (campaign_id) REFERENCES campaigns_campaign(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: campaigns_product campaign_id_refs_id_e6779220; Type: FK CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_product
    ADD CONSTRAINT campaign_id_refs_id_e6779220 FOREIGN KEY (campaign_id) REFERENCES campaigns_campaign(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: campaigns_matching competitor_id_refs_id_37c641e8; Type: FK CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_matching
    ADD CONSTRAINT competitor_id_refs_id_37c641e8 FOREIGN KEY (competitor_id) REFERENCES campaigns_competitor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log content_type_id_refs_id_93d2d1f8; Type: FK CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT content_type_id_refs_id_93d2d1f8 FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission content_type_id_refs_id_d043b34a; Type: FK CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT content_type_id_refs_id_d043b34a FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions group_id_refs_id_f4b32aac; Type: FK CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT group_id_refs_id_f4b32aac FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: campaigns_matching product_id_refs_id_d01eb904; Type: FK CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY campaigns_matching
    ADD CONSTRAINT product_id_refs_id_d01eb904 FOREIGN KEY (product_id) REFERENCES campaigns_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups user_id_refs_id_40c41112; Type: FK CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT user_id_refs_id_40c41112 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions user_id_refs_id_4dc23c39; Type: FK CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT user_id_refs_id_4dc23c39 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tastypie_apikey user_id_refs_id_990aee10; Type: FK CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY tastypie_apikey
    ADD CONSTRAINT user_id_refs_id_990aee10 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log user_id_refs_id_c0d12874; Type: FK CONSTRAINT; Schema: public; Owner: lostclus
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT user_id_refs_id_c0d12874 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

