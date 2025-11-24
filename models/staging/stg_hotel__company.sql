{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT DISTINCT company
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        MD5(company) as company_id,
        company
    FROM base__hotel_booking 
    )

SELECT * FROM renamed_casted