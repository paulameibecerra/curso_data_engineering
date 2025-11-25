{{
  config(
    materialized='table',
  )
}}

    SELECT
        hotel_id,
        hotel

        FROM {{ ref("stg_hotel__hotel") }}
