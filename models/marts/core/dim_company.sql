{{
  config(
    materialized='table',
  )
}}

    SELECT
        company_id,
        company

        FROM {{ ref("stg_hotel__company") }}