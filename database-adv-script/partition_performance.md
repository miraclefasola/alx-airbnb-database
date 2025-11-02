### Query performance test

Testing how long queries take before and after partitioning.

For example:

EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-06-30';


Before partitioning → PostgreSQL scans the entire table.
After partitioning → PostgreSQL only scans Booking_2024.