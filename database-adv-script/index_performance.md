# 🧠 Database Index Performance Report

## 📌 Objective
To improve query performance in the Airbnb database by creating indexes on high-usage columns within the `User`, `Booking`, and `Property` tables.

The goal was to:
- Identify frequently queried columns.
- Create appropriate indexes to speed up joins, filters, and sorting operations.
- Measure query performance before and after adding indexes.

---

## ⚙️ Tables Analyzed
| Table | Commonly Queried Columns | Purpose |
|--------|--------------------------|----------|
| **User** | `email`, `user_id` | User lookup and join with bookings |
| **Booking** | `user_id`, `property_id`, `start_date` | Joins, filters, and sorting |
| **Property** | `property_id`, `name` | Property identification and display |

---

## 🧩 Index Creation

```sql
-- Speed up user lookups
CREATE INDEX idx_user_email ON User(email);

-- Speed up join operations
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Improve ORDER BY performance
CREATE INDEX idx_booking_start_date ON Booking(start_date);
