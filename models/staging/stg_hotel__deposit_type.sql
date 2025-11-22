{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT DISTINCT deposit_type
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        MD5(deposit_type) as deposit_id,
        deposit_type
    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted