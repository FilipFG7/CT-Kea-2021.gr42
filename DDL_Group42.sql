-- create database
DROP DATABASE IF EXISTS module4;
CREATE DATABASE module4;

-- select database
USE module4;

-- create tables for database
CREATE TABLE Users
(
UserID int PRIMARY KEY,
FirstName Varchar(30),
lastName varchar(30),
Country varchar(63),
Email varchar(30),
PhoneNumber int 
);

CREATE TABLE Quiz
(
UserID int,
Question_number int,
Question_outcome varchar(5),
Question_field varchar(50),
Question_points int,
CONSTRAINT Quiz_fk_Users
FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Quiz_Results
(
UserID int,
QuizID int auto_increment not null,
Creative_points int,
Development_points int,
DM_points int,
PRIMARY KEY (QuizID),
CONSTRAINT Quiz_Results_fk_Users
FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Course
(
UserID int,
QuizID int,
Suggested_course varchar(50),
CourseID int auto_increment not null,
PRIMARY KEY (CourseID),
CONSTRAINT Course_fk_Users
FOREIGN KEY (UserID) REFERENCES Users(UserID),
CONSTRAINT Course_fk_Quiz_Results
FOREIGN KEY (QuizID) REFERENCES Quiz_Results(QuizID)
);