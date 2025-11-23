{{
  config(
    materialized='view',
  )
}}

    SELECT
        room_id,
        adults,
        reserved_room_type,
        assigned_room_type,
        CASE 
            WHEN reserved_room_type = assigned_room_type THEN TRUE
            ELSE FALSE
        END AS is_same_room_type

        FROM {{ ref("stg_hotel__room") }}