-- how many rows in the proscpect table?
SELECT COUNT(*)
FROM osql_prospect
;

--how many employees have the surname 'Jones'
SELECT count(*)
FROM osql_employee
WHERE LOWER(surname) LIKE 'jones'
;

--find the maxiumum, minimum and average salary
SELECT MAX(salary), MIN(salary), AVG(salary)
FROM osql_employee
;

--count how many orders there are for each product code
SELECT COUNT(order_nr), product_code
FROM osql_orders
GROUP BY product_code
;

--count how many orders there are for each product code
--but only for product_codes with more than 3 orders
SELECT COUNT(order_nr), product_code
FROM osql_orders
GROUP BY product_code
HAVING COUNT(order_nr) > 3
;

--find the sum of the salary for each job within each department
SELECT SUM(salary), job, department_nr
FROM osql_employee
GROUP BY job, department_nr
ORDER BY department_nr, job
;

--apart from orders for customers 1317 and 1223, list the average quantity grouped by product_code
--and customer_nr, as long as the average is less than 10
SELECT AVG(quantity), product_code, customer_nr
FROM osql_orders    
WHERE customer_nr NOT IN (1317, 1223)
GROUP BY product_code, customer_nr
HAVING AVG(quantity) < 10 
;

--find the maximum, minimum, and average salary of employees who are neither
--analysts nor the chairman, grouping this output by the job and only including
--jobs where the average salary is between £1000 and £1500 inclusive. Order your data by minimum salary
SELECT MAX(salary), MIN(salary), AVG(salary), employee_nr, job
FROM osql_employee
WHERE LOWER(job) NOT IN ('analyst','chairman')
GROUP BY job, employee_nr
HAVING AVG(salary) BETWEEN 1000 AND 1500
ORDER BY MIN(salary)
;
