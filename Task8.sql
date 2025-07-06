CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Employee 
(
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    EmpSal DECIMAL(10,2),
    Dept VARCHAR(50)
);

-- Sample data
INSERT INTO Employee VALUES
(1, 'Keerthi', 30000, 'HR'),
(2, 'Harika', 35000, 'IT'),
(3, 'Neerja', 28000, 'HR'),
(4, 'Mahesh', 40000, 'IT');

-- procedure
DELIMITER //
CREATE PROCEDURE AddBonusToDept(
    IN deptName VARCHAR(50),
    IN bonusAmount DECIMAL(10,2)
)
BEGIN
    UPDATE Employee
    SET EmpSal = EmpSal + bonusAmount
    WHERE Dept = deptName;
END //
DELIMITER ;

CALL AddBonusToDept('HR', 2000.00);

-- delete the emp by id 
DELIMITER //
CREATE PROCEDURE DeleteEmployeeByID
(
    IN emp_id INT
)
BEGIN
    DELETE FROM Employee WHERE EmpID = emp_id;
END //
DELIMITER ;

CALL DeleteEmployeeByID(5);

-- Insert a new employee
DELIMITER //
CREATE PROCEDURE InsertEmployee
(
    IN emp_id INT,
    IN emp_name VARCHAR(50),
    IN salary DECIMAL(10,2),
    IN department VARCHAR(50)
)
BEGIN
    INSERT INTO Employee (EmpID, Name, EmpSal, Dept)
    VALUES (emp_id, emp_name, salary, department);
END //
DELIMITER ;

CALL InsertEmployee(5, 'Sandeep', 32000, 'HR');

-- functon
DELIMITER //
CREATE FUNCTION CalculateAnnualSalary
(
    monthlySal DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monthlySal * 12;
END //
DELIMITER ;

SELECT EmpID, Name, EmpSal AS MonthlySalary, 
       CalculateAnnualSalary(EmpSal) AS AnnualSalary
FROM Employee;

-- Get First Letter OF emp Name
DELIMITER //
CREATE FUNCTION GetFirstLetter(empName VARCHAR(50))
RETURNS CHAR(1)
DETERMINISTIC
BEGIN
    RETURN LEFT(empName, 1);
END //
DELIMITER ;

SELECT Name, GetFirstLetter(Name) AS FirstChar
FROM Employee;
