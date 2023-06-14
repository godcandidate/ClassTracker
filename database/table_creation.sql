CREATE TABLE Programme
(
	programme_id VARCHAR(10) PRIMARY KEY NOT NULL,
	programme_name VARCHAR(30) NOT NULL
);

CREATE TABLE Student
(
	reference_id INT NOT NULL,
	index_number INT NOT NULL,
	surname VARCHAR(20) NOT NULL,
	othername VARCHAR(30) NOT NULL,
	username VARCHAR(20) NOT NULL,
	pass VARCHAR(20) NOT NULL,
	email VARCHAR(20),
	student_year SMALLINT NOT NULL,
	programme_id VARCHAR(10) REFERENCES programme(programme_id) ON DELETE CASCADE
);

CREATE TABLE Program_Year
(
	program_year_code VARCHAR(12) PRIMARY KEY NOT NULL,
	program_year SMALLINT NOT NULL,
	programme_id VARCHAR(10) REFERENCES programme(programme_id) ON DELETE CASCADE	
);

CREATE TABLE Course
(
	course_code VARCHAR(10) PRIMARY KEY NOT NULL,
	course_name VARCHAR(20) NOT NULL
);

CREATE TABLE Program_Course
(
	program_course_code SERIAL PRIMARY KEY NOT NULL,
	program_year_code VARCHAR(12) REFERENCES program_year(program_year_code) ON DELETE CASCADE,
	course_code VARCHAR(10) REFERENCES course(course_code) ON DELETE CASCADE
);

CREATE TABLE Room
(
	room_id SERIAL PRIMARY KEY,
	room_name VARCHAR(30) NOT NULL,
	room_location VARCHAR(30) NOT NULL,
	capacity VARCHAR(20) NOT NULL,
	description VARCHAR(50) NOT NULL
);

CREATE TABLE Timetable
(
	event_id SERIAL PRIMARY KEY,
	program_year_code VARCHAR(12) REFERENCES program_year(program_year_code) ON DELETE CASCADE,
	course_code VARCHAR(10) REFERENCES course(course_code) ON DELETE CASCADE,
	room_id INT REFERENCES room(room_id) ON DELETE CASCADE,
	start_time TIME NOT NULL,
	end_time TIME NOT NULL,
	event_day VARCHAR(15) NOT NULL,
	status VARCHAR(15) NOT NULL
);
