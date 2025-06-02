-- sub queries
-- hotels with above average rating
SELECT hotel_id,name
FROM hotels
WHERE hotel_id IN (
    SELECT hotel_id
    FROM reviews
    GROUP BY hotel_id
    HAVING AVG(rating) > (
        SELECT AVG(rating) FROM reviews
    )
);


-- customers with more than two bookings
SELECT * FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM bookings
    GROUP BY customer_id
    HAVING COUNT(*) > 2
);

-- customers who bookes same room more than once
SELECT c.full_name, r.room_number, COUNT(*) AS times_booked
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN rooms r ON b.room_id = r.room_id
GROUP BY b.customer_id, b.room_id
HAVING COUNT(*) > 1;

-- rooms that were never booked
SELECT room_id, room_number, hotel_id
FROM rooms
WHERE room_id NOT IN (
    SELECT DISTINCT room_id FROM bookings
);

-- total revinue generated per customer
SELECT full_name, email,
(
    SELECT SUM(DATEDIFF(b.check_out_date, b.check_in_date) * r.price_per_night)
    FROM bookings b
    JOIN rooms r ON b.room_id = r.room_id
    WHERE b.customer_id = c.customer_id AND b.payment_status = 'paid'
) AS total_spent
FROM customers c
ORDER BY total_spent DESC;

-- Customers who left a review but never paid for a booking
SELECT DISTINCT c.full_name, c.email
FROM customers c
JOIN reviews r ON c.customer_id = r.customer_id
WHERE c.customer_id NOT IN (
    SELECT customer_id
    FROM bookings
    WHERE payment_status = 'pending'
);

-- customers who stayed in more than one hotel
SELECT full_name, email
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM bookings b
    JOIN rooms r ON b.room_id = r.room_id
    GROUP BY customer_id
    HAVING COUNT(DISTINCT r.hotel_id) > 1
);

