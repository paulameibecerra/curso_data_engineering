{{
  config(
    materialized='view',
  )
}}

    SELECT
        market_segment_id,
        market_segment

        FROM {{ ref("stg_hotel__market_segment") }}