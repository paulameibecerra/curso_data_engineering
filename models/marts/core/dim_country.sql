{{
  config(
    materialized='view',
  )
}}

    SELECT
        country_id,
        country

        FROM {{ ref("stg_hotel__country") }}
