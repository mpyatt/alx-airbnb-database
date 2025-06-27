# AirBnB Clone — Database Schema

## Objective

Define the normalized database schema for the AirBnB Clone project and implement SQL table creation scripts that enforce:

- Third Normal Form (3NF)
- Referential integrity
- Consistent naming conventions
- Indexes for performance optimization

## Entities

### 1. `users`

Stores platform users with roles (`guest`, `host`, `admin`).

### 2. `locations`

Normalized location details (city, state, country) for reusability.

### 3. `properties`

Listings hosted by users, linked to a normalized `location`.

### 4. `bookings`

Reservations made by users on properties.

### 5. `payments`

Payments linked to a booking, with support for multiple payment methods.

### 6. `reviews`

Guest reviews for properties, including rating and comment.

### 7. `messages`

Direct messages between users (e.g. guests and hosts).

## Design Notes

- All IDs are UUIDs for global uniqueness.
- All tables include `created_at` and `updated_at` timestamps.
- Foreign key constraints include `ON DELETE CASCADE` where cascading deletion is expected.
- CHECK constraints enforce ENUM-like behavior for `role`, `status`, `payment_method`, and `rating`.

## Usage

To create the schema:

```bash
psql < schema.sql
```
