{{
  config(
    materialized='view',
  )
}}

    SELECT
        stays_id,
        stays_in_weekend_nights,
        stays_in_week_nights,
        total_stays_nights
        
        FROM {{ ref("stg_hotel__stays") }}