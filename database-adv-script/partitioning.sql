-- Partitioning the bookings table by start_date to optimize query performance

-- 1. Create a new partitioned bookings table
CREATE TABLE bookings_partitioned (
LIKE bookings INCLUDING ALL
) PARTITION BY RANGE (start_date);

-- 2. Create partitions for each year (example)
CREATE TABLE bookings_2024 PARTITION OF bookings_partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings_partitioned
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Additional yearly partitions can be added similarly

-- 3. Migrate existing data into the partitioned table
INSERT INTO bookings_partitioned
SELECT * FROM bookings;

-- 4. Swap tables (optional: within a transaction)
-- DROP TABLE bookings;
-- ALTER TABLE bookings_partitioned RENAME TO bookings;

-- 5. Create indexes on partitions (optional but recommended)
CREATE INDEX idx_bkpd_user_id ON bookings_2024(user_id);
CREATE INDEX idx_bkpd_user_id_2025 ON bookings_2025(user_id);

-- 6. Example performance test: query bookings in June 2025
EXPLAIN ANALYZE
SELECT *
FROM bookings_partitioned
WHERE start_date BETWEEN '2025-06-01' AND '2025-06-30';
