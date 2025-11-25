{{
  config(
    materialized='table',
  )
}}

    SELECT
        deposit_id,
        deposit_type

        FROM {{ ref("stg_hotel__deposit_type") }}