{{
  config(
    materialized='incremental',
    unique_key = 'booking_id'
  )
}}

WITH base__hotel_booking AS (
    SELECT * 
    FROM {{ ref("base__hotel_booking") }}

    {% if is_incremental() %}
    where _fivetran_synced > (select max(date_load) from {{ this }})
    {% endif %}
    ),

renamed_casted AS ( 
    SELECT
        booking_id,
        MD5(CONCAT(LOWER(name), LOWER(email), LOWER(phone_number))) as client_id,
        MD5(hotel) as hotel_id,
        MD5(CONCAT(TO_VARCHAR(arrival_date_year), '-',TO_VARCHAR(arrival_date_month), '-',TO_VARCHAR(arrival_date_day_of_month), '-',TO_VARCHAR(arrival_date_week_number))) AS arrival_id,
        CONCAT(TO_VARCHAR(adults), '-', TO_VARCHAR(children), '-', TO_VARCHAR(babies)) AS person_count_id,
        CONCAT(reserved_room_type, '-', assigned_room_type) as room_id,
        MD5(country) as country_id,
        CONCAT(TO_VARCHAR(stays_in_weekend_nights), '-', TO_VARCHAR(stays_in_week_nights)) as stays_id,
        MD5(meal) as meal_id,
        MD5(deposit_type) as deposit_id,
        MD5(customer_type) as customer_type_id,
        MD5(market_segment) as market_segment_id,
        MD5(distribution_channel) as distribution_channel_id,
        MD5(agent) as agent_id,
        MD5(company) as company_id,
        previous_cancellations,
        previous_bookings_not_canceled,
        booking_changes,
        days_in_waiting_list,
        adr,
        required_car_parking_spaces,
        total_of_special_requests,
        reservation_status,
        date_load

        FROM base__hotel_booking  
    )

SELECT * FROM renamed_casted