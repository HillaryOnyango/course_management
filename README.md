 Student Course Management System

** Project Overview**

This project is a Student Course Management System developed using SQL. It simulates a real-world educational platform where students enroll in courses taught by instructors. The system manages data related to students, instructors, courses, and enrollments, providing insights through various SQL queries and advanced features like views, indexes, and triggers.

**Database Schema**

The database consists of the following tables:

- Students
  - `student_id` (INT, PRIMARY KEY)
  - `first_name` (VARCHAR)
  - `last_name` (VARCHAR)
  - `email` (VARCHAR)
  - `date_of_birth` (DATE)

- Instructors
  - `instructor_id` (INT, PRIMARY KEY)
  - `first_name` (VARCHAR)
  - `last_name` (VARCHAR)
  - `email` (VARCHAR)

- Courses
  - `course_id` (INT, PRIMARY KEY)
  - `course_name` (VARCHAR)
  - `course_description` (TEXT)
  - `instructor_id` (INT, FOREIGN KEY → Instructors)

- Enrollments
  - `enrollment_id` (INT, PRIMARY KEY)
  - `student_id` (INT, FOREIGN KEY → Students)
  - `course_id` (INT, FOREIGN KEY → Courses)
  - `enrollment_date` (DATE)
  - `grade` (CHAR(1))

 Entity-Relationship Diagram (ERD)

<img width="169" alt="image" src="https://github.com/user-attachments/assets/cdbe7543-741c-42c2-a5be-4cbdb76766d2" />

 Setup Instructions

1. Clone the Repository:

   ```bash
   git clone https://github.com/yourusername/student-course-management.git
