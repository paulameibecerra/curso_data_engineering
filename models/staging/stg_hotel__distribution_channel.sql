{{
  config(
    materialized='view'
  )
}}

WITH base__hotel_booking AS (
    SELECT DISTINCT
        distribution_channel
    FROM {{ ref('base__hotel_booking') }}
),

renamed_casted AS (
    SELECT
        MD5(distribution_channel) AS distribution_channel_id,
        distribution_channel
    FROM base__hotel_booking
)

SELECT * FROM renamed_casted
