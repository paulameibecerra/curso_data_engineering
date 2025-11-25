{{
  config(
    materialized='table',
  )
}}

    SELECT
        stays_id,
        stays_in_weekend_nights,
        stays_in_week_nights
        
        FROM {{ ref("stg_hotel__stays") }}