create database hospital;
use hospital;

create table person (
	ssn decimal(10, 0) not null,
    fname varchar(100) not null,
    lname varchar(100) not null,
    bdate date,
    addr varchar(100),
    primary key (ssn)
);

create table patient (
	ssn decimal(10, 0) not null,
    contact decimal(10, 0), 
    funds int,
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
