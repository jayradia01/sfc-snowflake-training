USE ROLE TRAININGDBA;
USE DATABASE TRAINING;
USE SCHEMA PUBLIC;
USE WAREHOUSE XSMALL;

-- 1.- Select data from Internal Stage
SELECT  t.$1::VARCHAR AS longitude,
        t.$2::VARCHAR AS latitude,
        t.$3::NUMERIC AS housing_median_age,
        t.$4::NUMERIC AS total_rooms,
        t.$5::NUMERIC AS total_bedrooms,
        t.$6::NUMERIC AS population,
        t.$7::NUMERIC AS households,
        t.$8::NUMERIC AS median_income,
        t.$9::NUMERIC AS median_house_value,
        t.$10::VARCHAR AS ocean_proximity
FROM @TRAINING.PUBLIC.INTERNAL_STAGE (FILE_FORMAT => TRAINING.PUBLIC.CSV_GENERIC_FORMAT, PATTERN => '.*.gz') t SAMPLE(100 ROWS) ;

-- 2.- Create table
CREATE OR REPLACE TABLE TRAINING.PUBLIC.HOUSING (
    LONGITUDE          VARCHAR,
    LATITUDE           VARCHAR,
    HOUSING_MEDIAN_AGE NUMBER,
    TOTAL_ROOMS        NUMBER,
    TOTAL_BEDROOMS     NUMBER,
    POPULATION         NUMBER,
    HOUSEHOLDS         NUMBER,
    MEDIAN_INCOME      NUMBER,
    MEDIAN_HOUSE_VALUE NUMBER,
    OCEAN_PROXIMITY    VARCHAR
);

-- 3.- Loading and transforming timestamp at load time
COPY INTO TRAINING.PUBLIC.HOUSING 
    FROM (
        SELECT  t.$1::VARCHAR AS longitude,
                t.$2::VARCHAR AS latitude,
                t.$3::NUMERIC AS housing_median_age,
                t.$4::NUMERIC AS total_rooms,
                t.$5::NUMERIC AS total_bedrooms,
                t.$6::NUMERIC AS population,
                t.$7::NUMERIC AS households,
                t.$8::NUMERIC AS median_income,
                t.$9::NUMERIC AS median_house_value,
                t.$10::VARCHAR AS ocean_proximity
        FROM @TRAINING.PUBLIC.INTERNAL_STAGE (FILE_FORMAT => TRAINING.PUBLIC.CSV_GENERIC_FORMAT, PATTERN => '.*.gz') t
    )
    FILE_FORMAT = (FORMAT_NAME = TRAINING.PUBLIC.CSV_GENERIC_FORMAT)
    PATTERN = '.*.gz'
    ON_ERROR = 'skip_file'
    PURGE = FALSE;

-- 4.- Selecting from table
SELECT *
FROM TRAINING.PUBLIC.HOUSING
LIMIT 100;
