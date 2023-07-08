--Number of Students
SELECT COUNT(*) AS "Total Number Students" FROM student

--Names of Students
SELECT username,pass FROM student

--All students in year 2
SELECT * FROM student WHERE student_year=2;

--All biomedical engineering students in year 3
	-- get the id for biomedical engineering
SELECT * FROM programme WHERE programme_name = 'Biomedical Engineering';

	-- then 
SELECT * FROM student WHERE student_year=3 and programme_id = 'BE';


--All courses in year 2
	-- get the id pattern for year 2
SELECT * FROM program_year WHERE program_year = 2;

	-- then
SELECT * FROM program_course WHERE program_year_code LIKE '%2';


-- All courses in year 3 for computer engineering
	-- get id for computer engineering
SELECT * FROM programme WHERE programme_name = 'Computer Engineering';

	-- get id for computer engineering year 3
SELECT * FROM program_year WHERE program_year = 3 and programme_id = 'COE';

	--then
SELECT * FROM program_course WHERE program_year_code = 'COE3';


-- Rooms in the Petroleumn Building
SELECT * FROM room WHERE room_location = 'Petroleum Building';

--Rooms with capacity of 200 or 300 students
SELECT * FROM room WHERE capacity LIKE '%200%' OR capacity LIKE '%300%';

--Timetable for Monday
SELECT * FROM timetable WHERE event_day = 'Monday';

--Timetable for all second years
	-- id pattern for second years is %2 - [COE2, BE2]
SELECT * FROM timetable WHERE program_year_code LIKE '%2';

--Timetable for computer engineering students on Monday
	-- id pattern for computer engineer COE% - [COE2, COE3]
SELECT * FROM timetable WHERE event_day = 'Monday' and program_year_code LIKE 'COE%';

-- Timetable for computer engineering 3 on Thursday
	-- id for computer engineer COE3
SELECT * FROM timetable WHERE event_day = 'Thursday' and program_year_code = 'COE3';

-- Timetable for computer engineering 2 8am classes in the week
	-- id for computer engineer COE2
SELECT * FROM timetable WHERE start_time = TIME '8:00:00' and program_year_code = 'COE2';
