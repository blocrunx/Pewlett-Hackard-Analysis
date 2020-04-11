# Pewlett-Hackard-Analysis

## Project Overview
With the knowledge that many of their employees' retirement is imminent, Human Resources has asked for assistance identifying potential 
candidates for promotion through their mentorship program. Human Resources will require some additional data to make the transition as seamless as possible. We will first get the employees who are retiring and save their info to a table named ret_eligible using the following steps:
* Using the emp_info table which holds employees with a birthdate between January 1st 1952 and December 31st 1955 to return employee number, first name and last name.
* Inner join emp_info to the titles table to return the job title and date title was assigned.
* Inner join to the salary table to get the salaries of each employee.

Now that the retiring employees and their info has been identified and saved to the table ret_eligible, we will need to remove duplicates from the table and so we can get an accurate count of employees who will be retiring in each department. This will be done by:
* Using an 'AGGREGATE BY' SQL statement on the ret_eligible table to assign row number to duplicate names and return rows equal to a single value so duplicates do not show in results.
* Use a 'GROUP BY' statement to return the results in a table showing the number of employees in each department.

Having identified the number of people retiring in each department we can now identify the individuals who are eligible for a mentorship opportunity based on a date specified by management:
* Using employee number, first name, last name, title, from date, and to date, we will identify current employees with birthdates in 1965.
* Inner join employees to titles to return title, from_date, and to_date.

## Resources
* Data Source departments.csv, dept_count.csv, dept_emp.csv, dept_manager.csv, employees.csv, retirement_info.csv, salaries.csv, title.csv
* Languages: SQL
* Software: pgAdmin 4.19
* Database: PostgreSQL 11.7

## Summary

The analysis has found that Pewlett Hackard has 32, 859 employees who are approaching retirement age, which has been defined as any employee with the birth date between 1952-01-01 and 1955-12-31. The distribution of these employees across departments is as follows:
* Senior Engineers - 13, 538 
* Senior Staff - 12,771
* Engineers - 2,696
* Staff - 2,012
* Technique Leader - 1,589
* Assistant Engineer - 251
* Manager - 2

Human Resources will need take into account projected rate of growth when considering the total number of employees to hire. The total number of employees hired will be 32, 859 multiplied by the projected rate of growth. There will also need to be further analysis to determine internal departmental movement before we can make a conclusion about the number of hires required by each department.

The analysis showed that Pewlitt Hackard only has 1,549 employees who meet the mentorship guidelines, therefore HR will need to either hire qualified individuals or expand their qualifying criteria for the mentorship program. Potential options to qualify more internal employees:
* Length of employment
* Length of time in a position
* Education
* Performance record
* Attendance record

Although Pewlett Hackard now has a working database, they should consider normalizing it in order to reduce the overall size, increase efficiency, and improve scalability. 



