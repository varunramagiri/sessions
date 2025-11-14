-- Create database and select it
CREATE DATABASE class2_demo;
USE class2_demo;

-- Students table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age > 0),
    email VARCHAR(100) UNIQUE,
    status VARCHAR(10) DEFAULT 'active'
);

-- Insert sample students
INSERT INTO students (name, age, email) VALUES
('Komal', 24, 'komal@example.com'),
('Aditi', 23, 'aditi@gmail.com');

-- View students
SELECT * FROM students;

-- Courses table
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL
);

-- Enrollments table with foreign keys
CREATE TABLE enrollments (
    enroll_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert sample courses
INSERT INTO courses (course_name) VALUES
('SQL Basics'), ('Data Engineering');

-- Insert enrollments
INSERT INTO enrollments (student_id, course_id) VALUES
(1, 1), (1, 2);

-- Safe delete check
SELECT * FROM students WHERE student_id = 1;

-- Delete student
DELETE FROM students WHERE student_id = 1;

-- Add cascade delete
ALTER TABLE enrollments
ADD CONSTRAINT fk_student
FOREIGN KEY (student_id) REFERENCES students(student_id)
ON DELETE CASCADE;
