{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT DISTINCT adults, children, babies
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        CONCAT(TO_VARCHAR(COALESCE(adults,0)), '-', TO_VARCHAR(COALESCE(children,0)), '-', TO_VARCHAR(COALESCE(babies,0))) AS person_count_id,
        adults,
        COALESCE(children, 0) AS children,
        babies,
        adults + children + babies as total

    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted