{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT DISTINCT agent
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        MD5(agent) as agent_id,
        agent
    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted