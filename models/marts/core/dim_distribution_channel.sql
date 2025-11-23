{{
  config(
    materialized='view',
  )
}}

    SELECT
        distribution_channel_id,
        distribution_channel

        FROM {{ ref("stg_hotel__distribution_channel") }}