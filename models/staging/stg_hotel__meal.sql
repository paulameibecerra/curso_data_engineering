{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT meal, date_load
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        MD5(meal) as meal_id,
        meal,
        date_load
    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted