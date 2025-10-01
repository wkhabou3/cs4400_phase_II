drop database if exists hospital;
create database hospital;
use hospital;

create table person (
	ssn decimal(9, 0) not null,
    fname varchar(100) not null,
    lname varchar(100) not null,
    bdate date not null,
    addr varchar(100) not null,
    primary key (ssn)
);

create table patient (
	ssn decimal(9, 0) not null,
    contact decimal(10, 0) not null, 
    funds int not null,
    check (funds >= 0),
    primary key (ssn),
    foreign key (ssn) references person(ssn)
    on delete cascade
);

create table staff (
	staffSSN decimal(9, 0) not null,
	staffId int not null,
    salary int not null,
    hireDate date not null,
    check (staffID > 0 and salary >= 0),
    primary key (staffSSN),
    unique (staffId),
    foreign key (staffSSN) references person(ssn)
    on delete cascade
);

create table doctor (
	staffSSN decimal(9, 0) not null,
    staffId int not null,
	licenseNumber int not null,
    yearsExperience int not null,
    check (licenseNumber > 0 and staffId > 0 and yearsExperience >= 0),
    primary key (staffSSN),
    unique (licenseNumber),
    unique (staffID),
    foreign key (staffSSN) references person(ssn)
    on delete cascade,
    foreign key (staffId) references staff(staffId)
    on delete cascade
);

create table nurse (
	staffSSN decimal(9, 0) not null,
	staffId int not null,
    regExpiration date not null,
    shiftType varchar(100) not null,
    check (staffID > 0),
    primary key (staffSSN),
    unique(staffId),
    foreign key (staffSSN) references person(ssn)
    on delete cascade,
    foreign key (staffId) references staff(staffId)
    on delete cascade
);

create table appointment (
	patientID decimal(10, 0) not null,
    apptDate date not null,
    apptTime time not null,
    cost int not null,
    check (cost >= 0),
    primary key (patientID, apptDate, apptTime),
    foreign key (patientID) references patient(ssn)
    on delete cascade
);

create table symptom (
	patientID decimal(10, 0) not null,
    apptDate date not null,
    apptTime time not null,
    symptomType varchar(100) not null,
    numDays int not null,
    check (numDays >= 0),
    primary key (patientID, apptdate, appttime),
    foreign key (patientID, apptdate, appttime) references appointment(patientID, apptdate, appttime)
    on delete cascade
);

create table scheduledFor (
	doctor int not null,
    patientID decimal(10, 0) not null,
    apptDate date not null,
    apptTime time not null,
    primary key (doctor, patientID, apptdate, appttime),
    foreign key (doctor) references doctor(licenseNumber),
    foreign key (patientID, apptdate, appttime) references appointment(patientID, apptdate, appttime)
    on delete cascade
);

create table worksIn (
	staffID int not null,
    deptID int not null,
    primary key (staffID, deptID),
    foreign key (staffID) references staff(staffID),
    foreign key (deptID) references department(deptID)
    on delete cascade
);

create table assigned (
	nurseID int not null,
    rnumber int not null,
    primary key (nurseID, rnumber),
    foreign key (nurseID) references nurse(nurseID),
    foreign key (rnumber) references room(rnumber)
    on delete cascade
);

insert into person (ssn, fname, lname, bdate, addr) values
(909101111, 'Maria', 'Alvarez', '1987-03-22', '81 Peachtree Pl NE, Atlanta, GA 30309'),
(323445555, 'Marcus', 'Lee', '1979-12-11', '1420 Oak Terrace, Decatur, GA 30030'),
(123456789, 'Christopher', 'Davis', '1965-02-25', '1234 Peach Street, Atlanta, GA 30305'),
(636778888, 'Olivia', 'Bennett', '1970-01-01', '950 W Peachtree, Atlanta, GA 30308'),
(858990000, 'Chloe', 'Davis', '1975-06-24', '500 North Ave, Atlanta, GA 30302'),
(969001112, 'Liam', 'Foster', '1980-12-14', '670 Piedmont Ave, Atlanta, GA 30303'),
(212334444, 'Priya', 'Shah', '1986-06-06', '1000 Howell Mill Rd, Atlanta, GA 30303'),
(101223030, 'Emily', 'Park', '1997-05-19', '848 Spring St NW, Atlanta, GA 30308'),
(454667777, 'Omar', 'Haddad', '1980-05-01', '108 Main St, Atlanta, GA 30308'),
(888776666, 'Sarah', 'Mitchell', '1975-06-10', '742 Maple Avenue, Decatur, GA 30030'),
(135790000, 'David', 'Thompson', '1980-08-15', '925 Brookside Drive, Marietta, GA 30062'),
(204608010, 'Laura', 'Chen', '1978-04-22', '488 Willow Creek Lane, Johns Creek, GA 30097'),
(987654321, 'Matthew', 'Nguyen', '1970-03-01', '3100 Briarcliff Road, Atlanta, GA 30329'),
(300405000, 'David', 'Taylor', '1985-01-10', '124 Oakwood Circle, Smyrna, GA 30080'),
(800507676, 'Ethan', 'Brooks', '1987-07-18', '275 Pine Hollow Drive, Roswell, GA 30075'),
(103057090, 'Hannah', 'Wilson', '1990-09-25', '889 Laurel Springs Lane, Alpharetta, GA 30022');

insert into patient (ssn, contact, funds) values 
(909101111, 4045551010, 1800),
(323445555, 4045552020, 2400),
(123456789, 4703216543, 2000);

insert into staff (staffSSN, staffId, salary, hireDate) values
(636778888, 720301, 92000, '2023-02-01'),
(858990000, 720303, 93500, '2021-11-30'),
(969001112, 720304, 90500, '2020-08-20'),
(212334444, 510201, 265000, '2016-08-19'),
(323445555, 510202, 238000, '2019-09-03'),
(101223030, 510203, 312000, '2014-02-27'),
(454667777, 510204, 328000, '2012-11-05'),
(888776666, 107435, 200000, '2017-03-11'),
(135790000, 237432, 250000, '2019-02-05'),
(204608010, 902385, 300000, '2012-05-30'),
(987654321, 511283, 450000, '2010-01-01'),
(300405000, 936497, 79000, '2021-09-15'),
(800507676, 783404, 91000, '2017-11-23'),
(103057090, 416799, 85000, '2019-08-13');

insert into doctor (staffSSN, staffId, licenseNumber, yearsExperience) values
(212334444, 510201, 77231, 11),
(323445555, 510202, 88342, 7),
(101223030, 510203, 66125, 15),
(454667777, 510204, 99473, 18),
(888776666, 107435, 89012, 16),
(135790000, 237432, 23456, 8),
(204608010, 902385, 34567, 12),
(987654321, 511283, 56789, 20);

insert into nurse (staffSSN, staffId, regExpiration, shiftType) values
(636778888, 720301, '2027-01-31', 'Morning'),
(858990000, 720303, '2026-05-31', 'Night'),
(969001112, 720304, '2026-12-31', 'Afternoon'),
(300405000, 936497, '2026-06-01', 'Morning'),
(800507676, 783404, '2026-07-15', 'Afternoon'),
(103057090, 416799, '2026-05-31', 'Night');
