{{
  config(
    materialized = 'incremental',
  )
}}

WITH src_hotel_booking AS (
    SELECT * 
    FROM {{ source('hotel_project_bronze', 'hotel_booking') }}

    {% if is_incremental() %}
    where _fivetran_synced > (select max(date_load) from {{ this }})
    {% endif %}

    ),

renamed_casted AS (
    SELECT
    MD5(CONCAT(hotel, email, COALESCE(TO_VARCHAR(reservation_status_date), ''),COALESCE(TO_VARCHAR(adr), ''))) as booking_id,
    hotel:: varchar as hotel,
    name:: varchar as name,
    email:: varchar as email,
    phone_number:: varchar as phone_number,
    credit_card:: varchar as credit_card,
    arrival_date_year:: int as arrival_date_year,
    arrival_date_month:: varchar as arrival_date_month,
    arrival_date_week_number:: int as arrival_date_week_number,
    arrival_date_day_of_month:: int as arrival_date_day_of_month,
    stays_in_weekend_nights:: int as stays_in_weekend_nights,
    stays_in_week_nights:: int as stays_in_week_nights,
    adults:: int as adults,
    children:: int as children,
    babies:: int as babies,
    reserved_room_type:: varchar as reserved_room_type,
    assigned_room_type:: varchar as assigned_room_type,
    meal:: varchar as meal,
    country:: varchar as country,
    market_segment:: varchar as market_segment,
    distribution_channel:: varchar as distribution_channel,
    deposit_type:: varchar as deposit_type,
    agent:: varchar as agent,
    company:: varchar as company,
    customer_type:: varchar as customer_type,
    previous_cancellations:: boolean as previous_cancellations,
    previous_bookings_not_canceled:: int as previous_bookings_not_canceled,
    booking_changes:: int as booking_changes,
    days_in_waiting_list:: int as days_in_waiting_list,
    adr:: float as adr,
    required_car_parking_spaces:: int as required_car_parking_spaces,
    total_of_special_requests:: int as total_of_special_requests,
    reservation_status:: varchar as reservation_status,
    reservation_status_date:: timestamp as reservation_status_date,
    _fivetran_synced:: timestamp as date_load

    FROM src_hotel_booking
)

SELECT * FROM renamed_casted

