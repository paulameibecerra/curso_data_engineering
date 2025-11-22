{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT DISTINCT name, email, phone_number, credit_card
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        MD5(CONCAT(name, email)) as client_id,
        name,
        email,
        coalesce (regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')= true,false) as is_valid_email_address,
        phone_number,
        credit_card

    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted