{{
  config(
    materialized='table',
  )
}}

    SELECT
        agent_id,
        agent

        FROM {{ ref("stg_hotel__agent") }}