{{
  config(
    materialized = 'table',
  )
}}

WITH base AS (
    SELECT
        fb.booking_id,
        fb.hotel_id,
        fb.market_segment_id,
        fb.distribution_channel_id,
        fb.adr,
        fb.reservation_status,
        CASE WHEN fb.reservation_status ILIKE 'Canceled' THEN 1 ELSE 0 END AS is_canceled,
        st.stays_in_weekend_nights,
        st.stays_in_week_nights,
        st.stays_in_week_nights + st.stays_in_weekend_nights as total_stays_nights,
        ar.arrival_year,
        ar.arrival_month
    FROM {{ ref('fact_booking') }} fb
    LEFT JOIN {{ ref('dim_arrival_date') }} ar 
        ON fb.arrival_id = ar.arrival_id
    LEFT JOIN {{ ref('dim_stays') }} st 
        ON fb.stays_id = st.stays_id
),

names AS(
    SELECT 
        b.*,
        h.hotel AS hotel_name,
        ms.market_segment AS market_segment_name,
        dc.distribution_channel AS distribution_channel_name
    FROM base b
    LEFT JOIN {{ ref('dim_hotel') }} h 
        ON b.hotel_id = h.hotel_id
    LEFT JOIN {{ ref('dim_market_segment') }} ms 
        ON b.market_segment_id = ms.market_segment_id
    LEFT JOIN {{ ref('dim_distribution_channel') }} dc
        ON b.distribution_channel_id = dc.distribution_channel_id
)


SELECT
    hotel_id,
    hotel_name,
    market_segment_id,
    market_segment_name,
    distribution_channel_id,
    distribution_channel_name,
    arrival_year,
    arrival_month,
    
    COUNT(*) AS total_bookings,
    SUM(IFF(is_canceled = 1, 1, 0)) AS total_cancellations,
    SUM(IFF(is_canceled = 0, 1, 0)) AS confirmed_bookings,

    AVG(adr) AS avg_adr,

    SUM(IFF(is_canceled = 1, adr * total_stays_nights, 0 )) AS lost_revenue_estimate,

    SUM(IFF(is_canceled = 0, total_stays_nights, 0)) AS total_room_nights

FROM names
GROUP BY hotel_id, hotel_name,
    market_segment_id, market_segment_name,
    distribution_channel_id, distribution_channel_name,
    arrival_year, arrival_month
ORDER BY arrival_year DESC, arrival_month DESC
