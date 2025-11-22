{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT DISTINCT country
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        MD5(country) as country_id,
        country
    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted