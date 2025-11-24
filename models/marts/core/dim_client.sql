{{
  config(
    materialized='view',
  )
}}

    SELECT
        client_id,
        name,
        email,
        phone_number,
        credit_card,
        is_valid_email_address

        FROM {{ ref("stg_hotel__client") }}
