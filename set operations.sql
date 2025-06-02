-- set operations
-- customers who booked but never reviewed
SELECT DISTINCT customer_id, full_name, email
FROM customers
WHERE customer_id IN (SELECT customer_id FROM bookings)
AND customer_id NOT IN (SELECT customer_id FROM reviews);

-- rooms that were never booked in a hotel
SELECT room_number,hotel_id
FROM rooms
WHERE room_id NOT IN (SELECT room_id FROM bookings);

-- Customers who have booked and also left a review
SELECT DISTINCT c.customer_id, c.full_name, c.email
FROM customers c
JOIN bookings b ON c.customer_id = b.customer_id
WHERE c.customer_id IN (SELECT customer_id FROM reviews);


-- Get a list of all distinct customers who either made a booking or submitted a review (no duplicates).
SELECT customer_id, full_name, email
FROM customers
WHERE customer_id IN (SELECT customer_id FROM bookings)
UNION
SELECT customer_id, full_name, email
FROM customers
WHERE customer_id IN (SELECT customer_id FROM reviews);

-- union all
SELECT distinct customer_id, 'booking' AS activity_type
FROM bookings
UNION ALL
SELECT customer_id, 'review' AS activity_type
FROM reviews;