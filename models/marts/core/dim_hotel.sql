{{
  config(
    materialized='view',
  )
}}

    SELECT
        hotel_id,
        hotel

        FROM {{ ref("stg_hotel__hotel") }}
