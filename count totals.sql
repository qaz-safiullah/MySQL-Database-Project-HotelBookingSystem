use hotelbookingsystemdb;
select count(*) as total_bookings from bookings;
select count(*) as total_hotels from hotels;
select count(*) as total_staff from staff;
select count(*) as total_customers from customers;
select count(*) as total_rooms from rooms;
select count(*) as total_reviews from reviews;

select * from hotels;

select count(*) from rooms where  availability_status is null;


select
  (select count(*) from bookings) as total_bookings,
  (select count(*) from hotels) as total_hotels,
  (select count(*) from staff) as total_staff,
  (select count(*) from customers) as total_customers,
  (select count(*) from rooms) as total_rooms,
  (select count(*) from reviews) as total_reviews;
 