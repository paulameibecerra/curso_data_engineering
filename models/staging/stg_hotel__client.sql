{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT name, email, phone_number, credit_card
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        MD5(CONCAT(name, email)) as client_id,
        name,
        email,
        phone_number,
        credit_card

    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted