{{
  config(
    materialized='table',
  )
}}

    SELECT
        meal_id,
        meal

        FROM {{ ref("stg_hotel__meal") }}