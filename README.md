# Pewlett-Hackard-Analysis
Converting Data Storage From csv to SQL

## Project Overview
With the knowledge that many of their employees will be imminently retiring, Human Resources has asked for assistance identifying potential 
candidates for promotion through their mentorship program. Human Resources will require some additional data to make the transition as seamless as possible. We will first get the employess who are retiring and save their info to a table name ret_eligible using the following steps:
* Using the emp_info table which holds employess with a birthdate between January 1st 1952 and December 31st 1955 to return employee number, first name and last name.
* Inner join emp_info to the titles table to return the job title and date tite was assigned.
* Inner join to the salary table to get the salaries of each employee.

Now that the retiring employees and their info has been identified and saved to the table ret_eligible, we will need to remove duplicates from the table and so we can get an accurate count of employees who will be retiring in each department. This will be done by:
* Using an 'AGGREGATE BY' SQL statement on the ret_eligible table to assign row number to duplicate names and return rows equal to a single value so duplicates do not show in results.
* Use a 'GROUP BY' statement to return the results in a table showing the number of employees in each department.

Having identified the number of people retiring in each department we can now identify the individuals who are eligible for a mentorship opportunity based on a date specified by management:
* Using employee number, first name, last name, title, from date, and to date, we will identify current employees with birthdates in 1965.
* Inner join employees to titles to return title, from_date, and to_date.

## Resources
* Data Source departments.csv, dept_count.csv, dept_emp.csv, dept_manager.csv, employees.csv, retirement_info.csv, salaries.csv, title.csv
* Software: pgAdmin 4.19
* Database: PostgreSQL 11.7

## Summary

The analysis has found that pewlett hackard has 32, 859 employees who are approaching retirement age, defined as any employee with the birth date between 1952-01-01 and 1955-12-31. The distribution of these employees across departments is as follows:
* Senior Engineers - 13, 538 
* Senior Staff - 12,771
* Engineers - 2,696
* Staff - 2,012
* Technique Leader - 1,589
* Assistant Engineer - 251
* Manager - 2


