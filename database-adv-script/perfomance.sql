-- Initial Complex Query: Retrieve all bookings with user, property, and payment details
SELECT 
    Booking.booking_id,
    Booking.start_date,
    Booking.end_date,
    Booking.total_price,
    Booking.status,
    Booking.created_at AS booking_time,
    User.user_id,
    User.first_name,
    User.last_name,
    User.email,
    Property.property_id,
    Property.name AS property_name,
    Property.location,
    Payment.payment_id,
    Payment.amount AS payment_amount,
    Payment.payment_method,
    Payment.payment_date
FROM Booking
INNER JOIN User ON Booking.user_id = User.user_id
INNER JOIN Property ON Booking.property_id = Property.property_id
LEFT JOIN Payment ON Booking.booking_id = Payment.booking_id
WHERE b.start_date >= '2024-01-01'
  AND pay.status = 'completed'
ORDER BY Booking.created_at DESC;

-- Step 2: Analyze Query Performance (using EXPLAIN)



EXPLAIN SELECT 
    Booking.booking_id,
    Booking.start_date,
    Booking.end_date,
    Booking.total_price,
    Booking.status,
    Booking.created_at AS booking_time,
    User.user_id,
    User.first_name,
    User.last_name,
    User.email,
    Property.property_id,
    Property.name AS property_name,
    Property.location,
    Payment.payment_id,
    Payment.amount AS payment_amount,
    Payment.payment_method,
    Payment.payment_date
FROM Booking
INNER JOIN User ON Booking.user_id = User.user_id
INNER JOIN Property ON Booking.property_id = Property.property_id
LEFT JOIN Payment ON Booking.booking_id = Payment.booking_id
ORDER BY Booking.created_at DESC;



