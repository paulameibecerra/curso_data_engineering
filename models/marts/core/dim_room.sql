{{
    config(
        materialized='table'
    )
}}

WITH base AS (
    SELECT
        room_id,
        reserved_room_type,
        assigned_room_type
    FROM {{ ref('stg_hotel__room') }}
),

reserved_desc AS (
    SELECT
        room_type,
        room_desc AS reserved_room_type_desc
    FROM {{ ref('stg_hotel__room_desc') }}
),

assigned_desc AS (
    SELECT
        room_type,
        room_desc AS assigned_room_type_desc
    FROM {{ ref('stg_hotel__room_desc') }}
)

SELECT
    b.room_id,
    b.reserved_room_type,
    r.reserved_room_type_desc,
    b.assigned_room_type,
    a.assigned_room_type_desc,
    CASE 
        WHEN reserved_room_type = assigned_room_type THEN TRUE
        ELSE FALSE
        END AS is_same_room_type

FROM base b
LEFT JOIN reserved_desc r
    ON b.reserved_room_type = r.room_type
LEFT JOIN assigned_desc a
    ON b.assigned_room_type = a.room_type

       
