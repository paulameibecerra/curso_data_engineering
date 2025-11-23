{{
  config(
    materialized='view',
  )
}}

WITH base__hotel_booking AS (
    SELECT * 
    FROM {{ ref("base__hotel_booking") }}
    ),

renamed_casted AS ( 
    SELECT
        booking_id,
        MD5(CONCAT(LOWER(name), LOWER(email))) as client_id,
        MD5(hotel) as hotel_id,
        MD5(CONCAT(TO_VARCHAR(arrival_date_year), '-',TO_VARCHAR(arrival_date_month), '-',TO_VARCHAR(arrival_date_day_of_month), '-',TO_VARCHAR(arrival_date_week_number))) AS arrival_id,
        CONCAT(TO_VARCHAR(COALESCE(adults,0)), '-', TO_VARCHAR(COALESCE(children,0)), '-', TO_VARCHAR(COALESCE(babies,0))) AS person_count_id,
        CONCAT(reserved_room_type, '-', assigned_room_type) as room_id,
        MD5(country) as country_id,
        CONCAT(TO_VARCHAR(stays_in_weekend_nights), '-', TO_VARCHAR(stays_in_week_nights)) as stays_id,
        MD5(meal) as meal_id,
        MD5(deposit_type) as deposit_id,
        MD5(customer_type) as customer_type_id,
        MD5(market_segment) as market_segment_id,
        MD5(distribution_channel) as distribution_channel_id,
        COALESCE(agent, 'NO_AGENT') AS agent,
        COALESCE(company, 'NO_COMPANY') AS company,
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