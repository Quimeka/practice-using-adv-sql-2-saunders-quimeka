USE online_store;

DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;


CREATE TABLE customers (
 id INT PRIMARY KEY AUTO_INCREMENT,
 first_name VARCHAR(50),
 last_name VARCHAR(50)
);

CREATE TABLE orders (
 id INT PRIMARY KEY,
 customer_id INT NULL,
 order_date DATE,
 total_amount DECIMAL(10, 2),
 FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (id, first_name, last_name) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');

INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES
(1, 1, '2023-01-01', 100.00),
(2, 1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);


-- View all customers
SELECT * FROM customers;

-- View all orders
SELECT * FROM orders;

-- Finding the total amount spent by each customer
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;


-- Find the total amount spent by each customer where total is > 200
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
WHERE total_amount > 200
GROUP BY customer_id;

-- Find the total amount spent by each customer where total is > 200 CORRECTED VIA QUIMEKA
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 200;

-- Find each of the rows from the orders table, with their corresponding customer's first and last name from the customers table
SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;

-- Find each of the rows from the orders table, with all customers despite null values from the customers table
SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id;

-- Find all orders where the total_amount is greater than or equal to the average total_amount of all orders. 
SELECT id, order_date, total_amount
FROM orders
WHERE total_amount >= (SELECT AVG(total_amount) FROM orders); 


-- Find all orders where the customer_id is in the list of id values of customers with the last name 'Smith'. 

SELECT id, order_date, total_amount, customer_id
FROM orders
WHERE customer_id IN (SELECT id FROM customers WHERE last_name = 'Smith');

-- all the order_date values from the orders table

SELECT order_date
FROM (SELECT id, order_date, total_amount FROM orders) AS order_summary;

SELECT * FROM orders;