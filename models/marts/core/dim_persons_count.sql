{{
  config(
    materialized='table',
  )
}}

    SELECT
        person_count_id,
        adults,
        children,
        babies

        FROM {{ ref("stg_hotel__n_persons") }}