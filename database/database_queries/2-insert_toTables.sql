-- Programme
INSERT INTO programme VALUES
('COE', 'Computer Engineering'),
('BE', 'Biomedical Engineering')

--Students
INSERT INTO student (reference_id, index_number, surname, othername, username, pass, email, student_year, programme_id)
VALUES
  (20722612, 3034971, 'Righy', 'John', 'JR', 'John1', 'john@gmail.com', 3, 'COE'),
  (20726996, 3034079, 'Maciocia', 'Isabella', 'MI', 'Isabella2', 'isabella@gmail.com', 3, 'COE'),
  (20725468, 3034879, 'Fines', 'Evelyn', 'FE', 'Evelyn3', 'evelyn@gmail.com', 3, 'COE'),
  (20729487, 3034245, 'Skate', 'Emma', 'SE', 'Emma4', 'emma@gmail..com', 3, 'BE'),
  (20727468, 3034314, 'Allridge', 'Evelyn', 'AE', 'Evelyn5', 'evelyn@gmail.com', 2, 'COE'),
  (20725977, 3034339, 'Rikel', 'Evelyn', 'RE', 'Evelyn6', 'evelyn@gmail.com', 3, 'BE'),
  (20726847, 3034432, 'Embury', 'Ethan', 'EE', 'Ethan7', 'ethan@gmail.com', 2, 'COE'),
  (20720071, 3034075, 'Rhubottom', 'James', 'JR', 'James8', 'james@gmail.com', 2, 'BE'),
  (20727932, 3034992, 'Kytter', 'Sophia', 'KS', 'Sophia9', 'sophia@gmail.com', 3, 'COE'),
  (20721999, 3034922, 'Ziems', 'Evelyn', 'ZE', 'Evelyn0', 'evelyn@gmail.com', 3, 'COE')

--Program year
INSERT INTO program_year 
VALUES
	('BE2', 2, 'BE'),
	('BE3', 3, 'BE'),
	('COE2', 2, 'COE'),
	('COE3', 3, 'COE')

-- Courses
INSERT INTO course 
VALUES
	('COE252', 'DATA STRUCTURES AND ALOGRITHM' ),
	('TE262','ELECTROMAGNETIC FIELDS' ),
	('COE272', 'DIGITAL SYSTEM DESIGN I' ),
	('BE251', 'MOLECULAR BIOLOGY' ),
	('BE201', 'ASRTOPHYSICS' ),
	('COE358', 'EMBEDDED SYSTEMS' ),
	('COE354', 'OPERATING SYSTEMS'),
	('COE368', 'DATABASE RETRIEVAL'),
	('BE342', 'BIOCHEMISTRY' ),
	('BE378', 'QUANTUM COMPUTING' )

-- Program year courses
INSERT INTO program_course (program_year_code, course_code) 
VALUES 
	('COE2', 'COE252'),
	('COE2', 'COE272'),
	('COE2', 'TE262'),
	('BE2', 'BE201'),
	('BE2', 'BE251'),
	('BE2', 'TE262'),
	('COE3', 'COE358'),
	('COE3', 'COE354'),
	('COE3', 'COE368'),
	('BE3', 'COE358'),
	('BE3', 'BE342'),
	('BE3', 'BE378')

-- Rooms
INSERT INTO room (room_name, room_location, capacity, description)
VALUES ('PB001', 'Petroleum Building', 'MAX 300 Students', 'Two functional TVS and a projector'),
	('A110', 'Ceasar Building', 'MAX 200 Students', 'One projector'),
	('VLSA', 'Levive Building', 'MAX 250 Students', 'Three functional TVS and a projector'),
	('PB012', 'Petroleum Building', 'MAX 150 Students', 'One projector'),
	('PB014', 'Petroleum Building', 'MAX 300 Students', 'Two functional TVS and a projector'),
	('PB201', 'Petroleum Building', 'MAX 400 Students', 'Two functional TVS and a projector')

--Timetable
INSERT INTO timetable(program_year_code,event_day,course_code,room_name,start_time,end_time,status)
VALUES ('COE2','Monday','COE252','PB001', TIME '8:00:00', TIME '9:55:00', 'pending'),
		('COE2','Monday','COE272','A110', TIME '3:00:00', TIME '4:55:00', 'pending'),
		('COE3','Monday','COE354','VLSA', TIME '1:00:00', TIME '2:55:00', 'pending'),
		('BE3','Monday','COE354','PB001', TIME '10:30:00', TIME '12:25:00', 'pending'),
		('BE2','Tuesday','TE262','PB014', TIME '8:00:00', TIME '8:55:00', 'pending'),
		('BE2','Tuesday','BE251','PB012', TIME '1:00:00', TIME '2:55:00', 'pending'),
		('BE3','Tuesday','COE358','VLSA', TIME '8:00:00', TIME '9:55:00', 'pending'),
		('COE2','Wednesday','COE272','PB012', TIME '8:00:00', TIME '9:55:00', 'pending'),
		('COE3','Wednesday','COE358','PB001', TIME '8:00:00', TIME '9:55:00', 'pending'),
		('BE2','Wednesday','BE251','VLSA', TIME '8:00:00', TIME '9:55:00', 'pending'),
		('COE3','Thursday','COE368','VLSA', TIME '1:00:00', TIME '2:55:00', 'pending'),
		('BE3','Thursday','BE342','VLSA', TIME '10:30:00', TIME '12:25:00', 'pending'),
		('COE3','Thursday','COE354','A110', TIME '8:00:00', TIME '9:55:00', 'pending'),
		('BE2','Friday','BE251','A110', TIME '1:00:00', TIME '2:55:00', 'pending'),
		('BE3','Friday','TE262','PB201', TIME '1:00:00', TIME '2:55:00', 'pending'),
		('COE2','Friday','COE272','PB201', TIME '3:00:00', TIME '4:55:00', 'pending')	
