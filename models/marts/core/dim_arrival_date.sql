{{
  config(
    materialized='view',
  )
}}

    SELECT
        arrival_id,
        arrival_year,
        arrival_month_name,
        arrival_month,
        arrival_week,
        arrival_day,
        arrival_date

        FROM {{ ref("stg_hotel__arrival") }}
