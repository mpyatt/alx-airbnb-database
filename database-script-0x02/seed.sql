-- ========================
-- LOCATIONS
-- ========================
INSERT INTO locations (id, city, state, country, created_at, updated_at)
VALUES
  ('b5e8f230-0001-4e1a-a001-000000000001', 'Accra', 'Greater Accra', 'Ghana', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('b5e8f230-0002-4e1a-a002-000000000002', 'Kumasi', 'Ashanti', 'Ghana', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('b5e8f230-0003-4e1a-a003-000000000003', 'Cape Coast', 'Central', 'Ghana', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ========================
-- USERS
-- ========================
INSERT INTO users (id, first_name, last_name, email, password_hash, phone_number, role, created_at, updated_at)
VALUES
  ('a1b2c3d4-0001-4e1a-a001-000000000001', 'Kwame', 'Mensah', 'kwame.mensah@airghana.com', 'hashed_pw_1', '+233201112222', 'host', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('a1b2c3d4-0002-4e1a-a002-000000000002', 'Akosua', 'Owusu', 'akosua.owusu@airghana.com', 'hashed_pw_2', '+233202223333', 'guest', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('a1b2c3d4-0003-4e1a-a003-000000000003', 'Yaw', 'Boateng', 'yaw.boateng@airghana.com', 'hashed_pw_3', '+233203334444', 'host', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ========================
-- PROPERTIES
-- ========================
INSERT INTO properties (id, host_id, name, description, location_id, price_per_night, created_at, updated_at)
VALUES
  ('c9d8e7f6-0001-4e1a-a001-000000000001', 'a1b2c3d4-0001-4e1a-a001-000000000001', 'Modern Flat in Osu', 'A well-furnished apartment near Oxford Street, Accra.', 'b5e8f230-0001-4e1a-a001-000000000001', 350.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('c9d8e7f6-0002-4e1a-a002-000000000002', 'a1b2c3d4-0003-4e1a-a003-000000000003', 'Quiet Bungalow in Kumasi', 'Serene 2-bedroom house in Ahodwo area.', 'b5e8f230-0002-4e1a-a002-000000000002', 280.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ========================
-- BOOKINGS
-- ========================
INSERT INTO bookings (id, property_id, user_id, start_date, end_date, total_price, status, created_at, updated_at)
VALUES
  ('d7e6f5g4-0001-4e1a-a001-000000000001', 'c9d8e7f6-0001-4e1a-a001-000000000001', 'a1b2c3d4-0002-4e1a-a002-000000000002', '2025-07-15', '2025-07-18', 1050.00, 'confirmed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ========================
-- PAYMENTS
-- ========================
INSERT INTO payments (id, booking_id, amount, payment_date, payment_method, created_at, updated_at)
VALUES
  ('e6f5g4h3-0001-4e1a-a001-000000000001', 'd7e6f5g4-0001-4e1a-a001-000000000001', 1050.00, CURRENT_TIMESTAMP, 'mobile_money', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ========================
-- REVIEWS
-- ========================
INSERT INTO reviews (id, property_id, user_id, rating, comment, created_at, updated_at)
VALUES
  ('f5g4h3i2-0001-4e1a-a001-000000000001', 'c9d8e7f6-0001-4e1a-a001-000000000001', 'a1b2c3d4-0002-4e1a-a002-000000000002', 5, 'Excellent location and very clean. Felt safe and at home.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ========================
-- MESSAGES
-- ========================
INSERT INTO messages (id, sender_id, recipient_id, message_body, sent_at, created_at, updated_at)
VALUES
  ('g4h3i2j1-0001-4e1a-a001-000000000001', 'a1b2c3d4-0002-4e1a-a002-000000000002', 'a1b2c3d4-0001-4e1a-a001-000000000001', 'Hi Kwame, can I check in by noon on the 15th?', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
