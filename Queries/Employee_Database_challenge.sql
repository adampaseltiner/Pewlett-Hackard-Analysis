-- Number of retiring employees and title
SELECT em.emp_no, 
		em.first_name, 
		em.last_name,
		em.birth_date,
		ti.title, 
		ti.from_date, 
		ti.to_date
	INTO retiring_emp_by_title
	FROM employees AS em
	LEFT JOIN titles as ti
	ON (em.emp_no = ti.emp_no)
	WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	ORDER BY em.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
		first_name,
		last_name,
		title
	INTO emp_unique_titles
	FROM retiring_emp_by_title
	ORDER BY emp_no ASC, to_date DESC;
	
-- The number of employees by their most recent job title who are about to retire.
SELECT COUNT(title), title 
	INTO retiring_titles
	FROM emp_unique_titles
	GROUP BY title
	ORDER BY COUNT(title) DESC;	
	
-- Mentorship Eligibility table to show employees eligible to participate in program.
SELECT DISTINCT ON (em.emp_no) 
		em.emp_no, 
		em.first_name, 
		em.last_name, 
		em.birth_date, 
		de.from_date, 
		de.to_date, 
		ti.title
	INTO mentor_eligible 
	FROM employees AS em
	LEFT JOIN dept_emp AS de
	ON em.emp_no = de.emp_no
	LEFT JOIN titles AS ti
	ON em.emp_no = ti.emp_no
	WHERE (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
	ORDER BY em.emp_no;