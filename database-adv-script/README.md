# 🧩 SQL Joins – Airbnb Database Project

This section of the project demonstrates the use of SQL joins to retrieve related data across multiple tables in the simulated Airbnb database.  
The goal is to master **INNER JOIN**, **LEFT JOIN**, and **FULL OUTER JOIN** operations by writing real-world queries.

---

## ✅ Task Objectives

- Retrieve bookings with corresponding users using **INNER JOIN**  
- Retrieve properties and their reviews using **LEFT JOIN** (including properties with no reviews)  
- Retrieve all users and all bookings using **FULL OUTER JOIN** (or **UNION** workaround for MySQL)

---

## 🔍 Queries Overview

### 1. INNER JOIN – Bookings and Users
Retrieve all bookings along with the property and guest details.

```sql
SELECT 
    Booking.booking_id,
    Property.name AS property_name,
    User.first_name AS guest_name,
    Booking.start_date,
    Booking.end_date,
    Booking.total_price,
    Booking.status,
    Booking.created_at AS booking_time
FROM Booking
INNER JOIN Property ON Booking.property_id = Property.property_id
INNER JOIN User ON Booking.user_id = User.user_id
ORDER BY guest_name;
```
### 2. LEFT JOIN – Properties and Reviews
```
Retrieve all properties and their reviews.
Even if a property has no review, it will still appear in the results.

SELECT 
    Property.property_id,
    Property.name AS property_name,
    Review.review_id,
    Review.rating,
    Review.comment,
    Review.created_at AS time_of_review
FROM Property
LEFT JOIN Review 
    ON Property.property_id = Review.property_id
ORDER BY property_name;
```
### 3. FULL OUTER JOIN – All Users and All Bookings
```
Show all users and all bookings, including users without bookings and bookings without users.
Since MySQL doesn’t support FULL OUTER JOIN, use a UNION workaround:

SELECT 
    Booking.booking_id,
    User.first_name AS guest_name,
    Booking.start_date,
    Booking.end_date,
    Booking.total_price,
    Booking.status,
    Booking.created_at AS booking_time
FROM Booking
LEFT JOIN User ON Booking.user_id = User.user_id

UNION

SELECT 
    Booking.booking_id,
    User.first_name AS guest_name,
    Booking.start_date,
    Booking.end_date,
    Booking.total_price,
    Booking.status,
    Booking.created_at AS booking_time
FROM Booking
RIGHT JOIN User ON Booking.user_id = User.user_id;
```
#### 4. Total number of bookings made by each user, using the COUNT function and GROUP BY clause.
```
SELECT 
    User.first_name,
    COUNT(Booking.booking_id) AS total_booking
FROM User
left JOIN Booking ON Booking.user_id = User.user_id
GROUP BY User.first_name;

```
##### 5 window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
```

SELECT 
    Property.property_id,
    User.first_name AS host_name,
    Property.name,
    Property.description,
    Property.location,
    RANK() OVER (ORDER BY Property.name ASC) AS rank
FROM Property
LEFT JOIN User 
    ON Property.host_id = User.user_id;

SELECT 
    Property.name
    Property.pricepernight
    ROW_NUMBER() OVER (ORDER BY Property.pricepernight) AS ROW_NUMBER
FROM Property;