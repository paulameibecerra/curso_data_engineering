{{
  config(
    materialized='table',
  )
}}

    SELECT
        customer_type_id,
        customer_type

        FROM {{ ref("stg_hotel__customer_type") }}