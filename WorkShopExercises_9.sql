-- insert a new department into the department table. commit your change
INSERT INTO osql_department (department_nr, name, location)
VALUES (50, 'Testing', 'Bath')
;
COMMIT;

-- insert an order into the orders table, commit your change
INSERT INTO osql_orders (order_nr, product_code, customer_nr, order_date, quantity)
VALUES (1024, 'HD12', 1674, '14-FEB-24 16:36:42', 30)
;
COMMIT;
-- give all employees in department 10 a pay increase of £200. commit your change
UPDATE osql_employee
SET salary = (salary+200)
WHERE department_nr = 10
;
COMMIT;

-- delete prospect number 11. commit your change
DELETE 
FROM osql_prospect
WHERE prospect_nr = 11
;
COMMIT;

-- count all current prospects. delete prospects with a credit rating less than
-- 10 who are based in london. How many prospects are left? Create a savepoint.
SELECT count(*)
FROM osql_prospect
;
-- 20 prospects
DELETE 
FROM osql_prospect
WHERE credit_rating < 10
AND town = 'London'
;
-- 16 prospects
SAVEPOINT sv_pt_1;

-- delete prospects with a credit rating less than 10 who are based in Truro.
-- how many prospects are left? ROLLBACK to your savepoint. how many prospects
-- are left now? do a full rollback. How many prospects are left now?
DELETE 
FROM osql_prospect
WHERE credit_rating < 10
AND town = 'Truro'
;
SELECT count(*)
FROM osql_prospect
;
-- 14 prospects left
ROLLBACK TO sv_pt_1;
-- 16 prospects left
ROLLBACK;
-- 20 prospects left

-- for any orders that have been placed on a weekend move the order date to the
-- following monday. if no such orders currently exist then create one using an
-- insert statement
UPDATE osql_orders
SET order_date = NEXT_DAY(order_date, 'Mon')
WHERE TO_CHAR(order_date, 'Dy') IN ('Sat', 'Sun')
;

-- write a single update statement to increase the credit limit of London
-- customers by 10%, Manchester customers by 6% and Birmingham customers
-- by 4%. No other customer credit limits should be affected.
UPDATE osql_customer
SET credit_limit = DECODE( town,
    'London', credit_limit *1.1,
    'Manchester', credit_limit *1.06,
    'Birmingham', credit_limit *1.04)
WHERE town IN ('London', 'Manchester', 'Birmingham')
;
