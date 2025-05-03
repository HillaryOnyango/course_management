
**Student Course Management System**

**Project Overview**

This project is dubbed  "Student Course Management System". I developed this project using PostGreSQL. This mini-project simulates a real-world educational platform where students enroll in courses taught by instructors. The system manages data related to students, instructors, courses, and enrollments, providing insights through various SQL queries and advanced features like views, indexes, and triggers.

**Database Schema**

The database consists of the following tables:

**- Students**
  - `student_id` (INT, PRIMARY KEY)
  - `first_name` (VARCHAR)
  - `last_name` (VARCHAR)
  - `email` (VARCHAR)
  - `date_of_birth` (DATE)

**- Instructors**
  - `instructor_id` (INT, PRIMARY KEY)
  - `first_name` (VARCHAR)
  - `last_name` (VARCHAR)
  - `email` (VARCHAR)

- **Courses**
  - `course_id` (INT, PRIMARY KEY)
  - `course_name` (VARCHAR)
  - `course_description` (TEXT)
  - `instructor_id` (INT, FOREIGN KEY → Instructors)

- **Enrollments**
  - `enrollment_id` (INT, PRIMARY KEY)
  - `student_id` (INT, FOREIGN KEY → Students)
  - `course_id` (INT, FOREIGN KEY → Courses)
  - `enrollment_date` (DATE)
  - `grade` (CHAR(1))

 **Entity-Relationship Diagram (ERD)**


The ERD (described textually) outlines the relationships between entities:

Students (student_id, first_name, last_name, email, date_of_birth)
One-to-Many with Enrollments via student_id.
Instructors (instructor_id, first_name, last_name, email)
One-to-Many with Courses via instructor_id.
Courses (course_id, course_name, course_description, instructor_id)
One-to-Many with Enrollments via course_id.
Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
Links Students and Courses with foreign keys.
Enrollment_Logs (log_id, enrollment_id, student_id, course_id, log_date, action)
Populated by a trigger on Enrollments inserts.

 Key point on Relationships:

A student can enroll in multiple courses (via Enrollments).
An instructor can teach multiple courses.
A course can have multiple students enrolled.
Enrollment logs track new enrollments.
1. Clone the Repository:

   ```bash
   git clone https://github.com/HillaryOnyango/course_management.git
