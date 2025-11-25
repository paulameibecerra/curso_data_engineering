{{
  config(
    materialized='incremental',
    unique_key = 'client_id'
  )
}}

WITH base__hotel_booking  AS (
    SELECT DISTINCT name, email, phone_number, credit_card, date_load
    FROM {{ ref("base__hotel_booking") }}

    {% if is_incremental() %}
    where date_load > (select max(date_load) from {{ this }})
    {% endif %}
    ),

renamed_casted AS ( 
    SELECT
        MD5(CONCAT(LOWER(name),LOWER(email), LOWER(phone_number))) as client_id,
        name,
        email,
        coalesce (regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')= true, false) as is_valid_email_address,
        phone_number,
        credit_card,
        date_load

    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted