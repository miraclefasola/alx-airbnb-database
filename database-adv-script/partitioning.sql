CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID,
    user_id UUID,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') DEFAULT 'pending' NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
    PARTITION BY RANGE (start_date);

    CREATE TABLE Booking_2023 PARTITION OF Booking
    FOR VALUES FROM ('2023-01-01') TO ('2023-12-31');

    
CREATE TABLE Booking_2024 PARTITION OF Booking
  FOR VALUES FROM ('2024-01-01') TO ('2024-12-31');

CREATE TABLE Booking_2025 PARTITION OF Booking
  FOR VALUES FROM ('2025-01-01') TO ('2025-12-31');