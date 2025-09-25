create table person (
	ssn decimal(10, 0) not null,
    fname char(100) not null,
    lname char(100) not null,
    bdate date not null,
    addr char(100) not null,
    primary key (ssn)
);

create table patient (
	ssn decimal(10, 0) not null,
    contact decimal(10, 0) not null, 
    funds int not null,
    primary key (ssn),
    foreign key (ssn) references person(ssn)
    on update restrict
    on delete cascade
);

create table staff (
	staffID int not null,
	ssn decimal(10, 0) not null,
    salary int not null,
    hireDate date not null,
    primary key (staffID),
    foreign key (ssn) references person(ssn)
    on update restrict
    on delete cascade
);

create table doctor (
	licenseNumber int not null,
    id int not null,
    experience tinyint not null,
    primary key (licenseNumber),
    foreign key (id) references staff(staffID)
    on update restrict
    on delete cascade
);

create table nurse (
	nurseID int not null,
    regExpiration date not null,
    shiftType char(100) not null,
    primary key (nurseID),
    foreign key (nurseID) references staff(staffID)
    on update restrict
    on delete cascade
);