{{
  config(
    materialized = 'view',
  )
}}

WITH src_hotel_booking AS (
    SELECT * 
    FROM {{ source('hotel_project_bronze', 'hotel_booking') }}

    ),

renamed_casted AS (
    SELECT
    MD5(CONCAT(COALESCE(hotel, ''),COALESCE(email, ''), COALESCE(TO_VARCHAR(reservation_status_date), ''),COALESCE(TO_VARCHAR(adr), ''))) as booking_id,
    COALESCE(hotel, ''):: varchar as hotel,
    COALESCE(name, ''):: varchar as name,
    COALESCE(email, ''):: varchar as email,
    COALESCE(phone_number, ''):: varchar as phone_number,
    COALESCE(credit_card, ''):: varchar as credit_card,
    COALESCE(arrival_date_year, 0):: int as arrival_date_year,
    COALESCE(arrival_date_month, ''):: varchar as arrival_date_month,
    COALESCE(arrival_date_week_number, 0):: int as arrival_date_week_number,
    COALESCE(arrival_date_day_of_month, 0):: int as arrival_date_day_of_month,
    COALESCE(stays_in_weekend_nights, 0):: int as stays_in_weekend_nights,
    COALESCE(stays_in_week_nights, 0):: int as stays_in_week_nights,
    COALESCE(adults, 0):: int as adults,
    COALESCE(children, 0):: int as children,
    COALESCE(babies, 0):: int as babies,
    COALESCE(reserved_room_type, ''):: varchar as reserved_room_type,
    COALESCE(assigned_room_type, ''):: varchar as assigned_room_type,
    COALESCE(meal, ''):: varchar as meal,
    COALESCE(country, 'UNKNOWN'):: varchar as country,
    COALESCE(market_segment, ''):: varchar as market_segment,
    COALESCE(distribution_channel, ''):: varchar as distribution_channel,
    COALESCE(deposit_type, 'UNKNOWN'):: varchar as deposit_type,
    COALESCE(agent, 0):: int as agent,
    COALESCE(company, 0):: int as company,
    COALESCE(customer_type, ''):: varchar as customer_type,
    COALESCE(previous_cancellations, FALSE):: boolean as previous_cancellations,
    COALESCE(previous_bookings_not_canceled, 0):: int as previous_bookings_not_canceled,
    COALESCE(is_canceled, FALSE):: boolean as is_canceled,
    COALESCE(is_repeated_guest, FALSE):: boolean as is_repeated_guest,
    COALESCE(booking_changes, 0):: int as booking_changes,
    COALESCE(days_in_waiting_list, 0):: int as days_in_waiting_list,
    COALESCE(adr, 0):: float as adr,
    COALESCE(lead_time, 0):: int as lead_time,
    COALESCE(required_car_parking_spaces, 0):: int as required_car_parking_spaces,
    COALESCE(total_of_special_requests, 0):: int as total_of_special_requests,
    COALESCE(reservation_status, ''):: varchar as reservation_status,
    COALESCE(reservation_status_date, CURRENT_TIMESTAMP()):: timestamp as reservation_status_date,
    _fivetran_synced:: timestamp as date_load

    FROM src_hotel_booking
)

SELECT * FROM renamed_casted