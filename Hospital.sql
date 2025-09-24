create table person (
	ssn decimal(10, 0) not null,
    fname char not null,
    lname char not null,
    bdate decimal(8, 0) not null,
    addr char not null,
    primary key (ssn)
);

create table patient (
	ssn decimal(10, 0) not null,
    contact decimal(10, 0) not null, 
    funds int not null,
    primary key (ssn),
    foreign key (ssn) references person(ssn)
);

create table staff (
	staffID int not null,
	ssn decimal(10, 0) not null,
    salary int not null,
    hireDate decimal(8, 0) not null,
    primary key (staffID),
    foreign key (ssn) references person(ssn)
);

create table doctor (
	licenseNumber int not null,
    id int not null,
    experience int not null,
    primary key (licenseNumber),
    foreign key (id) references staff(staffID)
);

create table nurse (
	nurseID int not null,
    regExpiration decimal(8, 0) not null,
    shiftType char not null,
    primary key (nurseID),
    foreign key (nurseID) references staff(staffID)
);