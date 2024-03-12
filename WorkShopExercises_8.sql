-- list the details of the employees with the lowest salary
SELECT *
FROM osql_employee
WHERE salary = (
    SELECT MIN(salary)
    FROM osql_employee)
;

-- list orders where the quantitiy is greater than the average quantity of all
-- orders
SELECT *
FROM osql_orders
WHERE quantity > (
    SELECT AVG(quantity)
    FROM osql_orders)
;

-- list details of any suppliers who do not supply any products
SELECT *
FROM osql_supplier s
WHERE supplier_nr NOT IN (
    SELECT p.supplier_nr
    FROM osql_product p)
;

-- list the average credit_limit grouped by town, but only showing towns where
-- the average credit_limit is greater than the overall average credit_limit
SELECT AVG(c.credit_limit), c.town
FROM osql_customer c
GROUP BY town
HAVING AVG(c.credit_limit) > (
    SELECT AVG(i.credit_limit)
    FROM osql_customer i)
;

-- list the details of products not supplied by a London based company
SELECT * 
FROM osql_product p
WHERE p.supplier_nr IN (
    SELECT s.supplier_nr 
    FROM osql_supplier s
    WHERE s.town <> 'London')
;

-- list the details of all orders places for the product 'Graphix Draw 2.0'
SELECT *
FROM osql_orders o
WHERE o.product_code = (
    SELECT p.product_code
    FROM osql_product p 
    WHERE p.description = 'Graphix Draw 2.0')
;

-- list orders which are worth more than the average of all orders
SELECT o.order_nr, o.product_code, o.customer_nr, o.order_date, o.quantity, p.sales_price, (o.quantity*p.sales_price) AS total
FROM osql_orders o, osql_product p
WHERE o.product_code = p.product_code
    AND (o.quantity*p.sales_price) > (
    SELECT AVG(o.quantity*p.sales_price)
    FROM osql_orders o, osql_product p)
;

-- list the employees who earn the three highest salaries
SELECT *
FROM (
    SELECT surname, job, salary
    FROM osql_employee
    ORDER BY salary DESC)
WHERE ROWNUM <= 3
;

-- alternate answer for above
SELECT surname, job, salary
FROM osql_employee
WHERE salary IN (
    SELECT salary
    FROM(
        SELECT DISTINCT salary
        FROM osql_employee
        ORDER BY salary DESC)
    WHERE ROWNUM <=3)
ORDER BY salary DESC
;

-- which department(s) has (have) the most employees?
SELECT department_nr, count(department_nr)
FROM osql_employee
GROUP BY department_nr
HAVING count(department_nr) >= (
    SELECT MAX(count(e.department_nr))
    FROM osql_employee e
    GROUP BY e.department_nr
    )
;

-- select details of products where the total sales value of the orders for the
-- product is greater than the total cost value of the stock for that product
SELECT p.*, o.quantity, (o.quantity * p.sales_price), (p.instock*p.cost_price)
FROM osql_product p, osql_orders o
WHERE p.product_code = o.product_code
AND (o.quantity * p.sales_price) > (p.instock*p.cost_price)
;
