{{
  config(
    materialized='view',
  )
}}

    SELECT
        person_count_id,
        adults,
        children,
        babies,
        total

        FROM {{ ref("stg_hotel__n_persons") }}