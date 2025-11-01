# 🏠 AIRBNB Database Schema

This project defines a **relational database schema** for an Airbnb-style platform.  
It models how users, properties, bookings, payments, reviews, and messages interact within the system.

---

## 📘 Overview

The schema is designed following **database normalization (1NF–3NF)** and ensures **data integrity** through foreign keys.  
It also includes **indexes** to improve query performance on frequently searched columns.

---

## 🧩 Database Structure

### 🧑‍💼 User Table

Stores information about all platform users — guests, hosts, and admins.

| Column | Type | Description |
|---------|------|-------------|
| `user_id` | UUID (PK) | Unique user identifier |
| `first_name` | VARCHAR(100) | User’s first name |
| `last_name` | VARCHAR(100) | User’s last name |
| `email` | VARCHAR(100), UNIQUE, Indexed | User’s email address |
| `password_hash` | VARCHAR(300) | Hashed password |
| `phone_number` | VARCHAR(50) | Optional phone number |
| `role` | ENUM('guest', 'host', 'admin') | User role |
| `created_at` | TIMESTAMP | Record creation timestamp |

---

### 🏡 Property Table

Holds all property listings created by hosts.

| Column | Type | Description |
|---------|------|-------------|
| `property_id` | UUID (PK) | Unique property ID |
| `host_id` | UUID (FK → User.user_id) | Owner (host) of the property |
| `name` | VARCHAR(259) | Property title |
| `description` | TEXT | Detailed description |
| `location` | VARCHAR(300) | Property location |
| `pricepernight` | DECIMAL(10, 2) | Price per night |
| `created_at` | TIMESTAMP | When property was added |
| `updated_at` | TIMESTAMP | Auto-updated when modified |

**Index:** `host_id` for fast lookup of host properties.

---

### 📅 Booking Table

Stores details of reservations made by users for properties.

| Column | Type | Description |
|---------|------|-------------|
| `booking_id` | UUID (PK) | Booking reference |
| `property_id` | UUID (FK → Property.property_id) | Booked property |
| `user_id` | UUID (FK → User.user_id) | Guest making the booking |
| `start_date` | DATE | Booking start date |
| `end_date` | DATE | Booking end date |
| `total_price` | DECIMAL(10, 2) | Total booking price |
| `status` | ENUM('pending', 'confirmed', 'canceled') | Booking status |
| `created_at` | TIMESTAMP | Record creation timestamp |

**Indexes:**  
- `property_id` for property-based lookups  
- `user_id` for user booking history  

---

### 💳 Payment Table

Tracks all payments made for bookings.

| Column | Type | Description |
|---------|------|-------------|
| `payment_id` | UUID (PK) | Payment record ID |
| `booking_id` | UUID (FK → Booking.booking_id) | Associated booking |
| `amount` | DECIMAL(10, 2) | Payment amount |
| `payment_method` | ENUM('credit_card', 'paypal', 'stripe') | Payment method used |
| `payment_date` | TIMESTAMP | When payment was made |

**Index:** `booking_id` for efficient joins.

---

### 🌟 Review Table

Captures feedback from users about properties they’ve stayed in.

| Column | Type | Description |
|---------|------|-------------|
| `review_id` | UUID (PK) | Review record ID |
| `property_id` | UUID (FK → Property.property_id) | Reviewed property |
| `user_id` | UUID (FK → User.user_id) | Reviewer |
| `rating` | INTEGER (1–5) | Star rating |
| `comment` | TEXT | User review |
| `created_at` | TIMESTAMP | Submission timestamp |

---

### 💬 Message Table

Supports messaging between users (e.g., hosts and guests).

| Column | Type | Description |
|---------|------|-------------|
| `message_id` | UUID (PK) | Message record ID |
| `sender_id` | UUID (FK → User.user_id) | Message sender |
| `recipient_id` | UUID (FK → User.user_id) | Message receiver |
| `message_body` | TEXT | Message content |
| `sent_at` | TIMESTAMP | Timestamp when message was sent |

**Indexes:**  
- `sender_id` for messages sent by user  
- `recipient_id` for received messages  

---

## ⚙️ Index Summary

| Index Name | Table | Column(s) | Purpose |
|-------------|--------|-----------|----------|
| `idx_user_email` | User | email | Speed up email lookups |
| `idx_property_host` | Property | host_id | Quickly find host properties |
| `idx_booking_property` | Booking | property_id | Fast property-to-booking joins |
| `idx_booking_user` | Booking | user_id | Retrieve user’s booking history |
| `idx_payment_booking` | Payment | booking_id | Speed up payment record joins |

---

## 🧠 Design Principles

- **Normalization:** Schema follows up to **3NF** to reduce redundancy.  
- **Referential Integrity:** Enforced via foreign keys.  
- **UUIDs:** Used for IDs to ensure global uniqueness.  
- **Indexes:** Added on frequently searched columns for performance.  
- **Timestamps:** Track record creation and updates automatically.

---

## 🚀 Usage

1. Run the SQL file in your MySQL environment:
   ```sql
   SOURCE airbnb_schema.sql;
