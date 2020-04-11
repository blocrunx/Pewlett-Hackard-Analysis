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
FROM clean_ret_eligible
GROUP BY title; 

-- 3 get mentors
-- CHALLENGE QUERY 3: Return employee number, first and last name, title,  
-- from and to date, with birthdays in 1965 for current employees
SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
	   ti.title,
	   de.from_date,
	   de.to_date
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')