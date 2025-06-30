-- Index creation and performance checks for Airbnb Clone Database

-- 1. Create Indexes
-- Users table: speed up lookups by email
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Bookings table: speed up JOINs and date ordering
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_bookings_start_date ON bookings(start_date);

-- Properties table: speed up location-based searches
CREATE INDEX IF NOT EXISTS idx_properties_address ON properties(address);

-- 2. Performance Measurement Examples (using EXPLAIN ANALYZE)

-- 2.1 User Lookup by Email
-- Before Index:
EXPLAIN ANALYZE
SELECT *
FROM users
WHERE email = '[user@example.com](mailto:user@example.com)';

-- After Index:
EXPLAIN ANALYZE
SELECT *
FROM users
WHERE email = '[user@example.com](mailto:user@example.com)';

-- 2.2 Retrieve Bookings for a User
-- Before Index:
EXPLAIN ANALYZE
SELECT b.*, u.email
FROM bookings b
JOIN users u ON b.user_id = u.id
WHERE b.user_id = 'user-uuid'
ORDER BY b.start_date;

-- After Index:
EXPLAIN ANALYZE
SELECT b.*, u.email
FROM bookings b
JOIN users u ON b.user_id = u.id
WHERE b.user_id = 'user-uuid'
ORDER BY b.start_date;

-- 2.3 Search Properties by Address
-- Before Index (sequential scan):
EXPLAIN ANALYZE
SELECT *
FROM properties
WHERE address ILIKE '%Beach%';

-- After Index (index scan using idx_properties_address):
EXPLAIN ANALYZE
SELECT *
FROM properties
WHERE address ILIKE '%Beach%';

-- Note: For pattern searches, consider creating a trigram index:
CREATE INDEX idx_properties_address_trgm ON properties USING GIN (address gin_trgm_ops);
