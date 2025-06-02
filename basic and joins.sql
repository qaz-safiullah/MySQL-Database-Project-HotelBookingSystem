-- basic and joins
-- total revenue
SELECT SUM(DATEDIFF(check_out_date, check_in_date) * r.price_per_night) AS total_revenue
FROM bookings b
JOIN rooms r ON b.room_id = r.room_id
WHERE b.payment_status = 'paid';

-- pending revenue

SELECT SUM(DATEDIFF(check_out_date, check_in_date) * r.price_per_night) AS pending_revenue
FROM bookings b
JOIN rooms r ON b.room_id = r.room_id
WHERE TRIM(LOWER(b.payment_status)) = 'pending';

-- average price of hotel
SELECT h.name AS hotel_name, AVG(r.price_per_night) AS average_price
FROM hotels h
JOIN rooms r ON h.hotel_id = r.hotel_id
GROUP BY h.hotel_id, h.name;

-- available rooms
SELECT availability_status, COUNT(*) AS total_rooms
FROM rooms
where availability_status ='Available'
GROUP BY availability_status;

-- Booked Rooms
SELECT availability_status, COUNT(*) AS total_rooms
FROM rooms
where availability_status ='Booked'
GROUP BY availability_status;

-- Under Maintenance Rooms
SELECT availability_status, COUNT(*) AS total_rooms
FROM rooms
GROUP BY availability_status; 

select * from rooms;
-- average ratings of Hotels based on customer reviews
SELECT h.name AS hotel_name,round(AVG(rv.rating),2) AS average_rating
FROM hotels h
JOIN reviews rv ON h.hotel_id = rv.hotel_id
GROUP BY h.hotel_id, h.name;

-- Staff Per Hotel
SELECT h.name AS hotel_name, COUNT(s.staff_id) AS total_staff
FROM hotels h
JOIN staff s ON h.hotel_id = s.hotel_id
GROUP BY h.hotel_id, h.name;
-- highest and lowest salary in staffs 
SELECT MAX(salary) AS highest_salary, MIN(salary) AS lowest_salary
FROM staff;
-- total paid earning of the hotels
SELECT h.name AS hotel_name,
SUM(DATEDIFF(b.check_out_date, b.check_in_date) * r.price_per_night) AS hotel_revenue
FROM hotels h
JOIN rooms r ON h.hotel_id = r.hotel_id
JOIN bookings b ON r.room_id = b.room_id
WHERE b.payment_status = 'paid'
GROUP BY h.hotel_id, h.name;
-- average number of guests per booking
SELECT AVG(num_guests) AS avg_guests_per_booking
FROM bookings;

-- bookings per month for a specific year
SELECT MONTH(check_in_date) AS booking_month, COUNT(*) AS total_bookings
FROM bookings
where year(check_in_date) = 2024
GROUP BY MONTH(check_in_date)
ORDER BY booking_month;

-- bookings by payment
SELECT payment_status, COUNT(*) AS total
FROM bookings
GROUP BY payment_status;

-- hotel with maximum bookings
SELECT h.name AS hotel_name, COUNT(*) AS total_bookings
FROM hotels h
JOIN rooms r ON h.hotel_id = r.hotel_id
JOIN bookings b ON r.room_id = b.room_id
GROUP BY h.hotel_id, h.name
ORDER BY total_bookings DESC
Limit 1;

-- reviews for each hotel
SELECT h.name AS hotel_name, COUNT(rv.review_id) AS total_reviews
FROM hotels h
LEFT JOIN reviews rv ON h.hotel_id = rv.hotel_id
GROUP BY h.hotel_id, h.name;

-- number of rewies by rating
SELECT rating, COUNT(*) AS total
FROM reviews
GROUP BY rating
order by rating;


-- staff hired per year
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS staff_count
FROM staff
GROUP BY YEAR(hire_date)
ORDER BY hire_year;

-- room availibitly status summary
SELECT availability_status, COUNT(*) AS total_rooms
FROM rooms
GROUP BY availability_status;

-- types of rroms
SELECT COUNT(DISTINCT room_type) AS unique_room_types
FROM rooms;

-- customers by nationality
SELECT nationality, COUNT(*) AS total_customers
FROM customers
GROUP BY nationality
ORDER BY total_customers DESC;

-- total bookings days
SELECT SUM(DATEDIFF(check_out_date, check_in_date)) AS total_nights
FROM bookings
WHERE payment_status = 'paid';

-- number of staff per designantion
SELECT designation, COUNT(*) AS total_staff
FROM staff
GROUP BY designation
ORDER BY total_staff DESC;


-- number of reviews in each month for a specific year
SELECT MONTH(review_date) AS month, COUNT(*) AS total_reviews
FROM reviews
where year(review_date) =2024
GROUP BY MONTH(review_date)
ORDER BY month;

-- bookings per number of days stayed in the hotel 
SELECT DATEDIFF(check_out_date, check_in_date) AS stay_length, COUNT(*) AS total_bookings
FROM bookings
GROUP BY stay_length
ORDER BY stay_length;


select * from bookings