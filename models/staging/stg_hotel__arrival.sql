{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT arrival_date_year, arrival_date_month, arrival_date_week_number, arrival_date_day_of_month, date_load
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        MD5(CONCAT(TO_VARCHAR(arrival_date_year), '-',TO_VARCHAR(arrival_date_month), '-',TO_VARCHAR(arrival_date_day_of_month), '-',TO_VARCHAR(arrival_date_week_number))) AS arrival_id,
        arrival_date_year,
        arrival_date_month as arrival_date_month_name,
        arrival_date_week_number,
        arrival_date_day_of_month,
        DATE_FROM_PARTS(arrival_date_year, TRY_TO_NUMBER(arrival_date_month), arrival_date_day_of_month) AS arrival_date,
        date_load

    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted