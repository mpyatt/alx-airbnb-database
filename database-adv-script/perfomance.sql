-- Initial complex query retrieving bookings with user, property, and payment details
SELECT
b.id           AS booking_id,
b.start_date,
b.end_date,
u.id           AS user_id,
u.email,
u.name         AS user_name,
p.id           AS property_id,
p.title        AS property_title,
p.address,
pay.id         AS payment_id,
pay.amount,
pay.currency,
pay.status     AS payment_status,
pay.processed_at
FROM
bookings b
JOIN
users u ON b.user_id = u.id
JOIN
properties p ON b.property_id = p.id
LEFT JOIN
payments pay ON b.id = pay.booking_id;

-- Refactored optimized query: selecting only needed columns and using EXISTS for payments to reduce join cost
SELECT
b.id           AS booking_id,
b.start_date,
b.end_date,
u.id           AS user_id,
u.email,
u.name         AS user_name,
p.id           AS property_id,
p.title        AS property_title,
pay.amount     AS payment_amount,
pay.status     AS payment_status
FROM
bookings b
JOIN
users u ON b.user_id = u.id
JOIN
properties p ON b.property_id = p.id
LEFT JOIN LATERAL (
SELECT amount, status
FROM payments
WHERE booking_id = b.id
ORDER BY processed_at DESC
LIMIT 1
) pay ON TRUE;
