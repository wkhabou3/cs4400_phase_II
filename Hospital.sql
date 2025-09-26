create database hospital;
use hospital;

create table person (
	ssn decimal(10, 0) not null,
    fname varchar(100) not null,
    lname varchar(100) not null,
    bdate date not null,
    addr varchar(100) not null,
    primary key (ssn)
);

create table patient (
	ssn decimal(10, 0) not null,
    contact decimal(10, 0) not null, 
    funds int not null,
    check (funds >= 0),
    primary key (ssn),
    foreign key (ssn) references person(ssn)
    on delete cascade
);

create table staff (
	staffID int not null,
	ssn decimal(10, 0) not null,
    salary int not null,
    hireDate date not null,
    check (staffID > 0 and salary >= 0),
    primary key (staffID),
    foreign key (ssn) references person(ssn)
    on delete cascade
);

create table doctor (
	licenseNumber int not null,
    id int not null,
    experience int not null,
    check (licenseNumber > 0 and id > 0 and experience >= 0),
    primary key (licenseNumber),
    foreign key (id) references staff(staffID)
    on delete cascade
);

create table nurse (
	nurseID int not null,
    regExpiration date not null,
    shiftType varchar(100) not null,
    check (nurseID > 0),
    primary key (nurseID),
    foreign key (nurseID) references staff(staffID)
    on delete cascade
);