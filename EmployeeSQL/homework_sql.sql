-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/gM61mM
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" varchar(4)   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(4)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(4)   NOT NULL,
    "emp_no" int   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

CREATE TABLE "titles" (
    "emp_title_id" varchar(5)   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "emp_title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp__emp_no" FOREIGN KEY( "emp_no")
REFERENCES "employees" ( "emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager__dept_no" FOREIGN KEY( "dept_no")
REFERENCES "departments" ( "dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("emp_title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries__emp_no" FOREIGN KEY( "emp_no")
REFERENCES "employees" ( "emp_no");


--Question 1 List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary 
FROM salaries
INNER JOIN employees ON 
employees.emp_no = salaries.emp_no;


--Question 2 List first name, last name, and hire date for employees who were hired in 1986.
SELECT * FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--Question 3 List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT * FROM departments
SELECT * FROM dept_manager
SELECT * FROM employees

SELECT dept_manager.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name 
FROM dept_manager 
INNER JOIN employees
ON employees.emp_no = dept_manager.emp_no
INNER JOIN departments 
ON dept_manager.dept_no = departments.dept_no;

--Question 4 List the department of each employee with the following information: employee number, last name, first name, and department name
SELECT * FROM departments
SELECT * FROM employees
SELECT * FROM dept_emp

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments 
ON dept_emp.dept_no = departments.dept_no;

--Question 5 List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT employees.first_name, employees.last_name, employees.sex FROM employees
WHERE first_name LIKE 'Hercules' 
AND last_name LIKE 'B%';

-- Question 6 List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

--Question 7 List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'
OR departments.dept_name = 'Development';

--Question 8 In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name AS "LAST NAME",
COUNT(last_name) AS "FREQUENCY COUNT OF EMPLOYEE LAST NAMES"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;


