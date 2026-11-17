create database airlineDB;

use airlineDB;

create table airports (
code int primary key,
name varchar(50),
city varchar(50),
state varchar(50),
country varchar(50)
);

create table airport_staff (
staffID int primary key,
name varchar(50),
gender varchar(50),
DOB varchar(50),
phone varchar(50),
email varchar(50),
job_title varchar(50),
airportID int,
shift varchar(50),
salary float,
status varchar(50),

foreign key (airportID)
references airports(code)
);

create table aircraft (
aircraftID int primary key,
model varchar(50),
manufacturer varchar(50),
seating_capacity varchar(50),
registration_no varchar(50)
);

create table flights (
flightID int primary key,
airline_name varchar(50),
departure_airport int,
arrival_airport int,
aircraft_assigned int,
departure_time time,
arrival_time time,

foreign key (departure_airport)
references airports(code),
foreign key (arrival_airport)
references airports(code),
foreign key (aircraft_assigned)
references aircraft(aircraftID)
);

create table flight_schedule (
	sheduleID int primary key,
    flightID int,
    schedule_date varchar(50),
    
    foreign key (flightID)
    references flights(flightID)
);

create table flight_status(
	statusID int primary key,
    flightID int,
    status varchar(50),
    updated_time timestamp,
    
    foreign key (flightID)
    references flights(flightID)
);

 create table crew(
	crewID int primary key,
    name varchar(50),
    designation varchar(50),
    phone varchar(50),
    email varchar(50) unique,
    experience varchar(50)
);

create table crew_assignments(
	assignmentID int primary key,
    flightID int,
    crewID int,
    status varchar(50),
    updated_time timestamp,
    
    foreign key (flightID)
    references flights(flightID),
    
    foreign key (crewID)
    references crew(crewID)
);

create table passengers(
	passengerID int primary key,
    name varchar(50),
    gender varchar(50),
    DOB date,
    phone varchar(50),
    email varchar(50),
    passport_no varchar(50),
    nationality varchar(50)
);

create table bookings(
bookingID int primary key, 
passengerID int, 
booking_date timestamp,
flightID int,
status varchar(50),

foreign key (passengerID)
references passengers(passengerID),

foreign key (flightID)
references flights(flightID)
);

create table payments(
	paymentID int primary key,
    bookingID int,
    amount float,
    method varchar(50),
    payment_date timestamp,
    payment_status varchar(50),
    transactionID int,
    
    foreign key (bookingID)
    references bookings(bookingID)
);

create table tickets(
	ticketID int primary key,
    bookingID int,
    passengerID int,
    seat_number varchar(50),
    fare_class varchar(50),
    issue_date timestamp,
    ticket_status varchar(50),
    
    foreign key (bookingID) 
    references bookings(bookingID),
    
    foreign key (passengerID)
    references passengers(passengerID)
);

create table baggage(
	baggageID int primary key,
    ticketID int,
    weight_kg float,
    type varchar(50),
    status varchar(50),
    
    foreign key (ticketID)
    references tickets(ticketID)
);

INSERT INTO airports (code, name, city, state, country) VALUES
(101, 'Indira Gandhi International Airport', 'New Delhi', 'Delhi', 'India'),
(102, 'Chhatrapati Shivaji Maharaj International Airport', 'Mumbai', 'Maharashtra', 'India'),
(103, 'Kempegowda International Airport', 'Bengaluru', 'Karnataka', 'India'),
(104, 'Chennai International Airport', 'Chennai', 'Tamil Nadu', 'India'),
(105, 'Cochin International Airport', 'Kochi', 'Kerala', 'India'),
(106, 'Rajiv Gandhi International Airport', 'Hyderabad', 'Telangana', 'India'),
(107, 'Netaji Subhas Chandra Bose International Airport', 'Kolkata', 'West Bengal', 'India'),
(108, 'Sardar Vallabhbhai Patel International Airport', 'Ahmedabad', 'Gujarat', 'India'),
(109, 'Calicut International Airport', 'Kozhikode', 'Kerala', 'India'),
(110, 'Kannur International Airport', 'Kannur', 'Kerala', 'India');

INSERT INTO airport_staff
(staffID, name, gender, DOB, phone, email, job_title, airportID, shift, salary, status)
VALUES
(201, 'Rahul Sharma', 'Male', '1990-05-12', '9876543210', 'rahul.sharma@airport.com', 'Airport Manager', 101, 'Morning', 75000, 'Active'),
(202, 'Priya Nair', 'Female', '1995-08-20', '9876543211', 'priya.nair@airport.com', 'Check-in Agent', 102, 'Evening', 35000, 'Active'),
(203, 'Arun Kumar', 'Male', '1992-11-15', '9876543212', 'arun.kumar@airport.com', 'Security Officer', 103, 'Night', 40000, 'Active'),
(204, 'Sneha Menon', 'Female', '1997-03-10', '9876543213', 'sneha.menon@airport.com', 'Ground Staff', 104, 'Morning', 32000, 'Active'),
(205, 'Vijay Patel', 'Male', '1988-09-05', '9876543214', 'vijay.patel@airport.com', 'Baggage Handler', 105, 'Evening', 30000, 'Active'),
(206, 'Anjali Singh', 'Female', '1993-12-18', '9876543215', 'anjali.singh@airport.com', 'Customer Service Executive', 106, 'Morning', 38000, 'Active'),
(207, 'Kiran Das', 'Male', '1991-06-22', '9876543216', 'kiran.das@airport.com', 'Security Officer', 107, 'Night', 42000, 'Active'),
(208, 'Meera Joseph', 'Female', '1994-04-14', '9876543217', 'meera.joseph@airport.com', 'Ground Staff', 108, 'Evening', 33000, 'Active'),
(209, 'Sanjay Verma', 'Male', '1989-10-30', '9876543218', 'sanjay.verma@airport.com', 'Maintenance Engineer', 109, 'Morning', 55000, 'Active'),
(210, 'Aisha Khan', 'Female', '1996-01-25', '9876543219', 'aisha.khan@airport.com', 'Check-in Agent', 110, 'Night', 36000, 'Active');

ALTER TABLE airport_staff
MODIFY DOB DATE;

INSERT INTO aircraft
(aircraftID, model, manufacturer, seating_capacity, registration_no)
VALUES
(301, 'A320', 'Airbus', '180', 'VT-AXA'),
(302, 'A321', 'Airbus', '220', 'VT-AXB'),
(303, 'A330', 'Airbus', '290', 'VT-AXC'),
(304, 'B737-800', 'Boeing', '189', 'VT-BXA'),
(305, 'B737 MAX 8', 'Boeing', '210', 'VT-BXB'),
(306, 'B777-300ER', 'Boeing', '396', 'VT-BXC'),
(307, 'ATR 72-600', 'ATR', '78', 'VT-ATA'),
(308, 'Q400', 'De Havilland', '90', 'VT-DHA'),
(309, 'A350-900', 'Airbus', '325', 'VT-AXD'),
(310, 'B787-8 Dreamliner', 'Boeing', '256', 'VT-BXD');

alter table aircraft modify seating_capacity int;

INSERT INTO flights
(flightID, airline_name, departure_airport, arrival_airport, aircraft_assigned, departure_time, arrival_time)
VALUES
(401, 'Air India',       101, 102, 301, '06:30:00', '08:45:00'),
(402, 'IndiGo',          102, 103, 302, '09:15:00', '11:00:00'),
(403, 'SpiceJet',        103, 104, 303, '12:00:00', '13:20:00'),
(404, 'Vistara',         104, 105, 304, '14:30:00', '15:45:00'),
(405, 'Akasa Air',       105, 106, 305, '16:15:00', '17:50:00'),
(406, 'Air India',       106, 107, 306, '18:30:00', '20:45:00'),
(407, 'IndiGo',          107, 108, 307, '07:00:00', '08:50:00'),
(408, 'SpiceJet',        108, 109, 308, '10:30:00', '12:15:00'),
(409, 'Vistara',         109, 110, 309, '13:45:00', '15:10:00'),
(410, 'Air India',       110, 101, 310, '19:00:00', '21:30:00');


alter table flight_schedule rename column sheduleID to scheduleID;
 

INSERT INTO flight_schedule
(scheduleID, flightID, schedule_date)
VALUES
(501, 401, '2026-08-10'),
(502, 402, '2026-08-10'),
(503, 403, '2026-08-11'),
(504, 404, '2026-08-11'),
(505, 405, '2026-08-12'),
(506, 406, '2026-08-12'),
(507, 407, '2026-08-13'),
(508, 408, '2026-08-13'),
(509, 409, '2026-08-14'),
(510, 410, '2026-08-14');

alter table flight_schedule modify schedule_date date;

INSERT INTO flight_status
(statusID, flightID, status, updated_time)
VALUES
(601, 401, 'On Time',  '2026-08-10 05:45:00'),
(602, 402, 'Boarding', '2026-08-10 08:45:00'),
(603, 403, 'Delayed',  '2026-08-11 11:40:00'),
(604, 404, 'On Time',  '2026-08-11 13:50:00'),
(605, 405, 'Cancelled','2026-08-12 15:30:00'),
(606, 406, 'Departed', '2026-08-12 18:35:00'),
(607, 407, 'Arrived',  '2026-08-13 09:00:00'),
(608, 408, 'Boarding', '2026-08-13 10:00:00'),
(609, 409, 'Delayed',  '2026-08-14 13:20:00'),
(610, 410, 'Scheduled','2026-08-14 17:30:00');


alter table crew modify experience int;

INSERT INTO crew
(crewID, name, designation, phone, email, experience)
VALUES
(701, 'Rajesh Kumar', 'Pilot', '9876500001', 'rajesh.kumar@airline.com', 12),

(702, 'Anita Thomas', 'Co-Pilot', '9876500002', 'anita.thomas@airline.com', 8),

(703, 'Vikram Singh', 'Cabin Crew', '9876500003', 'vikram.singh@airline.com', 5),

(704, 'Neha Joseph', 'Cabin Crew', '9876500004', 'neha.joseph@airline.com', 4),

(705, 'Arun Nair', 'Pilot', '9876500005', 'arun.nair@airline.com', 15),

(706, 'Pooja Sharma', 'Cabin Crew', '9876500006', 'pooja.sharma@airline.com', 6),

(707, 'Karthik Reddy', 'Co-Pilot', '9876500007', 'karthik.reddy@airline.com', 7),

(708, 'Meera Das', 'Cabin Crew', '9876500008', 'meera.das@airline.com', 3),

(709, 'Suresh Patel', 'Pilot', '9876500009', 'suresh.patel@airline.com', 18),

(710, 'Divya Menon', 'Cabin Crew', '9876500010', 'divya.menon@airline.com', 2);


INSERT INTO crew_assignments
(assignmentID, flightID, crewID, status, updated_time)
VALUES
(801, 401, 701, 'Assigned', '2026-08-09 18:00:00'),
(802, 402, 702, 'Assigned', '2026-08-09 18:15:00'),
(803, 403, 703, 'Assigned', '2026-08-10 09:30:00'),
(804, 404, 704, 'Assigned', '2026-08-10 10:00:00'),
(805, 405, 705, 'Assigned', '2026-08-11 08:45:00'),
(806, 406, 706, 'Assigned', '2026-08-11 09:15:00'),
(807, 407, 707, 'Assigned', '2026-08-12 07:30:00'),
(808, 408, 708, 'Assigned', '2026-08-12 08:00:00'),
(809, 409, 709, 'Assigned', '2026-08-13 12:00:00'),
(810, 410, 710, 'Assigned', '2026-08-13 13:00:00');

INSERT INTO passengers
(passengerID, name, gender, DOB, phone, email, passport_no, nationality)
VALUES
(901, 'Arjun S K', 'Male', '2002-03-15', '9876000001', 'arjun.sk@gmail.com', 'P1234567', 'Indian'),

(902, 'Rahul Sharma', 'Male', '1998-07-21', '9876000002', 'rahul.sharma@gmail.com', 'P1234568', 'Indian'),

(903, 'Priya Nair', 'Female', '1999-11-10', '9876000003', 'priya.nair@gmail.com', 'P1234569', 'Indian'),

(904, 'Anjali Menon', 'Female', '2000-01-18', '9876000004', 'anjali.menon@gmail.com', 'P1234570', 'Indian'),

(905, 'Vishnu Kumar', 'Male', '1997-06-30', '9876000005', 'vishnu.kumar@gmail.com', 'P1234571', 'Indian'),

(906, 'Sneha Thomas', 'Female', '2001-09-14', '9876000006', 'sneha.thomas@gmail.com', 'P1234572', 'Indian'),

(907, 'Akash Reddy', 'Male', '1996-12-05', '9876000007', 'akash.reddy@gmail.com', 'P1234573', 'Indian'),

(908, 'Meera Joseph', 'Female', '1995-04-28', '9876000008', 'meera.joseph@gmail.com', 'P1234574', 'Indian'),

(909, 'Sanjay Patel', 'Male', '1994-08-19', '9876000009', 'sanjay.patel@gmail.com', 'P1234575', 'Indian'),

(910, 'Aisha Khan', 'Female', '2002-02-11', '9876000010', 'aisha.khan@gmail.com', 'P1234576', 'Indian');


INSERT INTO bookings
(bookingID, passengerID, booking_date, flightID, status)
VALUES
(1001, 901, '2026-08-01 10:15:00', 401, 'Confirmed'),
(1002, 902, '2026-08-01 11:30:00', 402, 'Confirmed'),
(1003, 903, '2026-08-02 09:45:00', 403, 'Pending'),
(1004, 904, '2026-08-02 14:20:00', 404, 'Confirmed'),
(1005, 905, '2026-08-03 16:10:00', 405, 'Cancelled'),
(1006, 906, '2026-08-03 17:25:00', 406, 'Confirmed'),
(1007, 907, '2026-08-04 08:40:00', 407, 'Confirmed'),
(1008, 908, '2026-08-04 12:00:00', 408, 'Pending'),
(1009, 909, '2026-08-05 15:30:00', 409, 'Confirmed'),
(1010, 910, '2026-08-05 18:45:00', 410, 'Confirmed');

INSERT INTO payments
(paymentID, bookingID, amount, method, payment_date, payment_status, transactionID)
VALUES
(1101, 1001, 5500.00, 'UPI',          '2026-08-01 10:20:00', 'Success', 500001),
(1102, 1002, 7200.00, 'Credit Card',  '2026-08-01 11:35:00', 'Success', 500002),
(1103, 1003, 4800.00, 'Debit Card',   '2026-08-02 09:50:00', 'Pending', 500003),
(1104, 1004, 6500.00, 'Net Banking',  '2026-08-02 14:25:00', 'Success', 500004),
(1105, 1005, 5800.00, 'UPI',          '2026-08-03 16:15:00', 'Refunded',500005),
(1106, 1006, 8100.00, 'Credit Card',  '2026-08-03 17:30:00', 'Success', 500006),
(1107, 1007, 4600.00, 'Debit Card',   '2026-08-04 08:45:00', 'Success', 500007),
(1108, 1008, 6900.00, 'UPI',          '2026-08-04 12:05:00', 'Pending', 500008),
(1109, 1009, 7500.00, 'Net Banking',  '2026-08-05 15:35:00', 'Success', 500009),
(1110, 1010, 6200.00, 'Credit Card',  '2026-08-05 18:50:00', 'Success', 500010);

INSERT INTO tickets
(ticketID, bookingID, passengerID, seat_number, fare_class, issue_date, ticket_status)
VALUES
(1201, 1001, 901, '12A', 'Economy', '2026-08-01 10:25:00', 'Issued'),
(1202, 1002, 902, '08C', 'Business', '2026-08-01 11:40:00', 'Issued'),
(1203, 1003, 903, '15B', 'Economy', '2026-08-02 09:55:00', 'Pending'),
(1204, 1004, 904, '02A', 'First Class', '2026-08-02 14:30:00', 'Issued'),
(1205, 1005, 905, '18D', 'Economy', '2026-08-03 16:20:00', 'Cancelled'),
(1206, 1006, 906, '05F', 'Business', '2026-08-03 17:35:00', 'Issued'),
(1207, 1007, 907, '21C', 'Economy', '2026-08-04 08:50:00', 'Issued'),
(1208, 1008, 908, '10A', 'Premium Economy', '2026-08-04 12:10:00', 'Pending'),
(1209, 1009, 909, '03B', 'Business', '2026-08-05 15:40:00', 'Issued'),
(1210, 1010, 910, '16E', 'Economy', '2026-08-05 18:55:00', 'Issued');

INSERT INTO baggage
(baggageID, ticketID, weight_kg, type, status)
VALUES
(1301, 1201, 18.5, 'Checked-In', 'Loaded'),
(1302, 1202, 22.0, 'Checked-In', 'Loaded'),
(1303, 1203, 15.0, 'Cabin', 'Pending'),
(1304, 1204, 25.5, 'Checked-In', 'Loaded'),
(1305, 1205, 20.0, 'Checked-In', 'Cancelled'),
(1306, 1206, 17.0, 'Cabin', 'Loaded'),
(1307, 1207, 19.5, 'Checked-In', 'Loaded'),
(1308, 1208, 14.0, 'Cabin', 'Pending'),
(1309, 1209, 23.0, 'Checked-In', 'Loaded'),
(1310, 1210, 16.5, 'Cabin', 'Loaded');


SELECT * FROM airports;
SELECT * FROM airport_staff;
SELECT * FROM flights;
SELECT * FROM flight_schedule;
SELECT * FROM flight_status;
SELECT * FROM crew;
SELECT * FROM crew_assignments;
SELECT * FROM passengers;
SELECT * FROM bookings;
SELECT * FROM payments;
SELECT * FROM tickets;
SELECT * FROM baggage;
SELECT * FROM aircraft;

INSERT INTO airport_staff
(staffID, name, gender, DOB, phone, email, job_title, airportID, shift, salary, status)
VALUES

-- Delhi Airport (101)
(211, 'Rohit Mehra', 'Male', '1992-02-15', '9876543221', 'rohit.mehra@airport.com', 'Security Officer', 101, 'Night', 42000, 'Active'),
(212, 'Pooja Verma', 'Female', '1996-07-18', '9876543222', 'pooja.verma@airport.com', 'Check-in Agent', 101, 'Evening', 35000, 'Active'),

-- Mumbai Airport (102)
(213, 'Ajay Nair', 'Male', '1991-05-12', '9876543223', 'ajay.nair@airport.com', 'Ground Staff', 102, 'Morning', 32000, 'Active'),
(214, 'Divya Sharma', 'Female', '1994-10-08', '9876543224', 'divya.sharma@airport.com', 'Security Officer', 102, 'Night', 41000, 'Active'),

-- Bengaluru Airport (103)
(215, 'Kiran Babu', 'Male', '1993-09-14', '9876543225', 'kiran.babu@airport.com', 'Check-in Agent', 103, 'Morning', 36000, 'Active'),
(216, 'Anu Thomas', 'Female', '1995-12-20', '9876543226', 'anu.thomas@airport.com', 'Ground Staff', 103, 'Evening', 33000, 'Active'),

-- Chennai Airport (104)
(217, 'Manoj Kumar', 'Male', '1990-04-11', '9876543227', 'manoj.kumar@airport.com', 'Security Officer', 104, 'Morning', 43000, 'Active'),
(218, 'Reshma Ali', 'Female', '1997-06-30', '9876543228', 'reshma.ali@airport.com', 'Customer Service Executive', 104, 'Evening', 39000, 'Active'),

-- Kochi Airport (105)
(219, 'Nithin Raj', 'Male', '1994-08-05', '9876543229', 'nithin.raj@airport.com', 'Ground Staff', 105, 'Night', 31000, 'Active'),
(220, 'Aparna Das', 'Female', '1996-03-17', '9876543230', 'aparna.das@airport.com', 'Check-in Agent', 105, 'Morning', 35000, 'Active'),

-- Hyderabad Airport (106)
(221, 'Sandeep Rao', 'Male', '1992-11-09', '9876543231', 'sandeep.rao@airport.com', 'Security Officer', 106, 'Evening', 42000, 'Active'),
(222, 'Keerthi Menon', 'Female', '1995-01-28', '9876543232', 'keerthi.menon@airport.com', 'Ground Staff', 106, 'Morning', 32000, 'Active'),

-- Kolkata Airport (107)
(223, 'Rakesh Das', 'Male', '1991-07-23', '9876543233', 'rakesh.das@airport.com', 'Check-in Agent', 107, 'Morning', 35000, 'Active'),
(224, 'Sneha Roy', 'Female', '1996-02-12', '9876543234', 'sneha.roy@airport.com', 'Customer Service Executive', 107, 'Evening', 38000, 'Active'),

-- Ahmedabad Airport (108)
(225, 'Harsh Patel', 'Male', '1993-05-19', '9876543235', 'harsh.patel@airport.com', 'Security Officer', 108, 'Night', 42000, 'Active'),
(226, 'Maya Shah', 'Female', '1997-09-25', '9876543236', 'maya.shah@airport.com', 'Ground Staff', 108, 'Morning', 33000, 'Active'),

-- Kozhikode Airport (109)
(227, 'Faiz Rahman', 'Male', '1994-01-15', '9876543237', 'faiz.rahman@airport.com', 'Baggage Handler', 109, 'Evening', 30000, 'Active'),
(228, 'Nisha Krishnan', 'Female', '1995-11-07', '9876543238', 'nisha.krishnan@airport.com', 'Check-in Agent', 109, 'Morning', 35000, 'Active'),

-- Kannur Airport (110)
(229, 'Asif Ali', 'Male', '1992-08-18', '9876543239', 'asif.ali@airport.com', 'Security Officer', 110, 'Morning', 42000, 'Active'),
(230, 'Lakshmi Nair', 'Female', '1996-12-03', '9876543240', 'lakshmi.nair@airport.com', 'Ground Staff', 110, 'Evening', 33000, 'Active');


INSERT INTO passengers
(passengerID, name, gender, DOB, phone, email, passport_no, nationality)
VALUES
(911, 'Rahul Menon', 'Male', '1998-05-10', '9876000011', 'rahul.menon@gmail.com', 'P1234577', 'Indian'),
(912, 'Anjali Nair', 'Female', '1999-08-14', '9876000012', 'anjali.nair@gmail.com', 'P1234578', 'Indian'),
(913, 'Vivek Sharma', 'Male', '1995-03-21', '9876000013', 'vivek.sharma@gmail.com', 'P1234579', 'Indian'),
(914, 'Sneha Pillai', 'Female', '2000-11-05', '9876000014', 'sneha.pillai@gmail.com', 'P1234580', 'Indian'),
(915, 'Akhil Raj', 'Male', '1997-01-28', '9876000015', 'akhil.raj@gmail.com', 'P1234581', 'Indian'),
(916, 'Meera George', 'Female', '1996-09-16', '9876000016', 'meera.george@gmail.com', 'P1234582', 'Indian'),
(917, 'Nikhil Das', 'Male', '1994-12-12', '9876000017', 'nikhil.das@gmail.com', 'P1234583', 'Indian'),
(918, 'Keerthana S', 'Female', '2001-06-09', '9876000018', 'keerthana.s@gmail.com', 'P1234584', 'Indian'),
(919, 'Sanjay Kumar', 'Male', '1993-02-18', '9876000019', 'sanjay.kumar@gmail.com', 'P1234585', 'Indian'),
(920, 'Aparna Mohan', 'Female', '1998-07-27', '9876000020', 'aparna.mohan@gmail.com', 'P1234586', 'Indian'),

(921, 'Arun Babu', 'Male', '1999-04-22', '9876000021', 'arun.babu@gmail.com', 'P1234587', 'Indian'),
(922, 'Divya Joseph', 'Female', '1995-10-13', '9876000022', 'divya.joseph@gmail.com', 'P1234588', 'Indian'),
(923, 'Rohit Verma', 'Male', '1996-08-30', '9876000023', 'rohit.verma@gmail.com', 'P1234589', 'Indian'),
(924, 'Anu Mathew', 'Female', '2002-01-11', '9876000024', 'anu.mathew@gmail.com', 'P1234590', 'Indian'),
(925, 'Harish Nair', 'Male', '1991-11-09', '9876000025', 'harish.nair@gmail.com', 'P1234591', 'Indian'),
(926, 'Nisha Roy', 'Female', '1998-03-15', '9876000026', 'nisha.roy@gmail.com', 'P1234592', 'Indian'),
(927, 'Faiz Ahmed', 'Male', '1997-05-18', '9876000027', 'faiz.ahmed@gmail.com', 'P1234593', 'Indian'),
(928, 'Lakshmi Devi', 'Female', '1994-09-25', '9876000028', 'lakshmi.devi@gmail.com', 'P1234594', 'Indian'),
(929, 'Karthik R', 'Male', '2000-12-20', '9876000029', 'karthik.r@gmail.com', 'P1234595', 'Indian'),
(930, 'Pooja Krishnan', 'Female', '1999-07-08', '9876000030', 'pooja.krishnan@gmail.com', 'P1234596', 'Indian');

INSERT INTO bookings
(bookingID, passengerID, booking_date, flightID, status)
VALUES

-- Flight 401 (Delhi → Mumbai)
(1011, 911, '2026-08-06 09:15:00', 401, 'Confirmed'),
(1012, 912, '2026-08-06 09:30:00', 401, 'Confirmed'),
(1013, 913, '2026-08-06 09:45:00', 401, 'Pending'),

-- Flight 402 (Mumbai → Bengaluru)
(1014, 914, '2026-08-06 10:00:00', 402, 'Confirmed'),
(1015, 915, '2026-08-06 10:20:00', 402, 'Confirmed'),

-- Flight 403 (Bengaluru → Chennai)
(1016, 916, '2026-08-06 10:40:00', 403, 'Confirmed'),
(1017, 917, '2026-08-06 11:00:00', 403, 'Pending'),

-- Flight 404 (Chennai → Kochi)
(1018, 918, '2026-08-06 11:15:00', 404, 'Confirmed'),
(1019, 919, '2026-08-06 11:30:00', 404, 'Confirmed'),

-- Flight 405 (Kochi → Hyderabad)
(1020, 920, '2026-08-06 11:45:00', 405, 'Confirmed'),
(1021, 921, '2026-08-06 12:00:00', 405, 'Cancelled'),

-- Flight 406 (Hyderabad → Kolkata)
(1022, 922, '2026-08-06 12:15:00', 406, 'Confirmed'),
(1023, 923, '2026-08-06 12:30:00', 406, 'Confirmed'),

-- Flight 407 (Kolkata → Ahmedabad)
(1024, 924, '2026-08-06 12:45:00', 407, 'Confirmed'),
(1025, 925, '2026-08-06 13:00:00', 407, 'Pending'),

-- Flight 408 (Ahmedabad → Kozhikode)
(1026, 926, '2026-08-06 13:15:00', 408, 'Confirmed'),
(1027, 927, '2026-08-06 13:30:00', 408, 'Confirmed'),

-- Flight 409 (Kozhikode → Kannur)
(1028, 928, '2026-08-06 13:45:00', 409, 'Confirmed'),

-- Flight 410 (Kannur → Delhi)
(1029, 929, '2026-08-06 14:00:00', 410, 'Confirmed'),
(1030, 930, '2026-08-06 14:15:00', 410, 'Confirmed');


INSERT INTO tickets
(ticketID, bookingID, passengerID, seat_number, fare_class, issue_date, ticket_status)
VALUES

-- Flight 401
(1211, 1011, 911, '12B', 'Economy', '2026-08-06 09:20:00', 'Issued'),
(1212, 1012, 912, '12C', 'Economy', '2026-08-06 09:35:00', 'Issued'),
(1213, 1013, 913, '13A', 'Economy', '2026-08-06 09:50:00', 'Pending'),

-- Flight 402
(1214, 1014, 914, '14A', 'Business', '2026-08-06 10:05:00', 'Issued'),
(1215, 1015, 915, '14B', 'Economy', '2026-08-06 10:25:00', 'Issued'),

-- Flight 403
(1216, 1016, 916, '15A', 'Economy', '2026-08-06 10:45:00', 'Issued'),
(1217, 1017, 917, '15B', 'Economy', '2026-08-06 11:05:00', 'Pending'),

-- Flight 404
(1218, 1018, 918, '16A', 'Business', '2026-08-06 11:20:00', 'Issued'),
(1219, 1019, 919, '16B', 'Economy', '2026-08-06 11:35:00', 'Issued'),

-- Flight 405
(1220, 1020, 920, '17A', 'Economy', '2026-08-06 11:50:00', 'Issued'),
(1221, 1021, 921, '17B', 'Economy', '2026-08-06 12:05:00', 'Cancelled'),

-- Flight 406
(1222, 1022, 922, '18A', 'Business', '2026-08-06 12:20:00', 'Issued'),
(1223, 1023, 923, '18B', 'Economy', '2026-08-06 12:35:00', 'Issued'),

-- Flight 407
(1224, 1024, 924, '19A', 'Economy', '2026-08-06 12:50:00', 'Issued'),
(1225, 1025, 925, '19B', 'Economy', '2026-08-06 13:05:00', 'Pending'),

-- Flight 408
(1226, 1026, 926, '20A', 'Business', '2026-08-06 13:20:00', 'Issued'),
(1227, 1027, 927, '20B', 'Economy', '2026-08-06 13:35:00', 'Issued'),

-- Flight 409
(1228, 1028, 928, '21A', 'Economy', '2026-08-06 13:50:00', 'Issued'),

-- Flight 410
(1229, 1029, 929, '22A', 'Business', '2026-08-06 14:05:00', 'Issued'),
(1230, 1030, 930, '22B', 'Economy', '2026-08-06 14:20:00', 'Issued');


INSERT INTO crew
(crewID, name, designation, phone, email, experience)
VALUES
(711, 'Akash Nair', 'Cabin Crew', '9876500011', 'akash.nair@airline.com', 4),
(712, 'Ananya Das', 'Cabin Crew', '9876500012', 'ananya.das@airline.com', 3),
(713, 'Rakesh Kumar', 'Cabin Crew', '9876500013', 'rakesh.kumar@airline.com', 5),
(714, 'Nisha George', 'Cabin Crew', '9876500014', 'nisha.george@airline.com', 6),
(715, 'Vivek Menon', 'Pilot', '9876500015', 'vivek.menon@airline.com', 14),
(716, 'Aparna Roy', 'Co-Pilot', '9876500016', 'aparna.roy@airline.com', 8),
(717, 'Hari Prasad', 'Cabin Crew', '9876500017', 'hari.prasad@airline.com', 4),
(718, 'Megha Thomas', 'Cabin Crew', '9876500018', 'megha.thomas@airline.com', 2),
(719, 'Aravind Pillai', 'Pilot', '9876500019', 'aravind.pillai@airline.com', 16),
(720, 'Sneha Menon', 'Cabin Crew', '9876500020', 'sneha.menon@airline.com', 7),

(721, 'Nithin Raj', 'Cabin Crew', '9876500021', 'nithin.raj@airline.com', 5),
(722, 'Divya Sharma', 'Cabin Crew', '9876500022', 'divya.sharma@airline.com', 4),
(723, 'Rahul Joseph', 'Co-Pilot', '9876500023', 'rahul.joseph@airline.com', 9),
(724, 'Pooja Nair', 'Cabin Crew', '9876500024', 'pooja.nair@airline.com', 3),
(725, 'Kiran Babu', 'Cabin Crew', '9876500025', 'kiran.babu@airline.com', 6),
(726, 'Reshma Ali', 'Cabin Crew', '9876500026', 'reshma.ali@airline.com', 5),
(727, 'Faiz Ahmed', 'Pilot', '9876500027', 'faiz.ahmed@airline.com', 11),
(728, 'Lakshmi Devi', 'Cabin Crew', '9876500028', 'lakshmi.devi@airline.com', 4),
(729, 'Karthik Reddy', 'Cabin Crew', '9876500029', 'karthik.reddy2@airline.com', 3),
(730, 'Anu Mathew', 'Cabin Crew', '9876500030', 'anu.mathew@airline.com', 2);

INSERT INTO crew_assignments
(assignmentID, flightID, crewID, status, updated_time)
VALUES

-- Flight 401
(811,401,711,'Assigned','2026-08-09 18:05:00'),
(812,401,712,'Assigned','2026-08-09 18:05:00'),

-- Flight 402
(813,402,713,'Assigned','2026-08-09 18:10:00'),
(814,402,714,'Assigned','2026-08-09 18:10:00'),

-- Flight 403
(815,403,715,'Assigned','2026-08-10 09:35:00'),
(816,403,716,'Assigned','2026-08-10 09:35:00'),

-- Flight 404
(817,404,717,'Assigned','2026-08-10 10:05:00'),
(818,404,718,'Assigned','2026-08-10 10:05:00'),

-- Flight 405
(819,405,719,'Assigned','2026-08-11 08:50:00'),
(820,405,720,'Assigned','2026-08-11 08:50:00'),

-- Flight 406
(821,406,721,'Assigned','2026-08-11 09:20:00'),
(822,406,722,'Assigned','2026-08-11 09:20:00'),

-- Flight 407
(823,407,723,'Assigned','2026-08-12 07:35:00'),
(824,407,724,'Assigned','2026-08-12 07:35:00'),

-- Flight 408
(825,408,725,'Assigned','2026-08-12 08:05:00'),
(826,408,726,'Assigned','2026-08-12 08:05:00'),

-- Flight 409
(827,409,727,'Assigned','2026-08-13 12:05:00'),
(828,409,728,'Assigned','2026-08-13 12:05:00'),

-- Flight 410
(829,410,729,'Assigned','2026-08-13 13:05:00'),
(830,410,730,'Assigned','2026-08-13 13:05:00');

select * from flight_schedule;

create view flight_aircraft as (select * from flights join aircraft on flights.aircraft_assigned = aircraft.aircraftID where departure_time > "12:00");

select * from flight_aircraft;

select * from flights where departure_time > "12:00";


select * from 
	flights join aircraft 
    on aircraft.aircraftID = flights.aircraft_assigned
    join airports
    on airports.code = flights.arrival_airport
    join airport_staff
    on airports.code = airport_staff.airportID
    join crew_assignments
    on flights.flightID = crew_assignments.flightID
    join crew
    on crew.crewID = crew_assignments.crewID
    join bookings
    on bookings.flightID = flights.flightID
    join passengers
    on bookings.passengerID = passengers.passengerID
    join tickets
    on bookings.bookingID = tickets.bookingID
    join baggage
    on tickets.ticketID = baggage.ticketID
where 
	flights.departure_time > "12:00";


select * from passengers 
	join bookings
    on  bookings.passengerID = passengers.passengerID
    join flights
    on flights.flightID = bookings.flightID
    join aircraft 
    on aircraft.aircraftID = flights.aircraft_assigned
    join airports
    on airports.code = flights.arrival_airport
    join airport_staff
    on airports.code = airport_staff.airportID
    join crew_assignments
    on flights.flightID = crew_assignments.flightID
    join crew
    on crew.crewID = crew_assignments.crewID
    join tickets
    on bookings.bookingID = tickets.bookingID
    join baggage
    on tickets.ticketID = baggage.ticketID
where 
	passengers.gender = "Female";
    
    
select * from payments 
	join bookings
    on bookings.bookingID = payments.bookingID
    join passengers
    on passengers.passengerID =  bookings.passengerID
	join tickets
    on bookings.bookingID = tickets.bookingID
    join baggage
    on tickets.ticketID = baggage.ticketID
where
	payments.method = "Credit Card";
    
select * from aircraft 
	join flights
    on flights.aircraft_assigned = aircraft.aircraftID
    join airports
    on airports.code = flights.arrival_airport
    join airport_staff
    on airports.code = airport_staff.airportID
    join bookings
    on bookings.flightID = flights.flightID
    join crew_assignments
    on flights.flightID = crew_assignments.flightID
    join crew
    on crew.crewID = crew_assignments.crewID
    join tickets
    on bookings.bookingID = tickets.bookingID
    join baggage
    on tickets.ticketID = baggage.ticketID
where
	manufacturer = "Boeing";
    
    

    -- 12:00> cancelled female cabin
    
    select * from 
	flights join aircraft 
    on aircraft.aircraftID = flights.aircraft_assigned
    join airports
    on airports.code = flights.arrival_airport
    join airport_staff
    on airports.code = airport_staff.airportID
    join crew_assignments
    on flights.flightID = crew_assignments.flightID
    join crew
    on crew.crewID = crew_assignments.crewID
    join bookings
    on bookings.flightID = flights.flightID
    join passengers
    on bookings.passengerID = passengers.passengerID
    join tickets
    on bookings.bookingID = tickets.bookingID
    join baggage
    on tickets.ticketID = baggage.ticketID
where 
	flights.departure_time > "12:00" and bookings.status = "Cancelled" and crew.designation = "Cabin Crew" and airport_staff.gender = "Female";



describe aircraft;

ALTER TABLE aircraft
MODIFY aircraftID INT NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT = 311;



