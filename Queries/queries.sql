-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

-- Creating table for employees
CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

-- Creating table for managers
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

-- Creating table for salaries
CREATE TABLE salaries (
  	emp_no INT NOT NULL,
  	salary INT NOT NULL,
  	from_date DATE NOT NULL,
  	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
PRIMARY KEY (emp_no)
);

-- Creating table for employee departments
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

-- Creating table for titles
CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, from_date)
);

SELECT * FROM titles;

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Retirement eligibility
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Joining retirement_info and dept_emp tables (aliases)
SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

-- Joining departments and dept_manager tables (aliases)
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Left join for reitrement info and dept employee tables
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO retiring_emp_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

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
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');
	 
--  List of managers per department
SELECT  dm.dept_no,
		d.dept_name,
		dm.emp_no,
		ce.last_name,
		ce.first_name,
		dm.from_date,
		dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN	departments AS d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp AS ce
		ON (dm.emp_no = ce.emp_no);
		
-- Department retirees
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no);
		
-- Sales Team Retirement Info
SELECT *
INTO sales_info
FROM dept_info
WHERE dept_name IN ('Sales');

-- Mentor info
SELECT *
INTO mentor_info
FROM dept_info
WHERE dept_name IN ('Sales', 'Development');

-- Number of retiring employees by dept
SELECT DISTINCT ON(emp_no) emp_no, dept_no, to_date
INTO dept_retiring
FROM dept_emp
ORDER BY emp_no ASC, to_date DESC;

SELECT un.emp_no, un.title, de.dept_no, de.to_date, du.dept_name
INTO dept_unique
FROM emp_unique_titles AS un
LEFT JOIN dept_retiring AS de
ON un.emp_no = de.emp_no
LEFT JOIN departments as du
ON de.dept_no = du.dept_no;

SELECT COUNT(emp_no) AS emp_count, dept_name
FROM dept_unique
GROUP BY dept_name
ORDER BY emp_count DESC;

-- Retiring employee salaries
SELECT ut.emp_no,
	ut.first_name,
	ut.last_name,
	ut.title,
	d.dept_name,
	sl.salary
INTO retiring_salaries
FROM emp_unique_titles AS ut
	INNER JOIN dept_emp AS de
		ON (ut.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no)
	INNER JOIN salaries AS sl
		ON (ut.emp_no = sl.emp_no)
ORDER BY ut.emp_no;

-- Retiring employee salaries by department
SELECT SUM (salary), dept_name
INTO retiring_salary
FROM retiring_salaries
GROUP BY dept_name
ORDER BY SUM DESC;