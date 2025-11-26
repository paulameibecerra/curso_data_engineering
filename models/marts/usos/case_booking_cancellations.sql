{{
    config(
        materialized='table'
    )
}}

WITH base AS (
    SELECT
        b.booking_id,
        b.client_id,
        b.hotel_id,
        b.arrival_id,
        b.market_segment_id,
        b.distribution_channel_id,
        b.customer_type_id,
        b.stays_id,
        b.country_id,
        b.lead_time,
        b.adr,
        b.previous_cancellations,
        b.previous_bookings_not_canceled,
        b.deposit_id,
        b.reservation_status,
        b.date_load,
        b.is_canceled
    FROM {{ ref('fact_booking') }} b
),

dim_join AS (
    SELECT
        base.*,
        ms.market_segment,
        dc.distribution_channel,
        ct.customer_type,
        ar.arrival_month,
        ar.arrival_year,
        co.country,
        dp.deposit_type,
        (st.stays_in_weekend_nights + st.stays_in_week_nights) AS total_stays_nights
    FROM base
    LEFT JOIN {{ ref('dim_market_segment') }} ms 
        ON base.market_segment_id = ms.market_segment_id
    LEFT JOIN {{ ref('dim_distribution_channel') }} dc 
        ON base.distribution_channel_id = dc.distribution_channel_id
    LEFT JOIN {{ ref('dim_customer_type') }} ct 
        ON base.customer_type_id = ct.customer_type_id
    LEFT JOIN {{ ref('dim_arrival_date') }} ar 
        ON base.arrival_id = ar.arrival_id
    LEFT JOIN {{ ref('dim_stays') }} st 
        ON base.stays_id = st.stays_id
    LEFT JOIN {{ ref('dim_country') }} co
        ON base.country_id = co.country_id
    LEFT JOIN {{ ref('dim_deposit') }} dp
        ON base.deposit_id = dp.deposit_id
)

SELECT
    market_segment,
    distribution_channel,
    customer_type,
    country,
    deposit_type,
    arrival_year,
    arrival_month AS month,

    COUNT(*) AS total_bookings,
    SUM(IFF(is_canceled, 1, 0)) AS total_cancellations,
    ROUND(SUM(IFF(is_canceled, 1, 0)) / COUNT(*), 4) AS cancellation_rate,

    AVG(adr) AS avg_adr,
    SUM(IFF(is_canceled, adr, 0)) AS lost_revenue_estimate,

    AVG(lead_time) AS avg_lead_time,
    AVG(total_stays_nights) AS avg_nights,
    
    AVG(IFF(previous_cancellations, 1, 0)) AS avg_previous_cancellations,
    AVG(previous_bookings_not_canceled) AS avg_previous_non_cancel
FROM dim_join
GROUP BY 1,2,3,4,5,6,7
