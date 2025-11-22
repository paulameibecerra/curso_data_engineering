{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT hotel
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        MD5(hotel) as hotel_id,
        hotel

    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted