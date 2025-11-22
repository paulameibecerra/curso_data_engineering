{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT DISTINCT arrival_date_year, arrival_date_month, arrival_date_week_number, arrival_date_day_of_month
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        MD5(CONCAT(TO_VARCHAR(arrival_date_year), '-',TO_VARCHAR(arrival_date_month), '-',TO_VARCHAR(arrival_date_day_of_month), '-',TO_VARCHAR(arrival_date_week_number))) AS arrival_id,
        arrival_date_year,
        arrival_date_month,
        CASE UPPER(arrival_date_month)
            WHEN 'JANUARY' THEN 1
            WHEN 'FEBRUARY' THEN 2
            WHEN 'MARCH' THEN 3
            WHEN 'APRIL' THEN 4
            WHEN 'MAY' THEN 5
            WHEN 'JUNE' THEN 6
            WHEN 'JULY' THEN 7
            WHEN 'AUGUST' THEN 8
            WHEN 'SEPTEMBER' THEN 9
            WHEN 'OCTOBER' THEN 10
            WHEN 'NOVEMBER' THEN 11
            WHEN 'DECEMBER' THEN 12
        END AS arrival_date_month_number,
        arrival_date_week_number,
        arrival_date_day_of_month,
        DATE_FROM_PARTS(arrival_date_year, arrival_date_month_number, arrival_date_day_of_month) AS arrival_date

    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted