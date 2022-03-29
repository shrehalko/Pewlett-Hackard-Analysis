------------------------------------------------------------------------------------------------------------
--Deliverable 1
------------------------------------------------------------------------------------------------------------

-- Use Dictinct with Orderby to remove duplicate rows
-- select empno,first and last name,title,from and to date from employee and title table and filter 
-- the retiring employees with birthdate between 1952 and 1955.
-- order the table by empno.
SELECT e.emp_no, e.first_name,
e.last_name ,
t.title, t.from_date, t.to_date 
INTO retirement_table
FROM employees as e
Left JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- The above query output contains duplicate entries for some employees because they have switched titles 
-- over the years.
-- We need to filter Distinct emp no, Exclude those employees that have already left the company 
-- by filtering on to_date to keep only those dates that are equal to '9999-01-01' 
-- Sort the Unique Titles table in ascending order by the employee number and descending order by 
-- the last date (i.e., to_date) of the most recent title

SELECT Distinct on (emp_no) emp_no,
first_name,
last_name , title
into unique_titles
from retirement_table
Where to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC

-- Retrieve the number of titles from the Unique Titles table,
-- Group the table by title, then sort the count column in descending order
select count(title),title
into retiring_titles
from unique_titles
group by title
order by count desc;

------------------------------------------------------------------------------------------------------------
-- Deliverable 2
------------------------------------------------------------------------------------------------------------
-- Get the total number of retiring employees by Title.

SELECT distinct on (e.emp_no) e.emp_no, e.first_name,
e.last_name , e.birth_date,
de.from_date, de.to_date ,
t.title
INTO mentorship_eligibilty
FROM employees as e
Left JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
Left JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
and de.to_date = ('9999-01-01')
ORDER BY e.emp_no;

------------------------------------------------------------------------------------------------------------
-- Delivery 3
------------------------------------------------------------------------------------------------------------

-- get the total number of employees retiring
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    de.to_date, de.dept_no
 	INTO retiring_emp
	FROM employees as e
    LEFT JOIN dept_emp as de
    ON e.emp_no = de.emp_no
	WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
    and de.to_date = ('9999-01-01');

-- get the retiring employees by department and title.
SELECT d.dept_name,t.title,count(ce.emp_no) 
    into dept_title  
    FROM retiring_emp as ce
    left join titles as t
    on t.emp_no = ce.emp_no
    left join departments as d
    on ce.dept_no = d.dept_no
    where t.to_date = '9999-01-01'
    GROUP BY d.dept_name,t.title
    ORDER BY count(ce.emp_no) desc;