-- select todays date and time in a format of your own choice
SELECT TO_CHAR(sysdate, 'fmDay Mon ddth YYYY HH24:MI:SS AM')
FROM dual
;

-- select the cost price from the product table and display it with £ signs
SELECT TO_CHAR(cost_price, 'L9999.99')
FROM osql_product
;

-- select the surname and county from the prospect table displaying
-- NULL counties as 'NONE'
SELECT surname, NVL(TO_CHAR(county),'NONE')
FROM osql_prospect
;

-- select the surname and credit_limit from the customer table followed by the 
-- words 'Small', 'Medium' or 'Large' according the whether the credit_limit is
-- less than 750, between 750 and 1000, or greater than 1000.
SELECT surname, credit_limit, 
CASE
    WHEN credit_limit < 750 THEN 'Small'
    WHEN credit_limit BETWEEN 750 AND 1000 THEN 'Medium'
    WHEN credit_limit > 1000 THEN 'Large'
END AS "Credit Allowance"
FROM osql_customer
;

-- what day of the week did the last day of February 2000 fall on?
SELECT TO_CHAR(LAST_DAY('01-FEB-2000'), 'Day')
FROM dual
;

-- show initials and surname (as one column) and the start date for all employees
-- who started work on a Wednesday
SELECT RTRIM(initials) || ' ' || surname AS name, start_date 
FROM osql_employee
WHERE TO_CHAR(start_date, 'Dy') = 'Wed'
;

-- display last Sunday's date in a format similar to Monday March 7th 2005
SELECT TO_CHAR(NEXT_DAY(sysdate, 'Sun') - 7, 'fmDay Mon ddth YYYY')
FROM dual
;

-- display the number of order records for each day of the week on which orders
-- have been placed
SELECT COUNT(order_nr) AS "Number of Orders", TO_CHAR(order_date, 'DAY') AS "Order Day"
FROM osql_orders
GROUP BY TO_CHAR(order_date, 'DAY'),TO_CHAR(order_date, 'D')
ORDER BY TO_CHAR(order_date, 'D')
;

-- show title (Mr. if male, Ms. if female), initials and surname (in one column)
-- and start date of all emplyees who started last year
SELECT CASE sex
    WHEN 'M' THEN 'Mr.'
    WHEN 'F' THEN 'Mrs.'
END ||' '||RTRIM(initials)||surname AS name, start_date
FROM osql_employee
WHERE TO_CHAR(start_date, 'YYYY') = TO_CHAR(sysdate, 'YYYY') - 1
;