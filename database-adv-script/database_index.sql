-- Index creation for Airbnb Clone Database to improve query performance

-- Users table: speed up lookups by email
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Bookings table: speed up JOINs and date ordering
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_bookings_start_date ON bookings(start_date);

-- Properties table: speed up location-based searches
CREATE INDEX IF NOT EXISTS idx_properties_address ON properties(address);
