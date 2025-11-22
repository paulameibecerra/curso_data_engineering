{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT DISTINCT reserved_room_type, assigned_room_type
    FROM {{ ref("base__hotel_booking") }}
    ),


renamed_casted AS ( 
    SELECT
        CONCAT(reserved_room_type, '-', assigned_room_type) as room_id,
        reserved_room_type,
        assigned_room_type
    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted