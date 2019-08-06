- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
DROP TABLE departments
DROP TABLE dept_emp
DROP TABLE dept_manager
DROP TABLE employees
DROP TABLE salaries
DROP TABLE titles

CREATE TABLE departments (
    "dept_no" VARCHAR PRIMARY KEY  NOT NULL,
    "dept_name" VARCHAR   NOT NULL);

CREATE TABLE dept_emp (
    "emp_no" INT PRIMARY KEY NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL);

CREATE TABLE dept_manager (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT PRIMARY KEY  NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

CREATE TABLE employees (
    "emp_no" INT PRIMARY KEY  NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL
);

CREATE TABLE salaries (
    "emp_no" INT PRIMARY KEY  NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

CREATE TABLE titles (
    "emp_no" INT PRIMARY KEY  NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

--======================================
--QUESTION #1 List the following details of each employee: employee number, last name, first name, gender, and salary.
select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from employees e
left join salaries s
on e.emp_no = s.emp_no

--QUESTION #2 List employees who were hired in 1986.
select first_name, last_name from employees
where hire_date between '1986-01-01' and '1986-12-31';

--QUESTION #3 List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

select d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
from dept_manager dm
left join departments d
on d.dept_no = dm.dept_no
left join employees e
on dm.emp_no = e.emp_no

--Question #4 List the department of each employee with the following information: employee number, last name, first name, and department name.

select e.emp_no AS EmployeeNumber, e.last_name AS LastName, e.first_name AS FirstName, d.dept_name AS DeptName
from dept_manager dm
left join departments d
on d.dept_no = dm.dept_no
left join employees e
on dm.emp_no = e.emp_no

--Question #5 List all employees whose first name is "Hercules" and last names begin with "B."

select * from employees where first_name = 'Hercules' AND last_name like 'B%';

--Question #6 List all employees in the Sales department, including their employee number, last name, 
--first name, and department name
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e
left join dept_emp de
on e.emp_no = de.emp_no
left join departments d
on de.dept_no = d.dept_no
where dept_name = 'Sales';

--Question #7 List all employees in the Sales and Development departments, including their 
--employee number,last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e
left join dept_emp de
on e.emp_no = de.emp_no
left join departments d
on de.dept_no = d.dept_no
where dept_name = 'Sales' or 'Development';

-- Question #8 In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.
SELECT employees.last_name, COUNT(employees.last_name) AS "Occurence"
FROM employees
GROUP BY employees.last_name
ORDER BY "Occurence" DESC;

