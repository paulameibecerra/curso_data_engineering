{{
  config(
    materialized='view'
  )
}}

WITH base__hotel_booking AS (
    SELECT DISTINCT
        market_segment
    FROM {{ ref('base__hotel_booking') }}
),

renamed_casted AS (
    SELECT
        MD5(market_segment) AS market_segment_id,
        market_segment
    FROM base__hotel_booking
)

SELECT * FROM renamed_casted
