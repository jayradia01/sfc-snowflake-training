USE ROLE TRAININGDBA;
USE DATABASE TRAINING;
USE SCHEMA PUBLIC;
USE WAREHOUSE XSMALL;

-- 1.- Load files to stage, It does not work with the UI, use snowsql, etc.
PUT file:///workspaces/sfc-snowflake-training/training/02_snowsql_loading_structured/housing.csv @TRAINING.PUBLIC.INTERNAL_STAGE AUTO_COMPRESS=TRUE;

LIST @TRAINING.PUBLIC.INTERNAL_STAGE;
