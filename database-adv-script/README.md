# Advanced SQL Joins, Subqueries, Aggregations & Window Functions

This directory contains SQL scripts demonstrating advanced JOIN, subquery, aggregation, and window function operations for the Airbnb Clone database.

## Files

* `joins_queries.sql`: Contains three example queries demonstrating **INNER JOIN**, **LEFT JOIN**, and **FULL OUTER JOIN** operations:

  1. List all bookings with corresponding user details.
  2. List all properties and their reviews, including properties without reviews.
  3. List all users and all bookings, including unmatched records.
* `subqueries.sql`: Contains two example queries demonstrating **subquery** techniques:

  1. **Non-correlated subquery** to find properties with an average rating greater than 4.0.
  2. **Correlated subquery** to find users who have made more than 3 bookings.
* `aggregations_and_window_functions.sql`: Contains two example queries demonstrating **aggregation** and **window functions**:

  1. Aggregation (`COUNT` & `GROUP BY`) to find total bookings per user.
  2. Window function (`RANK() OVER`) to rank properties by total bookings.

## Usage

1. Ensure your database has the following tables with appropriate schema:

   * `users (id, email, name, ...)`
   * `properties (id, title, ...)`
   * `bookings (id, user_id, property_id, start_date, end_date, ...)`
   * `reviews (id, property_id, rating, comment, ...)`

2. Run the SQL scripts using a SQL client (PostgreSQL recommended):

   ```bash
   psql -d airbnb_clone -f database-adv-script/joins_queries.sql
   psql -d airbnb_clone -f database-adv-script/subqueries.sql
   psql -d airbnb_clone -f database-adv-script/aggregations_and_window_functions.sql
   ```

3. Review the output to verify that the JOIN operations, subqueries, aggregations, and window functions return the expected combined datasets.
