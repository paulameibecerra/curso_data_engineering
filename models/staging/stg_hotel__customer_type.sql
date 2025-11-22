{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking  AS (
    SELECT customer_type, date_load
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        MD5(customer_type) as customer_type_id,
        customer_type,
        date_load
    FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted