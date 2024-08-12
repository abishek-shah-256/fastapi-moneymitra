-- Database: wdphsdb

-- DROP DATABASE IF EXISTS wdphsdb;

CREATE DATABASE wdphsdb
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_India.1252'
    LC_CTYPE = 'English_India.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- CREATE SCHEMA
CREATE SCHEMA wdphsschema AUTHORIZATION postgres;


-- CREATE SEQUENCES
CREATE SEQUENCE wdphsschema.seq_phs_requests AS bigint START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE wdphsschema.seq_phs_rq_dtl AS bigint START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE wdphsschema.seq_stress_test_rq AS bigint START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE wdphsschema.seq_stress_scene AS bigint START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE wdphsschema.seq_scene_reg AS bigint START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE wdphsschema.seq_pf_master AS bigint START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE wdphsschema.seq_pf_prices AS bigint START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE wdphsschema.seq_bm_master AS bigint START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE wdphsschema.seq_bm_prices AS bigint START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE wdphsschema.seq_mkt_data AS bigint START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE wdphsschema.seq_repts_meta AS bigint START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE wdphsschema.seq_stress_report_data AS bigint START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE wdphsschema.seq_backtst_mast_report_data AS bigint START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE wdphsschema.seq_backtst__ts_report_data AS bigint START WITH 1 INCREMENT BY 1;


-- CREATE TABLES
    -- PORTFOLIO HEALTH SERVICE - ALL REQUESTS ( viz., PHS REQUEST)
CREATE TABLE IF NOT EXISTS wdphsschema.PHS_REQUEST(
    phs_seqid           bigint NOT NULL DEFAULT nextval('wdphsschema.seq_phs_requests' ::regclass),
    phs_tntid           varchar(10),
    phs_orgid           varchar(10),
    phs_reqid           varchar(10),
    phs_req_type        varchar(20),
    phs_req_date        timestamp,
    phs_pf_id           varchar(10),
    phs_pf_type         varchar(10),        -- MODEL/REAL/UPLOADED
    phs_desc            varchar(250),
    phs_bm_id           varchar(10),
    phs_bm_version      integer,
    phs_doc_id          varchar(10),
    phs_calc_compl      varchar(1),
    phs_rept_pr         varchar(1),
    created_userid      varchar(50),
    created_date        timestamp,
    CONSTRAINT phs_req_pk PRIMARY KEY (phs_seqid)
);
CREATE INDEX ix_phsrq_id ON wdphsschema.PHS_REQUEST (phs_reqid);
CREATE INDEX ix_phsrq1 ON wdphsschema.PHS_REQUEST(phs_tntid,phs_orgid);

    -- PHS REQUEST DETAILS
CREATE TABLE IF NOT EXISTS wdphsschema.PHS_REQ_DETAILS(
    phrqd_seqid         bigint NOT NULL DEFAULT nextval('wdphsschema.seq_phs_rq_dtl'::regclass),
    phrqd_tntid         varchar(10),
    phrqd_orgid         varchar(10),
    phrqd_reqid         varchar(10),
    phrqd_ticker        varchar(50),
    phrqd_isin          varchar(12),
    phrqd_weight        float8,
    CONSTRAINT phs_rqdt_pk PRIMARY KEY (phrqd_seqid)
);
CREATE INDEX ix_phrqd_id ON wdphsschema.PHS_REQ_DETAILS(phrqd_reqid);
CREATE INDEX ix_phrqd1 ON wdphsschema.PHS_REQ_DETAILS(phrqd_tntid,phrqd_orgid);

    -- PHS STRESS TEST REQUEST
CREATE TABLE IF NOT EXISTS wdphsschema.PHS_STRESS_TEST_REQUEST(
    pstr_seqid          bigint NOT NULL DEFAULT nextval('wdphsschema.seq_stress_test_rq'::regclass),
    pstr_tntid          varchar(10),
    pstr_orgid          varchar(10),
    pstr_reqid          varchar(10),
    pstr_sceneid        varchar(10),
    pstr_scene_ver      integer,
    CONSTRAINT phs_strq_pk PRIMARY KEY (pstr_seqid)
);
CREATE INDEX ix_pstr_id ON wdphsschema.PHS_STRESS_TEST_REQUEST(pstr_reqid);
CREATE INDEX ix_pstr1 ON wdphsschema.PHS_STRESS_TEST_REQUEST(pstr_tntid,pstr_orgid);

    -- STRESS SCENARIOS
CREATE TABLE IF NOT EXISTS wdphsschema.STRESS_SCENES(
    srsc_seqid          bigint NOT NULL DEFAULT nextval('wdphsschema.seq_stress_scene'::regclass),
    srsc_tntid          varchar(10),
    srsc_orgid          varchar(10),
    srsc_strscid        varchar(10),
    srsc_name           varchar(50),
    srsc_startdate      timestamp,
    srsc_enddate        timestamp,
    srsc_desc           varchar(1000),
    srsc_version        integer,
    created_userid      varchar(50),
    created_date        timestamp,
    modified_userid     varchar(50),
    modified_date       timestamp,
    CONSTRAINT stress_scen_pk PRIMARY KEY (srsc_seqid)
);
CREATE INDEX ix_srsc_id ON wdphsschema.STRESS_SCENES (srsc_strscid);
CREATE INDEX ix_srsc1 ON wdphsschema.STRESS_SCENES(srsc_tntid,srsc_orgid);

    -- PORTFOLIO MASTER 
CREATE TABLE IF NOT EXISTS wdphsschema.PORTFOLIO_MASTER(
	pf_seqid               bigint NOT NULL DEFAULT nextval('wdphsschema.seq_pf_master'::regclass),
	pf_tntid               varchar(10),
	pf_orgid               varchar(10),
	pf_phs_reqid           varchar(10),
	pf_id                  varchar(10),
	pf_date                timestamp,
	pf_name                varchar(50),
	pf_desc                varchar(250),
	pf_ticker              varchar(50),
	pf_isin                varchar(12),
	pf_weight              float8,
	pf_version             integer,
	pf_status              varchar(20),
	created_userid         varchar(50),
	created_date           timestamp,
	modified_userid        varchar(50),
	modified_date          timestamp,
	CONSTRAINT pf_master_pk PRIMARY KEY (pf_seqid)
);
CREATE INDEX ix_pfm_id ON  wdphsschema.PORTFOLIO_MASTER (pf_id);
CREATE INDEX ix_pfm1 ON  wdphsschema.PORTFOLIO_MASTER(pf_tntid,pf_orgid);

    -- PORTFOLIO PRICES
CREATE TABLE IF NOT EXISTS wdphsschema.PORTFOLIO_PRICES(
    pfpr_seqid              bigint NOT NULL DEFAULT nextval('wdphsschema.seq_pf_prices'::regclass),
    pfpr_tntid              varchar(10),
    pfpr_orgid              varchar(10),
    pfpr_pfid               varchar(10),
    pfpr_date               timestamp,
    pfpr_pf_price           float8,
    CONSTRAINT pf_prices_pk PRIMARY KEY (pfpr_seqid)
);
CREATE INDEX ix_pfpr_id ON wdphsschema.PORTFOLIO_PRICES(pfpr_pfid);
CREATE INDEX ix_pfpr1 ON wdphsschema.PORTFOLIO_PRICES(pfpr_tntid,pfpr_orgid);

    -- BENCHMARK MASTER DATA
CREATE TABLE IF NOT EXISTS wdphsschema.BENCHMARK_MASTER(
    bm_seqid          bigint NOT NULL DEFAULT nextval('wdphsschema.seq_bm_master'::regclass),
    bm_tntid          varchar(10),
    bm_orgid          varchar(10),
    bm_id             varchar(10),
	bm_name           varchar(50),
	bm_desc           varchar(250),
	bm_index          varchar(50),
	bm_isin           varchar(12),
	bm_weight         float8,
	bm_version        integer,
	bm_it_owned       varchar(1),
    created_userid    varchar(50),
    created_date      timestamp,
    modified_userid   varchar(50),
    modified_date     timestamp,
    CONSTRAINT bm_perf_pk PRIMARY KEY (bm_seqid)
);
CREATE INDEX ix_bm_id ON wdphsschema.BENCHMARK_MASTER (bm_id);
CREATE INDEX ix_bm1 ON wdphsschema.BENCHMARK_MASTER(bm_tntid,bm_orgid);

    -- BENCHMARK PRICES
CREATE TABLE IF NOT EXISTS wdphsschema.BENCHMARK_PRICES(
    bmpr_seqid              bigint NOT NULL DEFAULT nextval('wdphsschema.seq_bm_prices'::regclass),
    bmpr_tntid              varchar(10),
    bmpr_orgid              varchar(10),
    bmpr_bmid               varchar(10),
    bmpr_date               timestamp,
    bmpr_bm_price           float8,
    CONSTRAINT bm_prices_pk PRIMARY KEY (bmpr_seqid)
);
CREATE INDEX ix_bmpr_id ON wdphsschema.BENCHMARK_PRICES(bmpr_bmid);
CREATE INDEX ix_bmpr1 ON wdphsschema.BENCHMARK_PRICES(bmpr_tntid,bmpr_orgid);

    -- MARKET DATA
CREATE TABLE IF NOT EXISTS wdphsschema.MARKET_DATA(
    mktd_seqid          bigint NOT NULL DEFAULT nextval('wdphsschema.seq_mkt_data'::regclass),
    mktd_tntid          varchar(10),
    mktd_orgid          varchar(10),
    mktd_date           timestamp,
    mktd_isin           varchar(12),
    mktd_ticker         varchar(20),
    mktd_name           varchar(50),
    mktd_open           float8,
    mktd_high           float8,
    mktd_low            float8,
    mktd_close          float8,
    mktd_volume         float8,
    mktd_adj_close      float8,
    created_userid      varchar(50),
    created_date        timestamp,
    modified_userid     varchar(50),
    modified_date       timestamp,
    CONSTRAINT mkt_dta_pk PRIMARY KEY (mktd_seqid)
);
CREATE INDEX ix_mktd_id ON wdphsschema.MARKET_DATA (mktd_date);
CREATE INDEX ix_mktd1 ON wdphsschema.MARKET_DATA(mktd_tntid,mktd_orgid);

     -- SCENARIO ANALYSIS REGISTERS
CREATE TABLE IF NOT EXISTS wdphsschema.SCENARIO_REGISTER(
    scrg_seqid          bigint NOT NULL DEFAULT nextval('wdphsschema.seq_scene_reg'::regclass),
    scrg_tntid          varchar(10),
    scrg_orgid          varchar(10),
    scrg_sceneid        varchar(10),
    scrg_scenename      varchar(50),
    scrg_bkindex        varchar(10),
    scrg_daycount       integer,
    scrg_retpc          float8,
    scrg_voltpc         float8,
    scrg_version        integer,
    created_userid      varchar(50),
    created_date        timestamp,
    modified_userid     varchar(50),
    modified_date       timestamp,
    CONSTRAINT scene_reg_pk PRIMARY KEY (scrg_seqid)
);
CREATE INDEX ix_scrg_id ON wdphsschema.SCENARIO_REGISTER(scrg_sceneid);
CREATE INDEX ix_scrg1 ON wdphsschema.SCENARIO_REGISTER(scrg_tntid,scrg_orgid);


    -- REPORT GENERATION DATA  -REPORT METADATA
CREATE TABLE IF NOT EXISTS wdphsschema.REPORTS_METADATA(
    rpmd_seqid          bigint NOT NULL DEFAULT nextval('wdphsschema.seq_repts_meta'::regclass),
    rpmd_tntid          varchar(10),
    rpmd_orgid          varchar(10),
    rpmd_repid          varchar(10),
    rpmd_rep_reqid      varchar(10),
    rpmd_report_type     varchar(20),
    rpmd_rept_date      timestamp,
    rpmd_orgname        varchar(50),
    rpmd_username       varchar(50),
    rpmd_pfid           varchar(10),
    rpmd_pf_name        varchar(50),
    rpmd_bmid           varchar(10),
    rpmd_bm_name        varchar(50),
    created_userid      varchar(50),
    created_date        timestamp,
    modified_userid     varchar(50),
    modified_date       timestamp,
    CONSTRAINT report_meta_pk PRIMARY KEY (rpmd_seqid)
);
CREATE INDEX ix_rpmd_id ON wdphsschema.REPORTS_METADATA (rpmd_repid);
CREATE INDEX ix_rpmd1 ON wdphsschema.REPORTS_METADATA(rpmd_tntid,rpmd_orgid);

    -- REPORT GENERATION DATA  - STRESS TEST REPORT DATA
CREATE TABLE IF NOT EXISTS wdphsschema.STRESS_REPORT_DATA(
    strp_seqid         bigint NOT NULL DEFAULT nextval('wdphsschema.seq_stress_report_data'::regclass),
    strp_tntid         varchar(10),
    strp_orgid         varchar(10),
    strp_repid         varchar(10),
    strp_scene_name    varchar(50),
    strp_startdate     timestamp,
    strp_enddate       timestamp,
    strp_pf_ret_pc     float8,
    strp_bm_ret_pc     float8,
    CONSTRAINT stress_report_pk PRIMARY KEY (strp_seqid)
);
CREATE INDEX ix_strp_id ON wdphsschema.STRESS_REPORT_DATA(strp_repid);
CREATE INDEX ix_strp1 ON wdphsschema.STRESS_REPORT_DATA(strp_tntid,strp_orgid);

    -- REPORT GENERATION DATA  - BACKTEST METRICS REPORT DATA
CREATE TABLE IF NOT EXISTS wdphsschema.BACKTEST_METRICS_REPORT_DATA(
    bmrd_seqid          bigint NOT NULL DEFAULT nextval('wdphsschema.seq_backtst_mast_report_data'::regclass),
    bmrd_tntid          varchar(10),
    bmrd_orgid          varchar(10),
    bmrd_repid          varchar(10),
    bmrd_bt_name        varchar(50),
    bmrd_pf_retpc       float8,
    bmrd_bm_retpc       float8,
    CONSTRAINT backtest_metrics_report_pk PRIMARY KEY(bmrd_seqid)
);
CREATE INDEX ix_bmrd_id ON wdphsschema.BACKTEST_METRICS_REPORT_DATA(bmrd_repid);
CREATE INDEX ix_bmrd1 ON wdphsschema.BACKTEST_METRICS_REPORT_DATA(bmrd_tntid,bmrd_orgid);

    -- REPORT GENERATION DATA  - BACKTEST TS REPORT DATA
CREATE TABLE IF NOT EXISTS wdphsschema.BACKTEST_TS_REPORT_DATA(
    btrd_seqid          bigint NOT NULL DEFAULT nextval('wdphsschema.seq_backtst__ts_report_data'::regclass),
    btrd_tntid          varchar(10),
    btrd_orgid          varchar(10),
    btrd_repid          varchar(10),
    btrd_bt_name        varchar(50),
    btrd_report_data    json,
    CONSTRAINT backtest_ts_report_pk PRIMARY KEY (btrd_seqid)
);
CREATE INDEX ix_btrd_id ON wdphsschema.BACKTEST_TS_REPORT_DATA(btrd_repid);
CREATE INDEX ix_btrd1 ON wdphsschema.BACKTEST_TS_REPORT_DATA(btrd_tntid,btrd_orgid);
