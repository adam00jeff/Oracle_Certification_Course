-- list surname and initials, grade and salary of all employees on a salary
-- grade determined by the user at runtime
SELECT RTRIM(e.initials)||e.surname AS Name, s.grade, e.salary
FROM osql_employee e, osql_salgrade s
WHERE e.salary BETWEEN s.low_salary AND s.high_salary
AND s.grade = &grade
;

-- write a SQL script which operates as the above but ensures that the user may 
-- only enter a number for the salary grade when prompted with the message
-- "Enter salary grade:"
ACCEPT grade NUMBER prompt "Enter salary grade"
SELECT RTRIM(e.initials)||e.surname AS Name, s.grade, e.salary
FROM osql_employee e, osql_salgrade s
WHERE e.salary BETWEEN s.low_salary AND s.high_salary
AND s.grade = &grade;

undefine salary;