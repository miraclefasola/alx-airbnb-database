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

--LEFT JOIN

SELECT 
    Review.review_id,
    Property.name AS property_name,
    User.first_name AS reviewer_name,
    Review.rating,
    Review.comment,
    Review.created_at AS time_of_review
FROM Review
LEFT JOIN Property ON Review.property_id = Property.property_id
LEFT JOIN User ON Review.user_id = User.user_id;

--PostgreSQL Version
SELECT 
    Booking.booking_id,
    User.first_name AS guest_name,
    Booking.start_date,
    Booking.end_date,
    Booking.total_price,
    Booking.status,
    Booking.created_at AS booking_time
FROM Booking
FULL OUTER JOIN User ON Booking.user_id = User.user_id;


--MySQL

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
