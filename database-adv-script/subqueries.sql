-- Advanced SQL Subqueries for Airbnb Clone Database

-- 1. Non-Correlated Subquery: Find all properties with average rating greater than 4.0
SELECT
  p.id         AS property_id,
  p.title,
  (SELECT AVG(r.rating)
   FROM reviews r
   WHERE r.property_id = p.id) AS avg_rating
FROM
  properties p
WHERE
  (SELECT AVG(r2.rating)
   FROM reviews r2
   WHERE r2.property_id = p.id) > 4.0
ORDER BY
  avg_rating DESC;

-- 2. Correlated Subquery: Find all users who have made more than 3 bookings
SELECT
  u.id       AS user_id,
  u.email,
  u.name,
  (SELECT COUNT(*)
   FROM bookings b
   WHERE b.user_id = u.id) AS booking_count
FROM
  users u
WHERE
  (SELECT COUNT(*)
   FROM bookings b2
   WHERE b2.user_id = u.id) > 3
ORDER BY
  booking_count DESC;
