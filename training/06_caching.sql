-- Caching and Query Performance

USE ROLE ACCOUNTADMIN;
USE DATABASE SNOWFLAKE_SAMPLE_DATA;
USE SCHEMA TPCDS_SF100TCL;
USE WAREHOUSE XSMALL;

-- 1. Run and go and check the execution plan.
SELECT DISTINCT C_SALUTATION,
       C_BIRTH_COUNTRY
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CUSTOMER;

-- 1.1 Rerun and check the execution plan.
SELECT DISTINCT C_SALUTATION,
       C_BIRTH_COUNTRY
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CUSTOMER;



-- 2   Run the following SQL statement:

SELECT 
          MIN(ps_partkey)
        , MAX(ps_partkey) 
        
FROM 
        SNOWFLAKE_SAMPLE_DATA.TPCH_SF1000.PARTSUPP;

--         Now check the Query Profile. You should see a single node that says
--         METADATA-BASED RESULT. This is because the query profile simply went
--         to cache to get the data you needed rather than scanning a table. So,
--         there was no disk I/O at all.

-- 5.5.0   Data Warehouse Cache
--         Like any other database system, Snowflake caches data from queries
--         you run so it can be accessed later by other queries. This cache is
--         saved to disk in the virtual warehouse. Let’s take a look at how it works.
--         Once again, let’s assume you’ve been asked to analyze the part and
--         supplier data.

-- 5.5.1   Clear your cache:

ALTER SESSION SET USE_CACHED_RESULT = FALSE;
ALTER WAREHOUSE XSMALL SUSPEND;
ALTER WAREHOUSE XSMALL RESUME;


-- 5.5.2   Run the SQL statement below.
--         Let’s start by selecting two columns, ps_suppkey, and ps_availqty with
--         a WHERE clause selects only part of the dataset. This will cache the
--         data for the two columns plus the column in the WHERE clause.

SELECT 
          ps_partkey
        , ps_availqty
        
FROM 
        SNOWFLAKE_SAMPLE_DATA.TPCH_SF1000.PARTSUPP;
        
WHERE 
        ps_partkey > 1000000; 
