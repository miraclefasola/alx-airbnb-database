

SELECT 
    User.first_name,
    COUNT(Booking.booking_id) AS total_booking
FROM User
left JOIN Booking ON Booking.user_id = User.user_id
GROUP BY User.first_name;

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