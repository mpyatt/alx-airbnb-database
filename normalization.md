# Normalization to 3NF – AirBnB Clone Database

## Objective

Apply normalization principles to ensure the database schema is in **Third Normal Form (3NF)** by eliminating redundancy, ensuring data integrity, and reducing update anomalies.

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

✅ 1NF: All fields are atomic.

✅ 2NF: Only one attribute forms the primary key (id), and all other fields depend on it fully.

✅ 3NF: No transitive dependencies between non-key fields.

### 2. **Property**

```text
id (PK)
host_id (FK → User)
name
description
location
price_per_night
created_at
updated_at
```

* ✅ 1NF & 2NF: All atomic; full dependency on id.
* ⚠️ Potential 3NF Violation: If `location` contains a string (e.g., `"New York, NY"`), it might benefit from normalization into a **Location** table to avoid data duplication.

* **✅ Fix (optional for 3NF but good practice):**
Create a `locations` table:

```text
id (PK)
city
state
country
```

And link `properties.location_id → locations.id`.

### 3. **Booking**

```text
id (PK)
property_id (FK)
user_id (FK)
start_date
end_date
total_price
status (ENUM)
created_at
```

* ✅ 1NF & 2NF
* ✅ 3NF: All non-key attributes depend directly on the primary key only.

### 4. **Payment**

```text
id (PK)
booking_id (FK)
amount
payment_date
payment_method (ENUM)
```

* ✅ 1NF & 2NF
* ✅ 3NF: No transitive dependency. Consider normalizing `payment_method` if the list grows beyond a few options.

### 5. **Review**

```text
id (PK)
property_id (FK)
user_id (FK)
rating (1-5)
comment
created_at
updated_at
```

* ✅ 1NF, 2NF, 3NF: All fields are directly tied to id.

### 6. **Message**

```text
id (PK)
sender_id (FK)
recipient_id (FK)
message_body
sent_at
```

* ✅ Fully normalized. Direct relationships between users and messages.

## 🛠️ Summary of Normalization Steps Taken

| Step                               | Description                                                                      |
| ---------------------------------- | -------------------------------------------------------------------------------- |
| ✔️ Ensured atomic attributes       | Split complex fields into singular values.                                       |
| ✔️ Eliminated partial dependencies | All non-key fields depend on full PK (mostly UUIDs).                             |
| ✔️ Removed transitive dependencies | No non-key field depends on another non-key field.                               |
| ⚠️ Optional: locations Table       | Considered normalization of `location` to reduce redundancy if reused frequently. |

## 📌 Conclusion

The AirBnB Clone database schema adheres to **Third Normal Form (3NF)**. All entities have atomic attributes, primary key dependencies, and no transitive non-key dependencies.

Further normalization (e.g., `location`, `payment_method`) may be applied based on scale and expected data reuse.
