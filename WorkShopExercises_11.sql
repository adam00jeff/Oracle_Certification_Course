-- create an index on the order_date column of the orders table
CREATE INDEX
    orderdate_idx ON osql_orders (order_date)
;

-- create an index on the surname and initials columns of the customer table
CREATE INDEX
    custname_idx ON osql_customer (surname, initials)
;

-- create a view (called emp_view) based upon the following data from the employee
-- table: employee_nr, surname, initials, department_nr. select data from this 
-- view when it is created where the department_nr is 10
CREATE OR REPLACE VIEW
    emp_view AS
    SELECT employee_nr, surname, initials, department_nr
    FROM osql_employee
;

SELECT *
FROM emp_view
WHERE department_nr = 10
;

-- create a view (called stock_view) based upon the following data from existing
-- tables: supplier name, product code, product description, cost value of stock
-- held. Select data from this view when it is created where the cost value of 
-- stock held exceeds £20000
CREATE OR REPLACE VIEW
    stock_view AS
    SELECT s.name AS "Supplier Name", p.product_code AS "Product Code", p.description AS "Description", (p.cost_price*p.instock) AS "Cost Value"
    FROM osql_supplier s, osql_product p
    WHERE s.supplier_nr = p.supplier_nr
;

SELECT *
FROM stock_view
WHERE "Cost Value" > 20000
;

-- create a view from which the customer numbers, surnames and total values of 
-- all orders for each customer can be selected
CREATE OR REPLACE VIEW
    customer_view (customer, name, "Total Value")AS
    SELECT c.customer_nr, c.surname, SUM(o.quantity * p.sales_price) -- this line needs to be SUM not just (column * column)
    FROM osql_customer c, osql_orders o, osql_product p
    WHERE c.customer_nr = o.customer_nr
    AND o.product_code = p.product_code
GROUP BY c.customer_nr, c.surname
;

SELECT * 
FROM customer_view
;
