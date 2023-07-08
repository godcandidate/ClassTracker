-- user logged in with username='FE' and password='Evelyn3'
	-- retrieving user details
SELECT * FROM student WHERE username='FE' and pass='Evelyn3';
SELECT othername,surname FROM student WHERE username='FE' and pass='Evelyn3';

-- from user details

	-- programme id - COE
	SELECT programme_id FROM student WHERE username='FE' and pass='Evelyn3';
	
	-- programme name - Computer Engineering
	SELECT programme_name FROM programme WHERE programme_id = 'COE';
	
	-- year - 3
	SELECT student_year FROM student WHERE username='FE' and pass='Evelyn3';
	
	-- programme year - COE3
	SELECT program_year_code FROM program_year WHERE program_year = 3 and 
	programme_id = 'COE';
	
	-- courses
	SELECT * FROM program_course WHERE program_year_code = 'COE3';
	
	-- timetable
	SELECT * FROM timetable WHERE  program_year_code = 'COE3';
	
	-- thursday's timetable
	SELECT * FROM timetable WHERE  program_year_code = 'COE3' and 
	event_day = 'Thursday';
	
	-- class status for monday 
	SELECT * FROM timetable WHERE  program_year_code = 'COE3' and 
	event_day = 'Monday' and status = 'pending';
	
	-- an empty classes for friday at 8am
	SELECT * FROM timetable WHERE start_time != TIME '8:00:00' and
	event_day = 'Friday';
