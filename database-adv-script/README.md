# Database Advanced Scripts

This directory contains a collection of SQL scripts and reports demonstrating advanced database operations and optimizations for the Airbnb Clone backend.

## Files

* `joins_queries.sql` – Advanced **JOIN** operations (INNER, LEFT, FULL OUTER JOIN).
* `subqueries.sql` – **Subquery** techniques (non-correlated and correlated).
* `aggregations_and_window_functions.sql` – **Aggregation** (`COUNT`, `GROUP BY`) and **window functions** (`RANK()`, `ROW_NUMBER()`).
* `database_index.sql` – **Index** creation and sample **EXPLAIN ANALYZE** performance checks.
* `perfomance.sql` – Initial complex query, **EXPLAIN ANALYZE**, and optimized query using **LATERAL** joins.
* `optimization_report.md` – Analysis of the initial query, identified inefficiencies, and refactoring steps.
* `partitioning.sql` – **Table partitioning** of `bookings` by `start_date` with yearly partitions.
* `partition_performance.md` – Performance comparisons before and after partitioning.
* `performance_monitoring.md` – Continuous **performance monitoring** techniques, index recommendations, and validation.

## Usage

Run the SQL scripts in PostgreSQL to test and observe results:

```bash
psql -d airbnb_clone -f database-adv-script/joins_queries.sql
psql -d airbnb_clone -f database-adv-script/subqueries.sql
psql -d airbnb_clone -f database-adv-script/aggregations_and_window_functions.sql
psql -d airbnb_clone -f database-adv-script/database_index.sql
psql -d airbnb_clone -f database-adv-script/perfomance.sql
psql -d airbnb_clone -f database-adv-script/partitioning.sql
```

For reports (`.md` files), open them in a Markdown viewer to read the analysis and performance results.
