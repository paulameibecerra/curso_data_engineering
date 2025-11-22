{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT DISTINCT meal
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        MD5(meal) as meal_id,
        meal
    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted