{% snapshot room_check_snp %}

{{
    config(
        target_schema='snapshots',
        unique_key='room_id',
        strategy='check',
        check_cols = ['reserved_room_type', 'assigned_room_type']
    )
}}

SELECT
    room_id,
    reserved_room_type,
    assigned_room_type,
FROM {{ ref('stg_hotel__room') }}
 
{% endsnapshot %}