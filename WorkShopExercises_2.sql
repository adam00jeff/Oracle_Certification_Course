--employees that are salesman
SELECT *
FROM osql_employee
WHERE job = 'Salesman'
;

-- employees that have no manager
SELECT *
FROM osql_employee
WHERE manager IS NULL
;

-- suppliers that are NOT FROM brighton or birmingham
SELECT * 
FROM osql_supplier
WHERE town NOT IN ('Brighton','Birmingham')
;

--order nubmber, product code, quantity from orders where quantity >75
SELECT order_nr, product_code, quantity
FROM osql_orders
WHERE quantity > 75
;

--all orders for customer number 1317
SELECT *
FROM osql_orders
WHERE customer_nr = 1317
;

--all products with a price £100 in excess of the cost price
SELECT *
FROM osql_product
WHERE sales_price > (cost_price + 100)
;

--customers who live in towns that do not contain the letter 'M' in upper or lowercase
SELECT *
FROM osql_customer
WHERE LOWER(town) NOT LIKE '%m%'
;

--apart from managers and the chariman, which employees earn more than 30k per year
SELECT *
FROM osql_employee
WHERE UPPER(job) NOT IN ('CHAIRMAN','MANAGER')
AND salary*12 > 30000
;

--list employees with salrues from 1000 to 2000 inclusive
SELECT *
FROM osql_employee
WHERE salary BETWEEN 1000 AND 2000
;

--list orders with dates more recent than 1st jan 2009
SELECT *
FROM osql_orders
WHERE order_date > '01-JAN-2009'
;

--list customers with 'i' as the third letter in their surname
SELECT *
FROM osql_customer
WHERE surname LIKE '__i%' 
;

--list customers with exactly one l in the surname
SELECT *
FROM osql_customer
WHERE surname LIKE '%l%' 
AND surname NOT LIKE '%l%l%'
;

--list prospects which have an 'm' as either the second letter or the second from last letter of their surname, 
--but which do not have an 'm'; anywhere else in their surname
SELECT *
FROM osql_prospect
WHERE surname LIKE '%m_' OR surname LIKE '_m%'
AND surname NOT LIKE '_m%m%m_'
AND surname NOT LIKE 'm%'
AND surname NOT LIKE '%m'
;
