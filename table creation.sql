use hotel_booking_sys1;

create table hotels (
    hotel_id int primary key auto_increment,
    name varchar(100) not null,
    location varchar(100),
    star_rating int check (star_rating between 1 and 5),
    contact_email varchar(100) unique,
    contact_number varchar(100)
);

create table rooms (
    room_id int primary key auto_increment,
    hotel_id int,
    room_type varchar(100),
    room_number varchar(100),
    price_per_night decimal(10, 2),
    availability_status varchar(50) check (availability_status in ('available', 'booked', 'maintenance')),
    foreign key (hotel_id) references hotels(hotel_id),
    unique (hotel_id, room_number)
);

UPDATE rooms
SET availability_status = LOWER(TRIM(availability_status));

create table customers (
    customer_id int primary key auto_increment,
    full_name varchar(100),
    email varchar(100) unique,
    phone_number varchar(100),
    address varchar(200),
    nationality varchar(200),
    identity_number varchar(100)
);

create table bookings (
    booking_id int primary key auto_increment,
    customer_id int,
    room_id int,
    check_in_date date,
    check_out_date date,
    num_guests int check (num_guests > 0),
    payment_status varchar(50) check (payment_status in ('paid', 'pending', 'cancelled')),
    foreign key (customer_id) references customers(customer_id),
    foreign key (room_id) references rooms(room_id),
    check (check_out_date > check_in_date)
);

create table reviews (
    review_id int primary key auto_increment,
    customer_id int,
    hotel_id int,
    booking_id int,
    rating int check (rating between 1 and 5),
    comment text,
    review_date date,
    foreign key (customer_id) references customers(customer_id),
    foreign key (hotel_id) references hotels(hotel_id),
    foreign key (booking_id) references bookings(booking_id)
);

create table staff (
    staff_id int primary key auto_increment,
    hotel_id int,
    full_name varchar(100),
    designation varchar(50),
    salary decimal(10, 2),
    hire_date date,
    foreign key (hotel_id) references hotels(hotel_id)
);