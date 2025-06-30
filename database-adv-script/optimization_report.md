# Query Optimization Report

**Objective:** Refactor a complex query to improve performance when retrieving bookings with related user, property, and payment details.

---

## 1. Initial Query

```sql
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
```

### 1.1 Performance Analysis

Run `EXPLAIN ANALYZE` on the initial query:

```sql
EXPLAIN ANALYZE
<initial query>;
```

**Findings:**

* Full joins on large tables caused nested loop scans.
* Retrieving all payment columns and ordering was expensive.
* No index on `payments(booking_id, processed_at)` forced sequential scan.

---

## 2. Identified Inefficiencies

1. **Unindexed JOIN** on `payments.booking_id` led to slow left join.
2. **Retrieving unnecessary columns** (e.g., address, payment\_id) increased I/O.
3. **Multiple payments per booking** could return duplicate booking rows.
4. **Lack of limit** on payments join returned all historical records.

---

## 3. Optimized Query

```sql
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
```

### 3.1 Improvements

* **LATERAL subquery** limits payment join to the latest record, reducing row count.
* **Selected only needed columns** (omitted address, payment\_id, currency, processed\_at).
* **Index recommendation**: Create index on `payments(booking_id, processed_at)` to speed lateral lookup.

---

## 4. Next Steps

1. Create composite index:

   ```sql
   CREATE INDEX idx_payments_booking_processed
   ON payments(booking_id, processed_at DESC);
   ```

2. Re-run `EXPLAIN ANALYZE` on optimized query to compare timings.
3. Monitor real-world performance under load and refine as needed.
