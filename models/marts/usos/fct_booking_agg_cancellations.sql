{{ 
    config(
        materialized='view'
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
        b.adr,
        b.previous_cancellations,
        b.previous_bookings_not_canceled,
        b.reservation_status,
        b.date_load,
        CASE WHEN reservation_status = 'Canceled' THEN 1 ELSE 0 END AS is_canceled
    FROM {{ ref('fact_booking') }} b
),

dim_join AS (
    SELECT
        base.*,
        cl.email,
        ms.market_segment,
        dc.distribution_channel,
        ct.customer_type,
        st.total_stays_nights,
        ar.arrival_month,
        ar.arrival_year
    FROM base
    LEFT JOIN {{ ref('dim_client') }} cl ON base.client_id = cl.client_id
    LEFT JOIN {{ ref('dim_market_segment') }} ms ON base.market_segment_id = ms.market_segment_id
    LEFT JOIN {{ ref('dim_distribution_channel') }} dc ON base.distribution_channel_id = dc.distribution_channel_id
    LEFT JOIN {{ ref('dim_customer_type') }} ct ON base.customer_type_id = ct.customer_type_id
    LEFT JOIN {{ ref('dim_stays') }} st ON base.stays_id = st.stays_id
    LEFT JOIN {{ ref('dim_arrival_date') }} ar ON base.arrival_id = ar.arrival_id
)

SELECT
    market_segment,
    distribution_channel,
    customer_type,
    arrival_year,
    arrival_month AS month,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS total_cancellations,
    ROUND(SUM(is_canceled) / COUNT(*), 4) AS cancellation_rate,
    AVG(adr) AS avg_adr,
    SUM(CASE WHEN is_canceled = 1 THEN adr END) AS lost_revenue_estimate
FROM dim_join
GROUP BY 1,2,3,4,5
ORDER BY 4 DESC, 5 DESC
