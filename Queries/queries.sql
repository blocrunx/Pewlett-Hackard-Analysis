-- SQL PH Employee Queries


-- Get folks name born between 1952-1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Get folks name born in 1952
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Get folks name born in 1953
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- Get folks name born in 1954
SELECT first_name, last_name 
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31'

-- Get folks name born in 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Get folks name born between 1952-1955 and hired between 1985-1988
SELECT first_name, last_name 
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Get the number of results returned
SELECT COUNT (first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Make a new table with results from query
SELECT first_name, last_name 
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Show the new table
SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Creating a new retirement_info table with emp_no included
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND hire_date BETWEEN '1985-01-01' AND '1988-12-31';
SELECT * FROM retirement_info;

-- Join retirement_info and dept_emp
SELECT retirement_info.emp_no, 
       retirement_info.first_name, 
	   retirement_info.last_name, 
	   dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;


SELECT ri.emp_no, 
       ri.first_name, 
	   ri.last_name, 
	   de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
on ri.emp_no = de.emp_no

SELECT d.dept_name, 
	   dm.emp_no, 
	   dm.from_date, 
	   dm.to_date
FROM departments AS d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no

SELECT ri.emp_no,
       ri.first_name,
	   ri.last_name,
	   de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01';
SELECT * FROM current_emp;
DROP TABLE current_emp CASCADE;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO dept_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM dept_count;

-- Creating a new retirement_info table with emp_no included
SELECT emp_no, 
       first_name, 
       last_name, 
       gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND hire_date BETWEEN '1985-01-01' AND '1988-12-31';

SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
	   e.gender,
	   s.salary,
	   de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

SELECT * FROM emp_info;

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
INNER JOIN departments AS d
ON (dm.dept_no = d.dept_no)
INNER JOIN current_emp AS ce
ON (dm.emp_no = ce.emp_no);

-- Get emp_names, emp_no and department
SELECT ce.emp_no,
	   ce.first_name,
	   ce.last_name,
       d.dept_name	
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- Get f-name, l_name, emp_no and department name for all sales associates
SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
       d.dept_name	
FROM employees as e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE de.dept_no = 'd007';

-- Get f-name, l_name, emp_no and department name for all 
-- sales and development departments
SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
       d.dept_name	
FROM employees as e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE de.dept_no IN ('d007', 'd005')
ORDER BY last_name;

-- CHALLENGE QUERY 1 - inner employee, titels, salaries
-- returning emp_no, first_name, last_name, title, salary
SELECT ei.emp_no,
	   ei.first_name,
	   ei.last_name,
	   ti.title,
	   ti.from_date,
	   s.salary
INTO ret_eligible
FROM emp_info AS ei
INNER JOIN titles AS ti
ON (ei.emp_no = ti.emp_no)
INNER JOIN salaries AS s
ON (ei.emp_no = s.emp_no);

-- Return and create table with count of department type and date ordered by decending:
ALTER TABLE ret_eligible ADD id SERIAL;
SELECT id, emp_no, first_name, last_name, title, from_date, salary 
INTO clean_ret_eligible
FROM (SELECT id, emp_no, first_name, last_name, title, from_date, salary,
ROW_NUMBER() OVER 
(PARTITION BY (first_name, last_name) ORDER BY from_date DESC) rn
FROM ret_eligible) tmp WHERE rn = 1;

-- Show the number of employees from each department
SELECT title, 
	   count(*)
INTO title_count
FROM clean_ret_eligible
GROUP BY title; 

-- 3 get mentors
-- CHALLENGE QUERY 3: Return employee number, first and last name, title,  
-- from and to date, with birthdays in 1965 for current employees
SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
	   ti.title,
	   ti.from_date,
	   ti.to_date
INTO mentor_eligible
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (ti.to_date = '9999-01-01');


-- Show the count of employees eligible for mentorship program and save the table
SELECT count(*) as eligible_employees
INTO mentor_eligible_count
FROM mentor_eligible;