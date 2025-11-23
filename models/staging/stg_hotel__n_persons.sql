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
        CONCAT(TO_VARCHAR(adults), '-', TO_VARCHAR(children), '-' ,TO_VARCHAR(babies)) as person_count_id,
        adults,
        children,
        babies,
        adults + children + babies as total

    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted