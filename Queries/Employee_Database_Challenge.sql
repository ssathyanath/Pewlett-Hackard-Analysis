-- Deliverable 1

-- Extract retirement title information
SELECT e.emp_no, e.first_name, e.last_name,
	   ti.title, ti.from_date, ti.to_date
INTO retirement_title
FROM employees e
INNER JOIN titles ti
ON (e.emp_no = ti.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no, ti.from_date ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
					first_name,
					last_name,
					title
INTO unique_title
FROM retirement_title
ORDER BY emp_no ASC,
		 to_date DESC;

-- Number of Employees by Titles
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_title
GROUP BY title
ORDER BY COUNT(title) DESC;

-- Deliverable 2

-- Mentorship Eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
					e.first_name, e.last_name, e.birth_date, 
	   				d.from_date, d.to_date, t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as d
ON e.emp_no = d.emp_no
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND d.to_date = '9999-01-01'
ORDER BY e.emp_no ASC, t.to_date DESC;

-- Additional Query 

SELECT COUNT(title) FROM retiring_titles;

SELECT COUNT(emp_no) FROM unique_title;

SELECT COUNT (emp_no) FROM mentorship_eligibilty;

SELECT r.count as retiring_emp_count, 
	   COUNT (m.emp_no) as mentorship_eligibility_count, r.title
INTO retiring_mentorship_compare
FROM retiring_titles as r
FULL JOIN mentorship_eligibilty as m
ON r.title = m.title
GROUP BY r.title,r.count
ORDER BY retiring_emp_count DESC;

