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
        credit_card

        FROM {{ ref("stg_hotel__client") }}
