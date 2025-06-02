-- views
-- view available rooms
CREATE VIEW view_available_rooms AS
SELECT r.room_id, r.room_number, r.room_type, r.price_per_night, h.name AS hotel_name, h.location
FROM rooms r
JOIN hotels h ON r.hotel_id = h.hotel_id
WHERE r.availability_status = 'available';

-- view customers bookings
CREATE VIEW view_customer_bookings AS
SELECT b.booking_id, c.full_name, r.room_number, b.check_in_date, b.check_out_date, b.payment_status
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN rooms r ON b.room_id = r.room_id;
select * from view_customer_bookings;

-- view hotel revenue
CREATE VIEW view_hotel_revenue AS
SELECT h.name AS hotel_name,
       SUM(DATEDIFF(b.check_out_date, b.check_in_date) * r.price_per_night) AS total_revenue
FROM hotels h
JOIN rooms r ON h.hotel_id = r.hotel_id
JOIN bookings b ON r.room_id = b.room_id
WHERE b.payment_status = 'paid'
GROUP BY h.hotel_id, h.name;

-- hotel reviews and rating
CREATE VIEW view_hotel_ratings AS
SELECT h.name AS hotel_name,
       ROUND(AVG(rv.rating), 2) AS average_rating,
       COUNT(rv.review_id) AS total_reviews
FROM hotels h
LEFT JOIN reviews rv ON h.hotel_id = rv.hotel_id
GROUP BY h.hotel_id, h.name;

-- view staff info in a hotel
CREATE VIEW view_staff_info AS
SELECT s.staff_id, s.full_name, s.designation, s.salary, h.name AS hotel_name
FROM staff s
JOIN hotels h ON s.hotel_id = h.hotel_id;
Select * from view_staff_info;

-- view pending payments
CREATE  VIEW view_pending_payments AS
SELECT b.booking_id, c.full_name, r.room_number, h.name AS hotel_name,
       b.check_in_date, b.check_out_date,
       DATEDIFF(b.check_out_date, b.check_in_date) * r.price_per_night AS amount_due
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN rooms r ON b.room_id = r.room_id
JOIN hotels h ON r.hotel_id = h.hotel_id
WHERE b.payment_status = 'pending';


-- view frequent customerss
CREATE VIEW view_frequent_customers AS
SELECT c.customer_id, c.full_name, c.email, COUNT(b.booking_id) AS total_bookings
FROM customers c
JOIN bookings b ON c.customer_id = b.customer_id
GROUP BY c.customer_id, c.full_name, c.email
HAVING COUNT(b.booking_id) > 2;

-- view rooms under maintanence
CREATE VIEW view_maintenance_rooms AS
SELECT r.room_id, r.room_number, r.room_type, h.name AS hotel_name
FROM rooms r
JOIN hotels h ON r.hotel_id = h.hotel_id
WHERE r.availability_status = 'maintenance';


-- check daily check ins
CREATE VIEW view_today_checkins AS
SELECT b.booking_id, c.full_name, r.room_number, h.name AS hotel_name
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN rooms r ON b.room_id = r.room_id
JOIN hotels h ON r.hotel_id = h.hotel_id
WHERE b.check_in_date = CURDATE();


-- staff contact information
CREATE VIEW view_staff_contacts AS
SELECT s.staff_id, s.full_name, s.designation, h.name AS hotel_name
FROM staff s
JOIN hotels h ON s.hotel_id = h.hotel_id;


-- view canceled bookings

CREATE VIEW view_cancelled_bookings AS
SELECT b.booking_id, c.full_name, h.name AS hotel_name, r.room_number,
       b.check_in_date, b.check_out_date, b.payment_status
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN rooms r ON b.room_id = r.room_id
JOIN hotels h ON r.hotel_id = h.hotel_id
WHERE b.payment_status = 'cancelled';


