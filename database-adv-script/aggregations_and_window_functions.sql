-- Advanced SQL Aggregations & Window Functions for Airbnb Clone Database

-- 1. Aggregation: Total number of bookings made by each user
SELECT
  u.id            AS user_id,
  u.email,
  u.name,
  COUNT(b.id)     AS total_bookings
FROM
  users u
LEFT JOIN
  bookings b ON u.id = b.user_id
GROUP BY
  u.id,
  u.email,
  u.name
ORDER BY
  total_bookings DESC;

-- 2. Window Function: Rank properties based on total number of bookings received
SELECT
  property_id,
  total_bookings,
  RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank
FROM (
  SELECT
    b.property_id,
    COUNT(b.id) AS total_bookings
  FROM
    bookings b
  GROUP BY
    b.property_id
) AS sub
ORDER BY
  booking_rank;
