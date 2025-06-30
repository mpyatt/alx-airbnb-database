# Advanced SQL Joins Queries

This directory contains SQL scripts demonstrating advanced JOIN operations for the Airbnb Clone database.

## Files

* `joins_queries.sql`: Contains three example queries:

  1. **INNER JOIN** to list all bookings with corresponding user details.
  2. **LEFT JOIN** to list all properties and their reviews, including properties with no reviews.
  3. **FULL OUTER JOIN** to list all users and all bookings, including unmatched records (users without bookings and bookings without users).

## Usage

1. Ensure your database has the following tables with appropriate schema:

   * `users (id, email, name, ...)`
   * `properties (id, title, ...)`
   * `bookings (id, user_id, property_id, start_date, end_date, ...)`
   * `reviews (id, property_id, rating, comment, ...)`

2. Run the SQL script using a SQL client (PostgreSQL recommended):

   ```bash
   psql -d airbnb_clone -f database-adv-script/joins_queries.sql
   ```

3. Review the output to verify that the JOIN operations return the expected combined datasets.
