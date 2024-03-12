SELECT c.customer_nr, c.surname, c.initials, o.order_nr,o.product_code, o.quantity
FROM osql_customer c, osql_orders o
WHERE c.customer_nr = o.customer_nr(+)
AND UPPER(c.town) = 'LONDON'
ORDER BY c.customer_nr
;

-- list the employee number, surname, job, department name and department
-- location for each employee. order the results by location
SELECT e.employee_nr, e.surname, e.job, d.name, d.location
FROM osql_employee e, osql_department d
ORDER BY d.location
;

-- list the product code, description, sales price and name of supplier for all 
--products. Order the output by name of supplier.
SELECT p.product_code, p.description, p.sales_price, s.name AS "Supplier Name"
FROM osql_product p, osql_supplier s
ORDER BY s.name
;

--list details of those Products supplied by 'London Computers LTD.' (dont forget 
-- the '.' at the end!
SELECT p.*, s.name
FROM osql_product p, osql_supplier s
WHERE UPPER(s.name) LIKE 'LONDON COMPUTERS LTD.'
;

--list details of all suppliers and the products they supply (if any)
SELECT s.name, s.supplier_nr, p.description, p.product_code
FROM osql_supplier s, osql_product p
WHERE s.supplier_nr = p.supplier_nr(+)
;

-- list surnames and initials from customer and surnames and initials from the 
-- prospect as a single integrated vertical list. Only display one occurance of 
-- any duplicate names
SELECT surname, initials
FROM osql_customer
UNION 
SELECT surname, initials
FROM osql_prospect
;

--as question 5 but do not eliminate duplicates 
SELECT surname, initials
FROM osql_customer
UNION ALL
SELECT surname, initials
FROM osql_prospect
;

-- list the surnames which appear in both the employee and customer tables
SELECT surname
FROM osql_customer
INTERSECT
SELECT surname
FROM osql_employee
;

-- list the surnames which appear in the customer table but do not appear in the 
-- employee table 
SELECT surname
FROM osql_customer
MINUS
SELECT surname
FROM osql_employee
;

-- list the customer_nr, credit_limit, order_nr, product_code, supplier_nr and 
-- name of supplier for all customers with a credit limit greater than 1000
SELECT c.customer_nr, c.credit_limit, o.order_nr, p.product_code, s.supplier_nr, s.name
FROM osql_customer c, osql_orders o, osql_product p, osql_supplier s
WHERE c.customer_nr = o.customer_nr
AND o.product_code = p.product_code
AND p.supplier_nr = s.supplier_nr
AND c.credit_limit > 1000
;

-- every month the chairman takes two employees out to lunch. List the employee
-- numbers and surnames of all possible non-chariman employee pairings.
SELECT e.employee_nr, e.surname, f.employee_nr, f.surname
FROM osql_employee e, osql_employee f
WHERE e.employee_nr < f.employee_nr
    and e.job <> 'Chairman'
    and f.job <> 'Chairman'
ORDER BY e.employee_nr, f.employee_nr
;

-- display a count of how many propects there are in each of the towns which have 
-- customers in the customers table. all prospects in a town not in the customer
-- table are to be counted together under a NULL town name
SELECT c.town, COUNT(DISTINCT p.prospect_nr) AS number_of_prospects
FROM osql_prospect p, osql_customer c
WHERE p.town = c.town(+)
GROUP BY c.town
ORDER BY c.town
;
