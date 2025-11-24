{{
  config(
    materialized='view',
  )
}}

    SELECT
        company_id,
        company

        FROM {{ ref("stg_hotel__company") }}