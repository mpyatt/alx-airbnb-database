# Normalization to 3NF – AirBnB Clone Database

## Objective

Apply normalization principles to ensure the database schema adheres to **Third Normal Form (3NF)** by eliminating redundancy, ensuring data integrity, and reducing update anomalies.

## Overview of Normal Forms

| Normal Form | Description                                                                                             |
| ----------- | ------------------------------------------------------------------------------------------------------- |
| **1NF**     | Eliminate repeating groups; ensure atomic (indivisible) data.                                           |
| **2NF**     | Eliminate partial dependencies; ensure non-key attributes depend on the full primary key.               |
| **3NF**     | Eliminate transitive dependencies; ensure non-key attributes do not depend on other non-key attributes. |

## Schema Entities Review

### 1. **User**

```text
id (PK)
first_name
last_name
email (UNIQUE)
password_hash
phone_number
role (ENUM: guest, host, admin)
created_at
updated_at
```

* ✅ **1NF**: All fields are atomic.
* ✅ **2NF**: Single-column primary key; all attributes depend fully on `id`.
* ✅ **3NF**: No transitive dependencies.

### 2. **Property**

```text
id (PK)
host_id (FK → users.id)
name
description
location
price_per_night
created_at
updated_at
```

* ✅ **1NF & 2NF**: Atomic fields, full dependency on `id`.
* ⚠️ **Potential 3NF Violation**: `location` as a freeform string (e.g., "New York, NY") could cause redundancy.

* **✅ Suggested Fix (optional for strict 3NF):**
Create a `locations` table:

```text
id (PK)
city
state
country
```

Update `properties`:

```text
location_id (FK → locations.id)
```

---

### 3. **Booking**

```text
id (PK)
property_id (FK)
user_id (FK)
start_date
end_date
total_price
status (ENUM: pending, confirmed, canceled)
created_at
updated_at
```

* ✅ Fully satisfies 1NF, 2NF, and 3NF.

### 4. **Payment**

```text
id (PK)
booking_id (FK)
amount
payment_date
payment_method (ENUM: credit_card, paypal, stripe)
```

* ✅ Normalized through 3NF.
* 💡 Optionally normalize `payment_method` into a `payment_methods` table if methods expand:

```text
id (PK)
name
```

### 5. **Review**

```text
id (PK)
property_id (FK)
user_id (FK)
rating (1–5)
comment
created_at
updated_at
```

* ✅ All fields meet 3NF requirements.

### 6. **Message**

```text
id (PK)
sender_id (FK → users.id)
recipient_id (FK → users.id)
message_body
sent_at
```

* ✅ Fully normalized—direct relationships between users with no redundant dependencies.

## 🛠️ Summary of Normalization Steps

| Step                               | Description                                                                       |
| ---------------------------------- | --------------------------------------------------------------------------------- |
| ✔️ Ensured atomic attributes       | Split all fields into singular values.                                            |
| ✔️ Eliminated partial dependencies | All attributes depend on the entire primary key.                                  |
| ✔️ Removed transitive dependencies | No attribute depends on another non-key attribute.                                |
| ⚠️ Optional: Normalized locations  | Considered extracting repeated `location` data into a separate `locations` table. |

## Conclusion

The AirBnB Clone database design complies with **Third Normal Form (3NF)**:

* All attributes are atomic and non-repeating.
* Every non-key field depends only on the primary key.
* No transitive dependencies exist between non-key attributes.

🔁 **Further normalization**, like extracting `locations` or `payment_methods`, can be applied based on future scalability, localization, or reporting needs.
