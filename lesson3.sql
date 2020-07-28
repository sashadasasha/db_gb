-- База данных «Страны и города мира»:

-- 1. Сделать запрос, в котором мы выберем все данные о городе – регион, страна.

SELECT geodata._cities.title AS "Город", geodata._regions.title AS "Регион", geodata._countries.title AS "Страна" 
FROM geodata._cities 
JOIN geodata._regions ON geodata._cities.region_id = geodata._regions.id
JOIN geodata._countries ON geodata._cities.country_id = geodata._countries.id;

-- 2. Выбрать все города из Московской области.

SELECT geodata._cities.title AS "Город", geodata._regions.title AS "Регион" 
FROM geodata._cities 
JOIN geodata._regions ON geodata._cities.region_id = geodata._regions.id
WHERE geodata._regions.title = "Московская область";

-- База данных «Сотрудники»:
-- 1. Выбрать среднюю зарплату по отделам.

SELECT AVG(salary) AS "Средняя зп отдела", employees.departments.dept_name AS "Отдел" FROM employees.salaries
JOIN employees.dept_emp ON employees.salaries.emp_no = employees.dept_emp.emp_no
JOIN employees.departments ON employees.departments.dept_no = employees.dept_emp.dept_no
GROUP BY employees.departments.dept_no;

-- 2. Выбрать максимальную зарплату у сотрудника.

SELECT MAX(salary) AS "Максимальная зп сотрудника", employees.employees.first_name AS "Имя", employees.employees.last_name AS "Фамилия" 
FROM employees.salaries
JOIN employees.employees ON employees.employees.emp_no = employees.salaries.emp_no
GROUP BY employees.employees.emp_no;

-- 3. Удалить одного сотрудника, у которого максимальная зарплата.

DELETE FROM employees.employees 
WHERE employees.employees.emp_no = (SELECT employees.salaries.emp_no 
FROM employees.salaries 
WHERE employees.salaries.salary = (SELECT MAX(salary) FROM employees.salaries));

-- 4. Посчитать количество сотрудников во всех отделах.

SELECT count(*) AS "Количecтво сотрудников в отделе", employees.departments.dept_name AS "Отдел"
FROM employees.dept_emp
JOIN employees.departments ON employees.dept_emp.dept_no = employees.departments.dept_no
GROUP BY employees.dept_emp.dept_no;


-- 5. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.

SELECT count(distinct employees.dept_emp.emp_no) AS "Количecтво сотрудников в отделе", employees.departments.dept_name AS "Отдел",
SUM(employees.salaries.salary) AS "Сумма зарплат отдела"
FROM employees.dept_emp
JOIN employees.salaries ON employees.dept_emp.emp_no = employees.salaries.emp_no
JOIN employees.departments ON employees.dept_emp.dept_no = employees.departments.dept_no
GROUP BY employees.dept_emp.dept_no;