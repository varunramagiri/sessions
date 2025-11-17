use sakila;
-- Returns current date and time
SELECT NOW();

-- Returns today's date only
SELECT CURDATE();

-- Returns current time only
SELECT CURTIME();

-- Adds 7 days to a date
SELECT DATE_ADD('2024-01-01', INTERVAL 7 DAY);

-- Subtracts 30 days from a date
SELECT DATE_SUB('2024-01-01', INTERVAL 30 DAY);

-- Number of days between two dates
SELECT DATEDIFF('2024-12-31', '2024-01-01');

-- Extract year from date
SELECT YEAR('2024-10-15');

-- Extract month from date
SELECT MONTH('2024-10-15');

-- Extract day from date
SELECT DAY('2024-10-15');

-- Returns weekday name
SELECT DAYNAME('2024-10-15');

-------------------------------------------------------
-- CONDITIONAL FUNCTIONS
-------------------------------------------------------

-- Returns Adult/Minor based on condition
SELECT name, age, IF(age > 18, 'Adult', 'Minor') AS age_group FROM students;

