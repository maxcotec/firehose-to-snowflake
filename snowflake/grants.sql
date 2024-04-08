use DATABASE MY_DEV_DB;
use role ACCOUNTADMIN;

-- user grants
GRANT ROLE SERVICE_TELEMETRY_ROLE TO USER SERVICE_TELEMETRY_USER;
ALTER USER SERVICE_TELEMETRY_USER SET DEFAULT_ROLE = SERVICE_TELEMETRY_ROLE;
ALTER USER SERVICE_TELEMETRY_USER SET DEFAULT_WAREHOUSE ='TELEMETRY_INGESTION_XSMALL';
ALTER USER SERVICE_TELEMETRY_USER UNSET password; --NO PASSWORD
-- generate private-key: `openssl genrsa -out privatekey.pem 2048`
-- generate public keyL `openssl rsa -in privatekey.pem -pubout -out publickey.crt`
ALTER USER SERVICE_TELEMETRY_USER SET RSA_PUBLIC_KEY = '--- public key here (no new line) ---'
GRANT USAGE on DATABASE MY_DEV_DB TO ROLE SERVICE_TELEMETRY_ROLE;
GRANT USAGE, MONITOR, OPERATE ON WAREHOUSE TELEMETRY_INGESTION_XSMALL TO ROLE SERVICE_TELEMETRY_ROLE;

-- schema grants
CREATE SCHEMA IF NOT EXISTS TELEMETRY_TEST;
use SCHEMA TELEMETRY_TEST;
GRANT USAGE ON SCHEMA TELEMETRY_TEST TO ROLE SERVICE_TELEMETRY_ROLE;
GRANT CREATE TABLE ON SCHEMA TELEMETRY_TEST TO ROLE SERVICE_TELEMETRY_ROLE;
GRANT CREATE VIEW ON SCHEMA TELEMETRY_TEST TO ROLE SERVICE_TELEMETRY_ROLE;
GRANT CREATE MATERIALIZED VIEW ON SCHEMA TELEMETRY_TEST TO ROLE SERVICE_TELEMETRY_ROLE;
GRANT ALL ON SCHEMA TELEMETRY_TEST TO ROLE SERVICE_TELEMETRY_ROLE;

-- table grants
GRANT SELECT, INSERT, UPDATE, REFERENCES ON ALL TABLES IN SCHEMA TELEMETRY_TEST TO ROLE SERVICE_TELEMETRY_ROLE;
GRANT SELECT, INSERT, UPDATE, REFERENCES ON FUTURE TABLES IN SCHEMA  TELEMETRY_TEST TO ROLE SERVICE_TELEMETRY_ROLE;
