# Database Normalization - Airbnb Clone Database

## Objective
Ensure the Airbnb Clone database design adheres to Third Normal Form (3NF) to eliminate redundancies and maintain data integrity.

---

## Understanding Normalization and 3NF Principles

- **1NF (First Normal Form)**: All attributes contain atomic, indivisible values. Tables have primary keys.
- **2NF (Second Normal Form)**: The table is in 1NF and all non-key attributes fully depend on the entire primary key (no partial dependencies on composite keys).
- **3NF (Third Normal Form)**: The table is in 2NF and all attributes are only dependent on the primary key (no transitive dependencies). No non-key attribute depends on another non-key attribute.

---

## Review and Normalization Steps

### User Table
- Attributes are atomic and no composite key exists; no partial dependency.
- No transitive dependency (e.g., role is atomic).
- **Conclusion**: Already in 3NF.

### Property Table
- Attributes are atomic.
- `host_id` is a foreign key linking to User, no stored redundant host info.
- Location, name, description, price per night depend directly on `property_id`.
- **Conclusion**: Already in 3NF.

### Booking Table
- Attributes atomic.
- `property_id` and `user_id` are foreign keys; no redundant info stored.
- No non-key attributes depend on others except `booking_id`.
- `status`, `start_date`, `end_date`, `total_price` fully depend on booking.
- **Conclusion**: Already in 3NF.

### Payment Table
- Payment attributes depend solely on `payment_id`.
- Linked to Booking via `booking_id` without redundancy.
- **Conclusion**: Already in 3NF.

### Review Table
- Attributes atomic.
- Foreign keys properly link to Property and User.
- No transitive dependencies among rating, comment.
- **Conclusion**: Already in 3NF.

### Message Table
- Attributes atomic.
- Foreign keys for sender and recipient enforce relationships.
- No transitive dependencies.
- **Conclusion**: Already in 3NF.

---

## Summary of Normalization

The schema as defined:

- Contains **atomic columns** without repeating groups or multi-valued attributes (1NF).
- Has **no partial dependencies**; all non-key attributes depend fully on primary keys (2NF).
- Prevents **transitive dependencies** by ensuring no non-key attribute depends on another non-key attribute (3NF).

Thus, **the Airbnb Clone schema conforms to 3NF** with:

- Clear separation of users, properties, bookings, payments, reviews, and messages.
- Foreign keys and constraints to maintain referential integrity.
- No redundant data or update anomalies expected in this design.

---

## Recommendations

- Continue using strictly foreign keys for relationships.
- Avoid storing derived or calculated data that could introduce redundancy.
- Regularly review schema changes to ensure 3NF is maintained.
- Consider indexing frequently queried foreign keys (already specified).

---

This normalization ensures minimal redundant storage, consistent data updates, and scalable database structure for your Airbnb Clone backend.
