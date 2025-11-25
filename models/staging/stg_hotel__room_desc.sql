{{
  config(
    materialized='view',
  )
}}

WITH staging__type_rooms  AS (
    SELECT *
    FROM {{ ref("staging__type_rooms") }}
    ),

renamed_casted AS ( 
    SELECT
        COALESCE(room_type, ''):: varchar as room_type,
        COALESCE(room_desc, ''):: varchar as room_desc
    FROM staging__type_rooms  
    )

SELECT * FROM renamed_casted