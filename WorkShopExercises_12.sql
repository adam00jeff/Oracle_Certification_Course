-- connect tot he system account to issue the fllowing commands
-- GRANT CREATE SYNONYM TO user0
-- GRANT CREATE SYNONYM TO user1
GRANT CREATE SYNONYM TO user0;
GRANT CREATE SYNONYM TO user1;


-- log in to the user1 account and create a squence starting at number 2000
CREATE SEQUENCE new_seq
    MINVALUE 2000
;

-- insert a new order into the orders table, using the sequence created above to
-- supply a value for the order_nr. Commit your change.
INSERT INTO osql_orders (order_nr, product_code, customer_nr, order_date, quantity)
    VALUES (new_seq.NEXTVAL, 'GD2', 1317, sysdate, 666)
;

-- issue the command:
-- GRANT SELECT ON CUSTOMER TO user0
GRANT SELECT ON osql_CUSTOMER TO user0;

-- Log in to the user0 account (password is user0) and create a private synonym
-- called client for the customer table in the user1 schema.
-- select from this newly created synonym to check it works
CREATE SYNONYM client_syn FOR osql_customer
;

SELECT *
FROM client_syn
;

-- log in to the system account and create a public synonym called sales for the
-- orders table in the user1 schema
CREATE PUBLIC SYNONYM sales_syn FOR osql_orders
;

-- log in to the user1 account and issue the command:
-- SELECT * FROM sales ; what does this show?
SELECT * from sales_syn
;
