-- select 5 raised to the power of 3
SELECT POWER(5,3) 
FROM dual
;

-- select the square root of 2
SELECT SQRT(2)
FROM dual
;

-- display the surname and salary from the employee table, rounding the salary to the nearest 100
 SELECT surname, ROUND(salary,-2)
 FROM osql_employee
 ;

-- find the average salary from the employee table rounded to 2 decimal places
SELECT ROUND(AVG(salary),2)
FROM osql_employee
;

-- select the town from the customer table in upper case
SELECT UPPER(town)
FROM osql_customer
;

-- select the first initial and surname of customers 
SELECT SUBSTR(initials,0,1)||'.'|| surname
FROM osql_customer
;

-- select the surname right-padded to 10 characters, concatenated with the initials from
-- the customer table
SELECT RPAD(surname,10)||initials
FROM osql_customer
;

-- select todays date
SELECT sysdate
FROM dual
;

-- select the date five days from now
SELECT sysdate + 5
FROM dual
;

-- select the date 4 months from now
SELECT ADD_Months(sysdate, 4)
FROM dual
;

-- find the date on friday
SELECT NEXT_DAY(sysdate, 'Friday')
FROM dual
;

-- display the employee number, surname, job and weekly salary for each 
-- employee. ensure that the weekly salary values are rounded to two decimal
-- places on output
SELECT employee_nr, surname, job, ROUND((salary*12)/52,2) as "Weekly Salary"
FROM osql_employee
;

-- display the product code, description, sales price, cost price and instock 
-- values for each product. Order the output so that 'longest' product 
-- description is listed first.
SELECT product_code, description, sales_price, cost_price, instock
FROM osql_product
ORDER BY LENGTH(description) DESC
;

-- display the surname and street name (without the street number) for each 
-- customer. Ensure that the surnames are displayed in upper case.
SELECT surname, substr(street, INSTR(street, ' ') )
FROM osql_customer
;

-- to the nearest £1000 what is the average sales value of orders placed within
-- the last 18 months? (Order value to be calculated as quantity * sales price).
-- If no rows are returned, try 24 months (order dates may vary).
SELECT ROUND(AVG(o.quantity*p.sales_price),-3) as AVG_VALUE
FROM osql_orders o, osql_product p 
WHERE o.product_code = p.product_code
AND MONTHS_BETWEEN(sysdate, order_date) < 18
;
