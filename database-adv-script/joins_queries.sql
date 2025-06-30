-- Advanced SQL JOIN Queries for Airbnb Clone Database

-- 1. INNER JOIN: Retrieve all bookings with the respective user details
SELECT
b.id       AS booking_id,
b.property_id,
b.start_date,
b.end_date,
u.id       AS user_id,
u.email,
u.name
FROM
bookings b
INNER JOIN
users u ON b.user_id = u.id;

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties without reviews
SELECT
p.id         AS property_id,
p.title,
r.id         AS review_id,
r.rating,
r.comment
FROM
properties p
LEFT JOIN
reviews r ON p.id = r.property_id
ORDER BY p.id;

-- 3. FULL OUTER JOIN: Retrieve all users and all bookings, including unmatched records
SELECT
u.id          AS user_id,
u.email,
b.id          AS booking_id,
b.property_id,
b.start_date,
b.end_date
FROM
users u
FULL OUTER JOIN
bookings b ON u.id = b.user_id;
