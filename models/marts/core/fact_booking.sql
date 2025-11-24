{{
  config(
    materialized='view',
    unique_key = 'booking_id'
  )
}}

    SELECT
        booking_id,
        client_id,
        hotel_id,
        arrival_id,
        person_count_id,
        room_id,
        country_id,
        stays_id,
        meal_id,
        deposit_id,
        customer_type_id,
        market_segment_id,
        distribution_channel_id,
        agent_id,
        company_id,

        previous_cancellations,
        previous_bookings_not_canceled,
        booking_changes,
        days_in_waiting_list,
        adr,
        required_car_parking_spaces,
        total_of_special_requests,
        reservation_status,
        date_load

        FROM {{ ref("stg_hotel__booking_norm") }}

        --{% if is_incremental() %}
        --WHERE date_load > (SELECT MAX(date_load) FROM {{ this }})
        --{% endif %}