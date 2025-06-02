-- ACID

-- Atomoicity
START TRANSACTION;

INSERT INTO bookings (customer_id, room_id, check_in_date, check_out_date, num_guests, payment_status)
VALUES (1, 1, '2024-07-10', '2024-07-15', 2, 'pending');

UPDATE rooms
SET availability_status = 'booked'
WHERE room_id = 1 AND availability_status = 'available';

COMMIT;

-- Consistency
-- This insert will fail if check_out_date <= check_in_date due to check constraint
INSERT INTO bookings (customer_id, room_id, check_in_date, check_out_date, num_guests, payment_status)
VALUES (1, 1, '2024-07-15', '2024-07-10', 2, 'pending');


-- issolation

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT * FROM rooms WHERE room_id = 1 AND availability_status = 'available' FOR UPDATE;
COMMIT;


-- durrability
START TRANSACTION;
INSERT INTO customers (full_name, email, phone_number)
VALUES ('John Doe', 'john@example.com', '1234567890');

COMMIT;

-- Indexing
CREATE INDEX idx_rooms_hotel ON rooms(hotel_id);
CREATE INDEX idx_bookings_customer ON bookings(customer_id);
CREATE INDEX idx_bookings_room ON bookings(room_id);
CREATE INDEX idx_bookings_checkin ON bookings(check_in_date);
CREATE INDEX idx_reviews_hotel ON reviews(hotel_id);
CREATE INDEX idx_staff_hotel ON staff(hotel_id);

EXPLAIN SELECT * FROM rooms WHERE hotel_id = 5;
 