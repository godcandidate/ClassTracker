-- CREATING THE USER TABLE
CREATE TABLE Users
(
    userid serial primary key,
    username varchar(15) not null,
    pass varchar(20) not null,
    ranking varchar(10) not null
);
