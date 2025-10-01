drop database if exists hospital;
create database hospital;
use hospital;

create table person (
	ssn decimal(9, 0) not null,
    fname varchar(100) not null,
    lname varchar(100) not null,
    bdate date,
    addr varchar(100),
    primary key (ssn)
);

create table patient (
	ssn decimal(9, 0) not null,
    contact decimal(10, 0), 
    funds int,
    check (funds >= 0),
    primary key (ssn),
    foreign key (ssn) references person(ssn)
    on delete cascade
);

create table staff (
	staffSSN decimal(9, 0) not null,
	staffID int not null,
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
	licenseNumber int,
    staffId int,
    yearsExperience int,
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
	staffId int,
    regExpiration date not null,
    shiftType varchar(100),
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
(909101111, 'Maria', 'Alvarez', '1987-03-22', '81 Peachtree Pl NE, Atlanta, GA 30309', 4045551010, 1800),
(323445555, 'Marcus', 'Lee', '1979-12-11', '1420 Oak Terrace, Decatur, GA 30030'),
(123456789, 'Christopher', 'Davis', null, null);

insert into patient (ssn, contact, funds) values 
(909101111, 4045551010, 1800),
(323445555, 4045552020, 2400),
(123456789, null, null)
