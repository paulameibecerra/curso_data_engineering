
WITH base_bookings AS (
    SELECT
        booking_id,
        person_count_id
    FROM
        {{ ref('stg_hotel__booking_norm') }}
),

person_counts AS (
    SELECT
        person_count_id,
        adults,
        children,
        babies
    FROM
        {{ ref('stg_hotel__n_persons') }} 
)

SELECT
    b.person_count_id,
    p.adults,
    p.children,
    p.babies
FROM
    base_bookings AS b
INNER JOIN
    person_counts AS p
    ON b.person_count_id = p.person_count_id
WHERE
    (p.adults + p.children + p.babies) = 0