-- 1. DATA FILTERING

/* 1.Business Question: Which female employees were hired either on January 1, 1990 or after January 1, 2000?
 Task: Retrieve all female employees whose hire date is equal to 1990-01-01 or later than 2000-01-01*/
 
SELECT *
FROM employees
WHERE gender = 'F' AND (hire_date = '1990-01-01' OR hire_date > '2000-01-01');

/* 2.Business Question: Are there employees whose first name and last name are identical?
Task: Find employees where first_name = last_name*/

SELECT first_name, last_name
FROM employees
WHERE first_name = last_name;

/* 3.Business Question: What are the details of employees with employee numbers between 10001 and 10004?
Task: Retrieve first name, last name, gender, and hire date for employees whose employee number is between 10001 and 10004*/

SELECT first_name, last_name, gender, hire_date
FROM employees
WHERE emp_no BETWEEN 10001 AND 10004;

-- 2. DEPARTMENT ANALYSIS

/* 4.Business Question: Which departments contain the letter “a” or have “e” as the second letter in their name?
Task: Retrieve department names that match specific text patterns using LIKE*/

SELECT dept_name
FROM departments
WHERE dept_name  LIKE '%a%' OR dept_name LIKE '_e';

-- 3. EMPLOYEE DEMOGRAPHICS

/* 5.Business Question: Which male employees were 45 years old when they were hired, were born in October, and were hired on a Sunday?
Task: Find employees matching the following conditions: gender = 'M',age at hiring = 45,birth month = October,hire day = Sunday*/

SELECT *
FROM employees
WHERE gender = 'M' AND TIMESTAMPDIFF(Year, birth_date, hire_date)= 45 AND MONTH (birth_date) = 10 AND DAYNAME(hire_date) = 'Sunday';

-- 4. SALARY ANALYSIS

/*  6.Business Question: What is the highest salary recorded in the company after June 1, 1995?
Task: Find the maximum salary in the salaries table where the salary record starts after 1995-06-01*/

SELECT MAX(salary)
FROM salaries
WHERE from_date > '1995-06-01';

/* 7.Business Question: How many employees currently work in each department?
Task: Count employees per department using the dept_emp table where to_date > current_date*/

SELECT dept_no, COUNT(dept_no) AS count_employees
FROM dept_emp
WHERE to_date > current_date
GROUP BY dept_no
HAVING count_employees > 13000 
ORDER BY dept_no;

/* 8.Business Question: What are the minimum and maximum salaries earned by each employee?
Task: Calculate the minimum and maximum salary per employee from the salaries table*/

SELECT emp_no, MIN(salary), MAX(salary)
FROM salaries
GROUP BY emp_no;

/* 9. Business Question: What is the average salary in each department?
Task: Calculate the average salary for employees in each department by joining the tables dept_emp, departments, and salaries*/

SELECT dept_name, ROUND(AVG(salary), 2) AS avg_salary
FROM dept_emp AS de
INNER JOIN departments AS d ON(d.dept_no = de.dept_no)
INNER JOIN salaries AS s ON (s.emp_no = de.emp_no)
WHERE CURDATE() BETWEEN s.from_date AND s.to_date
AND CURDATE() BETWEEN de.from_date AND de.to_date
GROUP BY d.dept_name
ORDER BY avg_salary DESC;

