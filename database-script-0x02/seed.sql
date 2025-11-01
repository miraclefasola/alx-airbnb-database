


-- Enable the pgcrypto extension (for UUID generation)
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Insert Users
INSERT INTO "User" (user_id, full_name, email, created_at)
VALUES
(gen_random_uuid(), 'Alice Johnson', 'alice@example.com', NOW()),
(gen_random_uuid(), 'Bob Smith', 'bob@example.com', NOW()),
(gen_random_uuid(), 'Chika Okafor', 'chika@example.com', NOW());

-- Insert Properties
INSERT INTO Property (property_id, owner_id, title, description, price_per_night, location, created_at)
VALUES
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='alice@example.com'), 
'Cozy Apartment in Lagos', '2-bedroom apartment in Ikoyi', 50000, 'Lagos', NOW()),

(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='bob@example.com'), 
'Beach House', 'Relaxing beachside villa with ocean view', 120000, 'Lekki', NOW()),

(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='chika@example.com'), 
'Studio Flat', 'Compact studio for short stays', 35000, 'Abuja', NOW());

-- Insert Bookings
INSERT INTO Booking (booking_id, user_id, property_id, start_date, end_date, status)
VALUES
(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='bob@example.com'),
(SELECT property_id FROM Property WHERE title='Cozy Apartment in Lagos'),
'2025-11-10', '2025-11-15', 'confirmed'),

(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='chika@example.com'),
(SELECT property_id FROM Property WHERE title='Beach House'),
'2025-12-01', '2025-12-05', 'pending'),

(gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='alice@example.com'),
(SELECT property_id FROM Property WHERE title='Studio Flat'),
'2025-11-20', '2025-11-22', 'confirmed');

-- Insert Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_method, payment_date)
VALUES
(gen_random_uuid(), (SELECT booking_id FROM Booking WHERE status='confirmed' LIMIT 1),
250000, 'Credit Card', NOW()),
(gen_random_uuid(), (SELECT booking_id FROM Booking WHERE status='pending' LIMIT 1),
480000, 'Bank Transfer', NOW());

-- Insert Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
(gen_random_uuid(), (SELECT property_id FROM Property WHERE title='Cozy Apartment in Lagos'),
(SELECT user_id FROM "User" WHERE email='bob@example.com'),
5, 'Amazing experience, super clean!', NOW()),

(gen_random_uuid(), (SELECT property_id FROM Property WHERE title='Beach House'),
(SELECT user_id FROM "User" WHERE email='chika@example.com'),
4, 'Beautiful place near the beach.', NOW()),

(gen_random_uuid(), (SELECT property_id FROM Property WHERE title='Studio Flat'),
(SELECT user_id FROM "User" WHERE email='alice@example.com'),
3, 'Good for a short stay.', NOW());

-- Insert Messages
INSERT INTO Message (message_id, sender_id, receiver_id, content, sent_at)
VALUES
(gen_random_uuid(),
(SELECT user_id FROM "User" WHERE email='alice@example.com'),
(SELECT user_id FROM "User" WHERE email='bob@example.com'),
'Hi Bob, is the apartment still available?',
NOW()),

(gen_random_uuid(),
(SELECT user_id FROM "User" WHERE email='bob@example.com'),
(SELECT user_id FROM "User" WHERE email='alice@example.com'),
'Yes, it is! Would you like to book?',
NOW());
