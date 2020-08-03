--1.
CREATE VIEW money_of_department AS
    SELECT 
        COUNT(DISTINCT employees.dept_emp.emp_no) AS 'department_employees',
        employees.departments.dept_name AS 'department',
        SUM(employees.salaries.salary) AS 'department_money'
    FROM
        employees.dept_emp
            JOIN
        employees.salaries ON employees.dept_emp.emp_no = employees.salaries.emp_no
            JOIN
        employees.departments ON employees.dept_emp.dept_no = employees.departments.dept_no
    GROUP BY employees.dept_emp.dept_no;

--2. Создать функцию, которая найдет менеджера по имени и фамилии.

    --Функция

USE `employees`;
DROP function IF EXISTS `get_employee_by_name`;

DELIMITER $$
USE `employees`$$
CREATE DEFINER=`sasha`@`%` FUNCTION `get_employee_by_name`(first_name VARCHAR(14), last_name VARCHAR(16)) RETURNS int
    READS SQL DATA
BEGIN
	RETURN (SELECT 
    employees.emp_no
	FROM
		employees
	JOIN
		dept_manager ON employees.emp_no = dept_manager.emp_no
	WHERE
		employees.first_name = first_name
	AND employees.last_name = last_name);
END$$

DELIMITER ;

    --Процедура (просто потренировалась))

DELIMITER //
CREATE PROCEDURE manager_info (first_name VARCHAR(14), last_name VARCHAR(16))
BEGIN
SELECT * FROM employees JOIN dept_manager ON employees.emp_no = dept_manager.emp_no WHERE employees.first_name = first_name AND employees.last_name = last_name;
END//
DELIMITER ;

CALL manager_info("Ebru","Alpin")



--3. Создать триггер, который при добавлении нового сотрудника будет выплачивать ему вступительный бонус, занося запись об этом в таблицу salary.

DROP TRIGGER IF EXISTS `employees`.`employees_AFTER_INSERT`;

DELIMITER $$
USE `employees`$$
CREATE DEFINER = CURRENT_USER TRIGGER `employees`.`employees_AFTER_INSERT` AFTER INSERT ON `employees` FOR EACH ROW
BEGIN
	INSERT INTO `employees`.`salaries` (`emp_no`, `salary`, `from_date`, `to_date`) VALUES (NEW.emp_no, '10000', '2001-11-29', '9999-01-01');
END$$
DELIMITER ;