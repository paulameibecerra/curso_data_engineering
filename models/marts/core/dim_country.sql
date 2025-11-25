{{
  config(
    materialized='table',
  )
}}

    SELECT
        country_id,
        country

        FROM {{ ref("stg_hotel__country") }}
