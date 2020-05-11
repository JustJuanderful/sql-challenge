-- Data Engineering Portion

-- Create table schemas for each CSV data file
CREATE TABLE "departments" (
    "dept_no" VARCHAR NOT NULL,
    "dept_name" VARCHAR NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT NOT NULL,
    "dept_no" VARCHAR NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR NOT NULL,
    "emp_no" INT NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT NOT NULL,
    "emp_title_id" VARCHAR NOT NULL,
    "birth_date" DATE NOT NULL,
    "first_name" VARCHAR NOT NULL,
    "last_name" VARCHAR NOT NULL,
    "sex" VARCHAR NOT NULL,
    "hire_date" DATE NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT NOT NULL,
    "salary" INT NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR NOT NULL,
    "title" VARCHAR NOT NULL,
	CONSTRAINT "pk_titles" PRIMARY KEY (
		"title_id"
	)
);

-- Import CSV data into tables

-- Import departments.csv into "departments" table
COPY departments(dept_no, dept_name)
FROM 'C:\Users\departments.csv' DELIMITER ',' CSV HEADER;

-- Import dept_emp.csv into "dept_emp" table
COPY dept_emp(emp_no, dept_no)
FROM 'C:\Users\dept_emp.csv' DELIMITER ',' CSV HEADER;

-- Import dept_manager.csv into "dept_manager" table
COPY dept_manager(dept_no, emp_no)
FROM 'C:\Users\dept_manager.csv' DELIMITER ',' CSV HEADER;

-- Import employees.csv into "employees" table
COPY employees(emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date)
FROM 'C:\Users\employees.csv' DELIMITER ',' CSV HEADER;

-- Import salaries.csv into "salaries" table
COPY salaries(emp_no, salary)
FROM 'C:\Users\salaries.csv' DELIMITER ',' CSV HEADER;

-- Import titles.csv into "titles" table
COPY titles(title_id, title)
FROM 'C:\Users\titles.csv' DELIMITER ',' CSV HEADER;

-- Add foreign keys
ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" RENAME COLUMN "emp_title_id" TO "title_id";

ALTER TABLE "employees" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("title_id")
REFERENCES "titles" ("title_id");

-- Query all schemas to verify data
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;