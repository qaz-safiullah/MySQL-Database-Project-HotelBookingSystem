-- procedures
-- mark a booking paid 
DELIMITER //
CREATE PROCEDURE MarkBookingPaid (
    IN p_booking_id INT
)
BEGIN
    UPDATE bookings
    SET payment_status = 'paid'
    WHERE booking_id = p_booking_id;
END //
DELIMITER ;

call MarkBookingPaid(1001);
select booking_id from bookings where payment_status ='pending'


-- get available rooms for hotel
DELIMITER //

CREATE PROCEDURE GetAvailableRooms(in p_hotel_id int)
BEGIN
SELECT *FROM rooms
WHERE availability_status = 'available'
AND hotel_id = p_hotel_id;
END //
DELIMITER ;

-- get rooms by availibility status
DELIMITER //

CREATE PROCEDURE  GetRoomsByStatus(IN p_status VARCHAR(50),p_hotel_id int)
BEGIN
    SELECT * FROM rooms
    WHERE availability_status = p_status
    and hotel_id =p_hotel_id;
END //
DELIMITER ;

call GetRoomsByStatus('maintenance',5);

-- payment status of bookings
DELIMITER //
CREATE PROCEDURE GetBookingStatusCount()
BEGIN
    SELECT payment_status, COUNT(*) AS count
    FROM bookings
    GROUP BY payment_status;
END //
DELIMITER ;
call GetBookingStatusCount;

-- staff count for hotel
DELIMITER //

CREATE PROCEDURE GetHotelStaffCount(IN p_hotel_id INT)
BEGIN
    SELECT COUNT(*) AS total_staff
    FROM staff
    WHERE hotel_id = p_hotel_id;
END //
DELIMITER ;


-- mark room as availabel
DELIMITER //

CREATE PROCEDURE MarkRoomAsAvailable(IN p_room_id INT)
BEGIN
    UPDATE rooms
    SET availability_status = 'available'
    WHERE room_id = p_room_id;
END //

DELIMITER ;


-- total number of available rooms in a hotel
DELIMITER //

CREATE PROCEDURE GetTotalAvailableRooms(IN p_hotel_id INT,room_status varchar(100))
BEGIN
    SELECT COUNT(*) AS total_rooms
    FROM rooms
    WHERE hotel_id = p_hotel_id and availability_status = room_status ;
END //

DELIMITER ;




