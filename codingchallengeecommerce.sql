use ecommercecodingch
create table customers(
    customer_id int IDENTITY(1,1)  PRIMARY key,
    name varchar (100),
    email varchar(100) UNIQUE,
    PASSWORD VARCHAR(100) )
    ALTER TABLE Customers
ADD lname varchar(255)
select * from customers
  EXEC sp_rename 'customers.name',  'fname', 'COLUMN'
 


CREATE TABLE products (
    product_id INT identity(1,1) PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10, 2),
    description TEXT,
    stockQuantity INT
)
CREATE TABLE cart (
    cart_id INT identity(1,1) PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
)
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(10, 2),
    shipping_address TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
)

CREATE TABLE order_items (
    order_item_id INT identity(1,1) PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)

)
ALTER TABLE order_items
ADD item_amount decimal(10,2)

select *from products

INSERT INTO products
VALUES
    ( 'Laptop', 800.00,'High-performance laptop',  10),
    ( 'Smartphone',  600.00,'Latest smartphone', 15),
    ( 'Tablet', 300.00,'Portable tablet',  20),
    ( 'Headphones', 150.00,'Noise-canceling',  30),
    ( 'TV',900.00, '4k Smart TV',  5),
    ('Coffee Maker',50.00,  'Automatic coffee maker',25),
    (  'Refrigerator',700.00, 'Energy-efficient',  10),
    ( 'Microwave Oven', 80.00,'Countertop microwave',  15),
    ( 'Blender',  70.00,'High-speed blender', 20),
    ( 'Vacuum Cleaner',120.00, 'Bagless vacuum cleaner',  10)

    -- Inserting values into the customers table
    
INSERT INTO customers 
VALUES
    ( 'John' ,'Doe', 'johndoe@example.com', '123 Main St, City'),
    ( 'Jane','  Smith', 'janesmith@example.com', '456 Elm St, Town'),
    ('Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village'),
    ( 'Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb'),
    ( 'David', 'Lee', 'david@example.com', '234 Cedar St, District'),
    ( 'Laura', 'Hall', 'laura@example.com', '567 Birch St, County'),
    ( 'Michael ','Davis', 'michael@example.com', '890 Maple St, State'),
    ('Emma',' Wilson', 'emma@example.com', '321 Redwood St, Country'),
    ('William ','Taylor', 'william@example.com', '432 Spruce St, Province'),
    ('Olivia','  Adams', 'olivia@example.com', '765 Fir St, Territory')

INSERT INTO Orders  
VALUES 
( 1, '2023-01-05', 1200.00,'wer'),
( 2, '2023-02-10', 900.00,'her'),
( 3, '2023-03-15', 300.00,'her'),
( 4, '2023-04-20', 150.00,'her'),
( 5, '2023-05-25', 1800.00,'her'),
( 6, '2023-06-30', 400.00,'her'),
( 7, '2023-07-05', 700.00,'her'),
( 8, '2023-08-10', 160.00,'her'),
(9, '2023-09-15', 140.00,'her'),
( 10, '2023-10-20', 1400.00,'her')

INSERT INTO Order_Items  
VALUES 
( 1, 1, 2, 1600.00),
(  1, 3, 1, 300.00),
( 2, 2, 3, 1800.00),
( 3, 5, 2, 1800.00),
( 4, 4, 4, 600.00),
( 4, 6, 1, 50.00),
(5, 1, 1, 800.00),
( 5, 2, 2, 1200.00),
( 6, 10, 2, 240.00),
( 6, 9, 3, 210.00)

INSERT INTO Cart  
VALUES 
( 1, 1, 2),
( 1, 3, 1),
( 2, 2, 3),
(3, 4, 4),
( 3, 5, 2),
( 4, 6, 1),
( 5, 1, 1),
( 6, 10, 2),
( 6, 9, 3),
( 7, 7, 2)

--queries and answer
SELECT* from products
SELECT* from customers
SELECT* from cart
SELECT* from order_items
SELECT* from orders
   
--1. Update refrigerator product price to 800.
UPDATE products SET price = 800.00
WHERE name = 'Refrigerator'
SELECT* from products


--2. Remove all cart items for a specific customer.
DELETE FROM cart
WHERE customer_id = 2

--3. Retrieve Products Priced Below $100.

SELECT * FROM products
WHERE price < 100.00

----4. Find Products with Stock Quantity Greater Than 5.
select * from products
where stockQuantity>5
--5. Retrieve Orders with Total Amount Between $500 and $1000.
SELECT total_price FROM orders
where total_price BETWEEN 500 and 1000
--6. Find Products which name end with letter ‘r’.
select *from products
where name like '%r'
--7. Retrieve Cart Items for Customer 5.
select * from cart
where customer_id=5

--8. Find Customers Who Placed Orders in 2023.
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.order_date) = 2023

--9. Determine the Minimum Stock Quantity for Each Product Category.
SELECT name, MIN(stockQuantity) AS minstockquan
FROM products GROUP BY name

--10. Calculate the Total Amount Spent by Each Customer.
select sum(total_price )as totalsum, customer_id from orders 
group by customer_id


--11. Find the Average Order Amount for Each Customer.
select avg(total_price) as totalavg, customer_id from orders
group by customer_id
--12. Count the Number of Orders Placed by Each Customer.
SELECT  COUNT(order_id) AS ordercount ,customer_id FROM orders
GROUP BY customer_id

--13. Find the Maximum Order Amount for Each Customer.
select max(total_price) as totalprimax ,customer_id from orders
group by customer_id
--14. Get Customers Who Placed Orders Totaling Over $1000.
select * from orders
where total_price>1000
--15. Subquery to Find Products Not in the Cart.
select * from products where product_id 
not in(select distinct product_id from cart)

--16. Subquery to Find Customers Who Haven't Placed Orders.
select * from customers where customer_id
not in(select distinct customer_id from cart)
--17. Subquery to Calculate the Percentage of Total Revenue for a Product.s
select * from products
-- totalprice of 1 product/ sum of all price*product *100 for percentage
Select *, (price * stockQuantity) / (SELECT SUM(price * stockQuantity) FROM products) * 100 AS percentageoftotalrevenue 
FROM products


--18. Subquery to Find Products with Low Stock.
select * from products
where stockQuantity < (SELECT avg(stockQuantity) FROM products)

--19. Subquery to Find Customers Who Placed High-Value Orders
--taking 1800 since hes the customer with high-value orders
select * from customers where customer_id IN (
    select customer_id from orders
     GROUP BY customer_id
    HAVING SUM(total_price) >= 1000
)




