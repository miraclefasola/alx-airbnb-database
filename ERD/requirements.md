# Database Requirements - Airbnb Clone

## Entity-Relationship (ER) Diagram Specification

### Database Entities and Attributes

#### User Entity
**Primary Key:** user_id (UUID, Indexed)

**Required Attributes:**
- `user_id`: Primary Key, UUID, Indexed
- `first_name`: VARCHAR, NOT NULL
- `last_name`: VARCHAR, NOT NULL
- `email`: VARCHAR, UNIQUE, NOT NULL
- `password_hash`: VARCHAR, NOT NULL
- `phone_number`: VARCHAR, NULL
- `role`: ENUM (guest, host, admin), NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

#### Property Entity
**Primary Key:** property_id (UUID, Indexed)
**Foreign Key:** host_id (references User.user_id)

**Required Attributes:**
- `property_id`: Primary Key, UUID, Indexed
- `host_id`: Foreign Key, references User(user_id)
- `name`: VARCHAR, NOT NULL
- `description`: TEXT, NOT NULL
- `location`: VARCHAR, NOT NULL
- `pricepernight`: DECIMAL, NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- `updated_at`: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

#### Booking Entity
**Primary Key:** booking_id (UUID, Indexed)
**Foreign Keys:** property_id, user_id

**Required Attributes:**
- `booking_id`: Primary Key, UUID, Indexed
- `property_id`: Foreign Key, references Property(property_id)
- `user_id`: Foreign Key, references User(user_id)
- `start_date`: DATE, NOT NULL
- `end_date`: DATE, NOT NULL
- `total_price`: DECIMAL, NOT NULL
- `status`: ENUM (pending, confirmed, canceled), NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

#### Payment Entity
**Primary Key:** payment_id (UUID, Indexed)
**Foreign Key:** booking_id

**Required Attributes:**
- `payment_id`: Primary Key, UUID, Indexed
- `booking_id`: Foreign Key, references Booking(booking_id)
- `amount`: DECIMAL, NOT NULL
- `payment_date`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- `payment_method`: ENUM (credit_card, paypal, stripe), NOT NULL

#### Review Entity
**Primary Key:** review_id (UUID, Indexed)
**Foreign Keys:** property_id, user_id

**Required Attributes:**
- `review_id`: Primary Key, UUID, Indexed
- `property_id`: Foreign Key, references Property(property_id)
- `user_id`: Foreign Key, references User(user_id)
- `rating`: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
- `comment`: TEXT, NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

#### Message Entity
**Primary Key:** message_id (UUID, Indexed)
**Foreign Keys:** sender_id, recipient_id

**Required Attributes:**
- `message_id`: Primary Key, UUID, Indexed
- `sender_id`: Foreign Key, references User(user_id)
- `recipient_id`: Foreign Key, references User(user_id)
- `message_body`: TEXT, NOT NULL
- `sent_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## Entity Relationships

### One-to-Many Relationships
- **User → Property**: A user (host) can own multiple properties
- **User → Booking**: A user (guest) can make multiple bookings
- **Property → Booking**: A property can have multiple bookings over time
- **User → Review**: A user can write multiple reviews for different properties
- **Property → Review**: A property can receive multiple reviews from different guests
- **User → Message (Sender)**: A user can send multiple messages
- **User → Message (Recipient)**: A user can receive multiple messages

### One-to-One Relationships
- **Booking → Payment**: Each booking has exactly one associated payment record

## Database Constraints

### User Table
- Unique constraint on `email`
- Non-null constraints on required fields (`first_name`, `last_name`, `email`, `password_hash`, `role`)

### Property Table
- Foreign key constraint on `host_id` referencing User(`user_id`)
- Non-null constraints on essential attributes (`name`, `description`, `location`, `pricepernight`)

### Booking Table
- Foreign key constraints on `property_id` and `user_id`
- `status` must be one of: pending, confirmed, or canceled
- Date validation ensuring `end_date` is after `start_date`

### Payment Table
- Foreign key constraint on `booking_id`, ensuring payment is linked to valid bookings
- `payment_method` must be one of: credit_card, paypal, or stripe

### Review Table
- Constraints on rating values (1-5 range)
- Foreign key constraints on `property_id` and `user_id`
- Reviews can only be created by users who have completed bookings for the property

### Message Table
- Foreign key constraints on `sender_id` and `recipient_id`
- Both sender and recipient must be valid users in the system

## Indexing Strategy

### Automatic Indexes
- Primary Keys: Indexed automatically on all entities

### Additional Required Indexes
- `email` in the User table (for login authentication)
- `property_id` in the Property and Booking tables (for property lookups)
- `booking_id` in the Booking and Payment tables (for payment processing)
- `user_id` in Booking, Review, and Message tables (for user-specific queries)
- `host_id` in Property table (for host property listings)

## ER Diagram Notation
- **Entities**: Represented as rectangles containing entity names
- **Attributes**: Listed within entity rectangles with data types
- **Primary Keys**: Underlined or marked with PK notation
- **Foreign Keys**: Marked with FK notation and relationship arrows
- **Relationships**: Shown with connecting lines using crow's foot notation
- **Cardinality**: One-to-many relationships indicated with 1:N notation
