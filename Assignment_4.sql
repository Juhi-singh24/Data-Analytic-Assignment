                                                        Assignment - 4


Write an sql query to display the names and salaries of employees whose salary is greater than the average in the company.Explain how the subquery works.

postgres=# CREATE TABLE employees (
postgres(#     emp_id INT PRIMARY KEY,
postgres(#     emp_name VARCHAR(50),
postgres(#     department VARCHAR(50),
postgres(#     salary DECIMAL(10,2),
postgres(#     age INT
postgres(# );
CREATE TABLE
postgres=# INSERT INTO employees VALUES
postgres-# (1, 'Amit', 'IT', 50000, 25),
postgres-# (2, 'Rohit', 'HR', 35000, 28),
postgres-# (3, 'Sneha', 'IT', 60000, 30),
postgres-# (4, 'Priya', 'Finance', 45000, 27),
postgres-# (5, 'Karan', 'IT', 70000, 35),
postgres-# (6, 'Anjali', 'HR', 40000, 26),
postgres-# (7, 'Vikas', 'Finance', 52000, 32),
postgres-# (8, 'Neha', 'IT', 48000, 24),
postgres-# (9, 'Arjun', 'HR', 38000, 29),
postgres-# (10, 'Pooja', 'Finance', 55000, 31),
postgres-# (11, 'Ramesh', 'IT', 62000, 33),
postgres-# (12, 'Simran', 'HR', 36000, 27),
postgres-# (13, 'Deepak', 'Finance', 47000, 30),
postgres-# (14, 'Kavita', 'IT', 51000, 28),
postgres-# (15, 'Manish', 'HR', 39000, 26);
INSERT 0 15

postgres=# select emp_name,salary from employees where salary > (select AVG(salary) from employees);
 emp_name |  salary
----------+----------
 Amit     | 50000.00
 Sneha    | 60000.00
 Karan    | 70000.00
 Vikas    | 52000.00
 Pooja    | 55000.00
 Ramesh   | 62000.00
 Kavita   | 51000.00
(7 rows)
 
How the subquery works:
(SELECT AVG(salary) FROM employees) is a subquery.
It first calculates the average salary of all employees.
The outer query then compares each employee’s salary with that average.
Only employees earning more than average are displayed.


Q2.Write a query to retrive the top 5 highest paid employees from an employees table.Explain how sorting affect the output.


postgres=# select emp_name,salary from employees order by salary desc limit 5;
 emp_name |  salary
----------+----------
 Karan    | 70000.00
 Ramesh   | 62000.00
 Sneha    | 60000.00
 Pooja    | 55000.00
 Vikas    | 52000.00
(5 rows)

How sorting affects output:
-ORDER BY salary DESC sorts salaries from highest to lowest.
-LIMIT 5 picks the first 5 records after sorting.
-Without sorting, LIMIT 5 would just return random first 5 rows from table


Q3.Write a query to calculate
Total no of employees
Average salary
Minimum and maximum salary
Explain the difference between aggregate and scalar functions.

postgres=# select count(*) as total_employees from employees;
 total_employees
---
              15
(1 row)


postgres=# select AVG(salary) as Average_salary from employees;
   average_salary
---
 48533.333333333333
(1 row)


postgres=# select min(salary) as Minimum_salary,max(salary) as Maximum_salary from employees;
 minimum_salary | maximum_salary
----------------+----------------
       35000.00 |       70000.00
(1 row)

Aggregate Functions:-
Work on multiple rows
Return one result
Example: COUNT(), AVG(), SUM()

Scalar Functions:-
Work on single value
Return one result per row
Example: UPPER(), LOWER(), LENGTH()


Q4. Give a sales table with columns (region,amount) write a query to find out total sales per region .
Filter only those regions where total sales exceed 50,000.

postgres=# CREATE TABLE sales (
postgres(#     sale_id INT PRIMARY KEY,
postgres(#     salesperson VARCHAR(50),
postgres(#     product VARCHAR(50),
postgres(#     region VARCHAR(50),
postgres(#     amount DECIMAL(10,2),
postgres(#     sale_date DATE
postgres(# );
CREATE TABLE
postgres=# INSERT INTO sales VALUES
postgres-# (1, 'Rahul', 'Laptop', 'North', 30000, '2026-02-01'),
postgres-# (2, 'Rahul', 'Mobile', 'North', 25000, '2026-02-02'),
postgres-# (3, 'Priya', 'Tablet', 'South', 20000, '2026-02-03'),
postgres-# (4, 'Aman', 'Laptop', 'East', 60000, '2026-02-04'),
postgres-# (5, 'Sneha', 'Mobile', 'West', 30000, '2026-02-05'),
postgres-# (6, 'Sneha', 'Tablet', 'West', 25000, '2026-02-06'),
postgres-# (7, 'Karan', 'Laptop', 'South', 15000, '2026-02-07'),
postgres-# (8, 'Juhi', 'Headphone', 'North', 10000, '2026-02-08');
INSERT 0 8
postgres=# select region,sum(amount) from sales group by region having sum(amount) > 50000;
 region |   sum
--------+----------
 East   | 60000.00
 West   | 55000.00
 North  | 65000.00
(3 rows)



Q5. Write a query to find the number of unique job roles in an employees table.Explain why DISTINCT is necessary here.

postgres=# select count(distinct department) as unique_roles from employees;
 unique_roles
---
            3
(1 row)
 
DISTINCT is needed because:-

If multiple employees have same job role, it would count repeatedly.

DISTINCT ensures each role is counted only once.



Q6. Write a query to retrive students who scored betweeen 60 and 80 marks.Rewrite it using query BETWEEEN.

postgres=# CREATE TABLE students (
postgres(#     student_id SERIAL PRIMARY KEY,
postgres(#     first_name VARCHAR(50) NOT NULL,
postgres(#     last_name VARCHAR(50),
postgres(#     gender VARCHAR(10),
postgres(#     date_of_birth DATE,
postgres(#     email VARCHAR(100) UNIQUE,
postgres(#     phone VARCHAR(15),
postgres(#     course VARCHAR(100),
postgres(#     marks INTEGER CHECK (marks >= 0 AND marks <= 100),
postgres(#     admission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
postgres(# );
CREATE TABLE
postgres=# INSERT INTO students
postgres-# (first_name, last_name, gender, date_of_birth, email, phone, course, marks)
postgres-# VALUES
postgres-# ('Ritik', 'Kumawat', 'Male', '2002-05-14', 'ritik@gmail.com', '9876543210', 'BCA', 85),
postgres-#
postgres-# ('Anjali', 'Sharma', 'Female', '2003-08-21', 'anjali@gmail.com', '9876501234', 'BBA', 78),
postgres-#
postgres-# ('Rahul', 'Verma', 'Male', '2001-11-10', 'rahul@gmail.com', '9123456780', 'B.Tech', 92),
postgres-#
postgres-# ('Priya', 'Singh', 'Female', '2002-02-18', 'priya@gmail.com', '9988776655', 'BSc', 88),
postgres-#
postgres-# ('Amit', 'Meena', 'Male', '2003-06-30', 'amit@gmail.com', '9012345678', 'BCom', 74),
postgres-#
postgres-# ('Neha', 'Gupta', 'Female', '2001-09-12', 'neha@gmail.com', '9090909090', 'MBA', 81),
postgres-#
postgres-# ('Karan', 'Yadav', 'Male', '2002-12-05', 'karan@gmail.com', '9871234567', 'BCA', 69),
postgres-#
postgres-# ('Pooja', 'Joshi', 'Female', '2003-04-22', 'pooja@gmail.com', '9567890123', 'B.Tech', 95),
postgres-#
postgres-# ('Suresh', 'Choudhary', 'Male', '2000-07-19', 'suresh@gmail.com', '9874563210', 'MCA', 84),
postgres-#
postgres-# ('Komal', 'Jain', 'Female', '2002-10-03', 'komal@gmail.com', '9786543210', 'BBA', 90);
INSERT 0 10
postgres=# select * from students where marks>=60 and marks<=80;
 student_id | first_name | last_name | gender | date_of_birth |      email       |   phone    | course | marks |       admission_date
------------+------------+-----------+--------+---------------+------------------+------------+--------+-------+----------------------------
          2 | Anjali     | Sharma    | Female | 2003-08-21    | anjali@gmail.com | 9876501234 | BBA    |    78 | 2026-02-23 21:56:53.136885
          5 | Amit       | Meena     | Male   | 2003-06-30    | amit@gmail.com   | 9012345678 | BCom   |    74 | 2026-02-23 21:56:53.136885
          7 | Karan      | Yadav     | Male   | 2002-12-05    | karan@gmail.com  | 9871234567 | BCA    |    69 | 2026-02-23 21:56:53.136885
(3 rows)


postgres=# select * from students where marks between 60 and 80;
 student_id | first_name | last_name | gender | date_of_birth |      email       |   phone    | course | marks |       admission_date
------------+------------+-----------+--------+---------------+------------------+------------+--------+-------+----------------------------
          2 | Anjali     | Sharma    | Female | 2003-08-21    | anjali@gmail.com | 9876501234 | BBA    |    78 | 2026-02-23 21:56:53.136885
          5 | Amit       | Meena     | Male   | 2003-06-30    | amit@gmail.com   | 9012345678 | BCom   |    74 | 2026-02-23 21:56:53.136885
          7 | Karan      | Yadav     | Male   | 2002-12-05    | karan@gmail.com  | 9871234567 | BCA    |    69 | 2026-02-23 21:56:53.136885
(3 rows)
 


Q7. Write a query to to display employees whose commission is NULL .Explain the correct way to check NULL values in SQL.

postgres=# select * from employees;
 emp_id | emp_name | department |  salary  | age
--------+----------+------------+----------+-----
      1 | Amit     | IT         | 50000.00 |  25
      2 | Rohit    | HR         | 35000.00 |  28
      3 | Sneha    | IT         | 60000.00 |  30
      4 | Priya    | Finance    | 45000.00 |  27
      5 | Karan    | IT         | 70000.00 |  35
      6 | Anjali   | HR         | 40000.00 |  26
      7 | Vikas    | Finance    | 52000.00 |  32
      8 | Neha     | IT         | 48000.00 |  24
      9 | Arjun    | HR         | 38000.00 |  29
     10 | Pooja    | Finance    | 55000.00 |  31
     11 | Ramesh   | IT         | 62000.00 |  33
     12 | Simran   | HR         | 36000.00 |  27
     13 | Deepak   | Finance    | 47000.00 |  30
     14 | Kavita   | IT         | 51000.00 |  28
     15 | Manish   | HR         | 39000.00 |  26
(15 rows)


postgres=# Alter table employees add column commission INTEGER;
ALTER TABLE
postgres=# select * from employees;
 emp_id | emp_name | department |  salary  | age | commission
--------+----------+------------+----------+-----+------------
      1 | Amit     | IT         | 50000.00 |  25 |
      2 | Rohit    | HR         | 35000.00 |  28 |
      3 | Sneha    | IT         | 60000.00 |  30 |
      4 | Priya    | Finance    | 45000.00 |  27 |
      5 | Karan    | IT         | 70000.00 |  35 |
      6 | Anjali   | HR         | 40000.00 |  26 |
      7 | Vikas    | Finance    | 52000.00 |  32 |
      8 | Neha     | IT         | 48000.00 |  24 |
      9 | Arjun    | HR         | 38000.00 |  29 |
     10 | Pooja    | Finance    | 55000.00 |  31 |
     11 | Ramesh   | IT         | 62000.00 |  33 |
     12 | Simran   | HR         | 36000.00 |  27 |
     13 | Deepak   | Finance    | 47000.00 |  30 |
     14 | Kavita   | IT         | 51000.00 |  28 |
     15 | Manish   | HR         | 39000.00 |  26 |
(15 rows)

postgres=# update employees set commission=120 where emp_id=1;
UPDATE 1
postgres=# update employees set commission=NULL where emp_id=2;
UPDATE 1
postgres=# update employees set commission=NULL where emp_id=3;
UPDATE 1
postgres=# update employees set commission=222 where emp_id=4;
UPDATE 1
postgres=# update employees set commission=282 where emp_id=5;
UPDATE 1
postgres=# update employees set commission=345 where emp_id=6;
UPDATE 1
postgres=# update employees set commission=385 where emp_id=7;
UPDATE 1
postgres=# update employees set commission=324 where emp_id=8;
UPDATE 1
postgres=# update employees set commission=245 where emp_id=9;
UPDATE 1
postgres=# update employees set commission=295 where emp_id=10;
UPDATE 1
postgres=# update employees set commission=NULL where emp_id=11;
UPDATE 1
postgres=# update employees set commission=NULL where emp_id=12;
UPDATE 1
postgres=# update employees set commission=NULL where emp_id=13;
UPDATE 1
postgres=# update employees set commission=NULL where emp_id=14;
UPDATE 1
postgres=# update employees set commission=NULL where emp_id=15;
UPDATE 1
postgres=# select * from employees;
 emp_id | emp_name | department |  salary  | age | commission
--------+----------+------------+----------+-----+------------
      1 | Amit     | IT         | 50000.00 |  25 |        120
      2 | Rohit    | HR         | 35000.00 |  28 |
      3 | Sneha    | IT         | 60000.00 |  30 |
      4 | Priya    | Finance    | 45000.00 |  27 |        222
      5 | Karan    | IT         | 70000.00 |  35 |        282
      6 | Anjali   | HR         | 40000.00 |  26 |        345
      7 | Vikas    | Finance    | 52000.00 |  32 |        385
      8 | Neha     | IT         | 48000.00 |  24 |        324
      9 | Arjun    | HR         | 38000.00 |  29 |        245
     10 | Pooja    | Finance    | 55000.00 |  31 |        295
     11 | Ramesh   | IT         | 62000.00 |  33 |
     12 | Simran   | HR         | 36000.00 |  27 |
     13 | Deepak   | Finance    | 47000.00 |  30 |
     14 | Kavita   | IT         | 51000.00 |  28 |
     15 | Manish   | HR         | 39000.00 |  26 |
(15 rows)


postgres=# select * from employees where commission IS NULL;
 emp_id | emp_name | department |  salary  | age | commission
--------+----------+------------+----------+-----+------------
      2 | Rohit    | HR         | 35000.00 |  28 |
      3 | Sneha    | IT         | 60000.00 |  30 |
     11 | Ramesh   | IT         | 62000.00 |  33 |
     12 | Simran   | HR         | 36000.00 |  27 |
     13 | Deepak   | Finance    | 47000.00 |  30 |
     14 | Kavita   | IT         | 51000.00 |  28 |
     15 | Manish   | HR         | 39000.00 |  26 |
(7 rows)



Q8. Write a query to increase the salary of the employees in the 'IT' department by 10%.Explain how arithmetic operation are handled in SQL.

postgres=# select * from employees;
 emp_id | emp_name | department |  salary  | age | commission
--------+----------+------------+----------+-----+------------
      2 | Rohit    | HR         | 35000.00 |  28 |
      4 | Priya    | Finance    | 45000.00 |  27 |        222
      6 | Anjali   | HR         | 40000.00 |  26 |        345
      7 | Vikas    | Finance    | 52000.00 |  32 |        385
      9 | Arjun    | HR         | 38000.00 |  29 |        245
     10 | Pooja    | Finance    | 55000.00 |  31 |        295
     12 | Simran   | HR         | 36000.00 |  27 |
     13 | Deepak   | Finance    | 47000.00 |  30 |
     15 | Manish   | HR         | 39000.00 |  26 |
      1 | Amit     | IT         | 50000.00 |  25 |        120
      3 | Sneha    | IT         | 60000.00 |  30 |
      5 | Karan    | IT         | 70000.00 |  35 |        282
      8 | Neha     | IT         | 48000.00 |  24 |        324
     11 | Ramesh   | IT         | 62000.00 |  33 |
     14 | Kavita   | IT         | 51000.00 |  28 |
(15 rows)


postgres=# update employees set salary = salary + (salary * 0.10) where department = 'IT';
UPDATE 6
postgres=# select * from employees;
 emp_id | emp_name | department |  salary  | age | commission
--------+----------+------------+----------+-----+------------
      2 | Rohit    | HR         | 35000.00 |  28 |
      4 | Priya    | Finance    | 45000.00 |  27 |        222
      6 | Anjali   | HR         | 40000.00 |  26 |        345
      7 | Vikas    | Finance    | 52000.00 |  32 |        385
      9 | Arjun    | HR         | 38000.00 |  29 |        245
     10 | Pooja    | Finance    | 55000.00 |  31 |        295
     12 | Simran   | HR         | 36000.00 |  27 |
     13 | Deepak   | Finance    | 47000.00 |  30 |
     15 | Manish   | HR         | 39000.00 |  26 |
      1 | Amit     | IT         | 55000.00 |  25 |        120
      3 | Sneha    | IT         | 66000.00 |  30 |
      5 | Karan    | IT         | 77000.00 |  35 |        282
      8 | Neha     | IT         | 52800.00 |  24 |        324
     11 | Ramesh   | IT         | 68200.00 |  33 |
     14 | Kavita   | IT         | 56100.00 |  28 |
(15 rows)

Arithmetic in SQL:

+ addition

- subtraction

* multiplication

/ division

SQL performs calculations row by row.



Q9. Write a query to delete record of students who scored less than 40 marks. What precaution should taken before executing delete.

There is not any student whose marks less than 40 so it returns 0 rows.

postgres=# select * from students where marks < 40;
 student_id | first_name | last_name | gender | date_of_birth | email | phone | course | marks | admission_date
------------+------------+-----------+--------+---------------+-------+-------+--------+-------+----------------
(0 rows)


postgres=# delete from students where marks < 40;
DELETE 0

That's why it delete 0 rows

Precautions before delete:-
1. Always run SELECT first
2. Check how many rows will be affected 
3. Use WHERE clause
4. Take backup (if important table)


Q10. Write a query to find employees who earn more than the average salary of their department (without using joins).Explain the logic of the subquery.


postgres=# select * from employees;
 emp_id | emp_name | department |  salary  | age | commission
--------+----------+------------+----------+-----+------------
      2 | Rohit    | HR         | 35000.00 |  28 |
      4 | Priya    | Finance    | 45000.00 |  27 |        222
      6 | Anjali   | HR         | 40000.00 |  26 |        345
      7 | Vikas    | Finance    | 52000.00 |  32 |        385
      9 | Arjun    | HR         | 38000.00 |  29 |        245
     10 | Pooja    | Finance    | 55000.00 |  31 |        295
     12 | Simran   | HR         | 36000.00 |  27 |
     13 | Deepak   | Finance    | 47000.00 |  30 |
     15 | Manish   | HR         | 39000.00 |  26 |
      1 | Amit     | IT         | 55000.00 |  25 |        120
      3 | Sneha    | IT         | 66000.00 |  30 |
      5 | Karan    | IT         | 77000.00 |  35 |        282
      8 | Neha     | IT         | 52800.00 |  24 |        324
     11 | Ramesh   | IT         | 68200.00 |  33 |
     14 | Kavita   | IT         | 56100.00 |  28 |
(15 rows)


postgres=# select * from employees as e where salary > (select AVG(salary) from employees where department = e.department);
 emp_id | emp_name | department |  salary  | age | commission
--------+----------+------------+----------+-----+------------
      6 | Anjali   | HR         | 40000.00 |  26 |        345
      7 | Vikas    | Finance    | 52000.00 |  32 |        385
      9 | Arjun    | HR         | 38000.00 |  29 |        245
     10 | Pooja    | Finance    | 55000.00 |  31 |        295
     15 | Manish   | HR         | 39000.00 |  26 |
      3 | Sneha    | IT         | 66000.00 |  30 |
      5 | Karan    | IT         | 77000.00 |  35 |        282
     11 | Ramesh   | IT         | 68200.00 |  33 |
(8 rows)

1.Outer Query
SELECT * FROM employees e

This selects each employee one by one.
The alias e represents the current employee row.

2.Subquery
SELECT AVG(salary) from employees where department=e.department 
This calculate the average salary of the current employ.

That means-
- If outer employee is from IT → subquery calculates IT average

- If outer employee is from HR → subquery calculates HR average

- If outer employee is from Finance → subquery calculates Finance average

So the subquery runs again for each employee.