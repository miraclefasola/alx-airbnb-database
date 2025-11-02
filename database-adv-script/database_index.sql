


CREATE INDEX idx_user_email ON User (email);

CREATE INDEX idx_property_host ON Property (host_id);

CREATE INDEX idx_booking_property ON Booking (property_id);

CREATE INDEX idx_booking_user ON Booking (user_id);

CREATE INDEX idx_payment_booking ON Payment (booking_id);

EXPLAIN SELECT *
FROM Booking
JOIN User ON Booking.user_id = User.user_id
WHERE User.email = 'someone@email.com';