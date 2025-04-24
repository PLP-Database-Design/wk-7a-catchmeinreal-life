### Question 1 Achieving 1NF (First Normal Form) 🛠️


USE demo;

CREATE TABLE IF NOT EXISTS `OrderDetail` (
  `order_id` INT NOT NULL AUTO_INCREMENT,  
  `customer_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`, `product_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `Customers`(`customer_id`) ON DELETE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `Products`(`product_id`) ON DELETE CASCADE
);

INSERT INTO `OrderDetail` (order_id, customer_id, product_id)
VALUES (101, 34, 46),(101, 34, 47), (102, 35, 48), (102, 35, 49), (102, 35, 50),(103, 36, 48);



-- create table Customers
CREATE TABLE IF NOT EXISTS `Customers`(
`customer_id` INT NOT NULL AUTO_INCREMENT,
`customerName` VARCHAR(150) NOT NULL,
`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`customer_id`)
);

-- adding content
INSERT INTO `Customers`(customer_id, customerName)
VALUES (34, 'John Doe'), (35, 'Jane Smith'), (36, 'Emily Clark');

-- create table Products
CREATE TABLE IF NOT EXISTS `Products`(
`product_id` INT NOT NULL AUTO_INCREMENT,
`product_name` VARCHAR(100) NOT NULL,
`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`product_id`)
);

-- adding products content

INSERT INTO `Products`(product_id, product_name)
VALUES (46, 'Laptop'), (47, 'Mouse'), (48, 'Tablet'), (49, 'Keyboard'),(50, 'Phone');



-- Query to check the data in OrderDetail table
SELECT 
    od.order_id,
    c.customerName,
    p.product_name
FROM 
    OrderDetail od
JOIN Customers c ON od.customer_id = c.customer_id
JOIN Products p ON od.product_id = p.product_id
ORDER BY od.order_id;






-- ### Question 2 Achieving 2NF (Second Normal Form) 🧩


-- 1. Orders table
CREATE TABLE IF NOT EXISTS `Orders` (
   `order_id` INT PRIMARY KEY,
    `customer_name` VARCHAR(150) NOT NULL
);

-- 2. OrderItems table
CREATE TABLE `OrderItems` (
    `order_id` INT,
    `product_name` VARCHAR(100),
    `quantity` INT,
    PRIMARY KEY (order_id, product_name),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);
-- Orders
INSERT INTO `Orders` (order_id, customer_name)
VALUES 
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- OrderItems
INSERT INTO `OrderItems`(order_id, product_name, quantity)
VALUES 
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

SELECT 
    o.order_id,
    o.customer_name,
    i.product_name,
    i.quantity
FROM 
    Orders o
JOIN 
    OrderItems i ON o.order_id = i.order_id
ORDER BY o.order_id;

