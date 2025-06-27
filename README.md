# alx-airbnb-database

This repository contains SQL scripts for the **AirBnB Clone** project, including a normalized relational database schema, seed data for testing, and an entity-relationship diagram (ERD) for visual reference.

## Repository Structure

| Directory              | Description                                |
| ---------------------- | ------------------------------------------ |
| `database-script-0x01` | Defines the database schema using SQL      |
| `database-script-0x02` | Populates the database with sample records |
| `ERD`                  | Contains the Entity-Relationship Diagram   |

## Technologies

* **PostgreSQL**
* SQL (DDL and DML)
* UUID-based primary keys
* Third Normal Form (3NF) normalization
* Indexing for performance
* Constraints for data integrity

## Schema Overview

Defined in `database-script-0x01/schema.sql`

### Core Entities

* `users`: Hosts and guests with roles and account details
* `locations`: Normalized city, state, and country information
* `properties`: Listings associated with users and locations
* `bookings`: Reservation records linking users to properties
* `payments`: Payment history tied to bookings
* `reviews`: User feedback with rating and comment
* `messages`: Direct messages between users

### Features

* Atomic and normalized structure (3NF)
* Foreign key constraints with `ON DELETE CASCADE`
* ENUM-like behavior using `CHECK` constraints
* `created_at` and `updated_at` fields on all tables

## Sample Data

Defined in `database-script-0x02/seed.sql`

Includes:

* Multiple users (hosts and guests)
* Properties in diverse cities
* Valid booking and payment scenarios
* Reviews and guest-host messaging examples

## Entity-Relationship Diagram (ERD)

The `ERD` directory contains a visual diagram of the database schema.

> You can view the ERD online at [dbdiagram.io](https://dbdiagram.io/d/AirBnB-Clone-DB-685e73bff413ba35082e134f) or open the provided PNG in the `ERD/` folder for reference.

## How to Use

1. **Create the schema:**

   ```bash
   cd database-script-0x01
   psql < schema.sql
   ```

2. **Insert sample data:**

   ```bash
   cd ../database-script-0x02
   psql < seed.sql
   ```

> Ensure you're connected to the correct PostgreSQL database instance.

## Notes

* All UUIDs are hardcoded for reproducibility in testing
* Timestamps use `CURRENT_TIMESTAMP`
* You can extend the schema with features like availability calendars, wishlists, admin dashboards, etc.

---

> This project is part of the **ALX ProDev Backend Software Engineering Program**
