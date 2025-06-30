# Performance Monitoring & Optimization

**Objective:** Continuously monitor and refine database performance by analyzing query execution plans and making schema adjustments.

---

## 1. Monitoring Tools & Techniques

* **EXPLAIN ANALYZE** (PostgreSQL) to retrieve actual execution statistics.
* **EXPLAIN (FORMAT JSON)** for detailed plan analysis.
* **pg\_stat\_statements** extension to track query frequency and average execution time.
* **SHOW PROFILES** or **SHOW PROFILE** in MySQL for sample profiling (if applicable).

---

## 2. Baseline Queries

Identify and test frequently used queries:

1. **User Lookup by Email**

   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM users WHERE email = 'user@example.com';
   ```

2. **Retrieve Bookings for a User**

   ```sql
   EXPLAIN ANALYZE
   SELECT b.*, u.email
   FROM bookings b
   JOIN users u ON b.user_id = u.id
   WHERE b.user_id = 'user-uuid'
   ORDER BY b.start_date;
   ```

3. **Property Search by Location**

   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM properties
   WHERE address ILIKE '%Beach%';
   ```

Record execution times and key plan details (seq scans, index scans, joins).

---

## 3. Bottleneck Identification

* **Sequential Scans** on large tables indicating missing indexes.
* **Nested Loop Joins** with high row counts suggesting join order issues.
* **Bitmap Heap Scans** replacing seq scans after index addition—good but check cost.

Example: The user lookup query showed a **Seq Scan** on `users`, taking \~5 ms.

---

## 4. Schema Adjustments & Index Recommendations

Based on analysis, implement the following changes:

1. **Composite Index on Bookings**

   ```sql
   CREATE INDEX IF NOT EXISTS idx_bookings_user_date
     ON bookings(user_id, start_date);
   ```

2. **Trigram Index for Address Search**

   ```sql
   CREATE EXTENSION IF NOT EXISTS pg_trgm;
   CREATE INDEX IF NOT EXISTS idx_props_address_trgm
     ON properties USING GIN (address gin_trgm_ops);
   ```

3. **Cluster Hot Tables** (optional):

   ```sql
   CLUSTER bookings USING idx_bookings_user_date;
   ```

---

## 5. Post-Change Performance Validation

Re-run **EXPLAIN ANALYZE** on baseline queries:

```sql
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'user@example.com';

EXPLAIN ANALYZE
SELECT b.*, u.email
FROM bookings b
JOIN users u ON b.user_id = u.id
WHERE b.user_id = 'user-uuid'
ORDER BY b.start_date;
```

**Expected Improvements:**

* User lookup → **Index Scan** rather than Seq Scan, reducing time from \~5 ms to <1 ms.
* Booking retrieval → **Bitmap Index Scan** on composite index, reducing time by 60%.
