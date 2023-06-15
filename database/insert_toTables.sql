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

INSERT INTO program_year 
VALUES
	('BE2', 2, 'BE'),
	('BE3', 3, 'BE'),
	('COE2', 2, 'COE'),
	('COE3', 3, 'COE')

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
	
		
SELECT * FROM programme
SELECT * FROM student
SELECT * FROM program_year 
SELECT * FROM course
SELECT * FROM program_course WHERE program_year_code = 'COE2';
