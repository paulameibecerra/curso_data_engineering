{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT DISTINCT stays_in_weekend_nights, stays_in_week_nights
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        CONCAT(TO_VARCHAR(stays_in_weekend_nights), '-', TO_VARCHAR(stays_in_week_nights)) as stays_id,
        stays_in_weekend_nights,
        stays_in_week_nights

    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted