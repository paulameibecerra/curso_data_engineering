{% snapshot client_timestamp_snp %}

{{
    config(
        target_schema='snapshots',
        unique_key='client_id',
        strategy='timestamp',
        updated_at= 'date_load',
    )
}}

SELECT
    *
FROM {{ ref('stg_hotel__client') }}
 
{% endsnapshot %}