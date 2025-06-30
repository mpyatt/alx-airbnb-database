# Index Performance Analysis

This document identifies high-usage columns in key tables, provides SQL commands to create indexes, and outlines steps to measure query performance before and after indexing using `EXPLAIN ANALYZE`.

---

## 1. High-Usage Columns

Based on common query patterns, the following columns are frequently used in `WHERE`, `JOIN`, and `ORDER BY` clauses:

* **users**

  * `email` (login lookup, JOIN with bookings)
* **bookings**

  * `user_id` (JOIN with users)
  * `property_id` (JOIN with properties)
  * `start_date` (ORDER BY booking date)
* **properties**

  * `address` or `location` (search filter)

---

## 2. Index Creation Commands

Execute the following SQL statements to create indexes on the high-usage columns:

```sql
-- Users table: speed up lookups by email
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Bookings table: speed up JOINs and date ordering
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_bookings_start_date ON bookings(start_date);

-- Properties table: speed up location-based searches
CREATE INDEX IF NOT EXISTS idx_properties_address ON properties(address);
```

> **Note:** Use `IF NOT EXISTS` to avoid errors if the index already exists.

---

## 3. Performance Measurement

Use `EXPLAIN ANALYZE` to compare query plans and execution times before and after adding indexes. Replace placeholder values and table names as needed.

### 3.1 User Lookup by Email

```sql
-- Before indexing
EXPLAIN ANALYZE
SELECT *
FROM users
WHERE email = 'user@example.com';

-- After indexing
EXPLAIN ANALYZE
SELECT *
FROM users
WHERE email = 'user@example.com';
```

**Expected Observation:**

* **Before:** Sequential scan on `users` (high cost, longer time).
* **After:** Index scan using `idx_users_email` (lower cost, faster retrieval).

### 3.2 Retrieve Bookings for a User

```sql
-- Before indexing
EXPLAIN ANALYZE
SELECT b.*, u.email
FROM bookings b
JOIN users u ON b.user_id = u.id
WHERE b.user_id = 'user-uuid'
ORDER BY b.start_date;

-- After indexing
EXPLAIN ANALYZE
SELECT b.*, u.email
FROM bookings b
JOIN users u ON b.user_id = u.id
WHERE b.user_id = 'user-uuid'
ORDER BY b.start_date;
```

**Expected Observation:**

* **Before:** Seq scan on `bookings` and `users` (full table scans).
* **After:** Index scans on `bookings(user_id)` and `bookings(start_date)` to filter and sort quickly.

### 3.3 Search Properties by Address

```sql
-- Before indexing
EXPLAIN ANALYZE
SELECT *
FROM properties
WHERE address ILIKE '%Beach%';

-- After indexing
EXPLAIN ANALYZE
SELECT *
FROM properties
WHERE address ILIKE '%Beach%';
```

**Expected Observation:**

* **Before:** Seq scan on `properties`.
* **After:** Depending on pattern, a text pattern index (e.g., `pg_trgm`) could be used; consider extending with `CREATE INDEX ON properties USING GIN (address gin_trgm_ops);` for full-text patterns.

---

**Next Steps:**

1. Run the above `EXPLAIN ANALYZE` commands and record the execution times and plan changes.
2. Consider adding composite indexes if queries often filter on multiple columns (e.g., `ON bookings(user_id, start_date)`).
3. Monitor index usage over time and remove unused indexes to optimize write performance.
