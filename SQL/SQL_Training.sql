use sql_training;

CREATE TABLE Sales (
	sale_id INT PRIMARY KEY,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_price DECIMAL(10,2)
);

INSERT INTO Sales (sale_id, product_id, quantity_sold, sale_date, total_price) VALUES
( 1, 101, 5, '2024-01-01', 2500.00 ),
(2, 102, 3, '2024-01-02', 900.00),
(3, 103, 2, '2024-01-02', 60.00),
(4, 104, 4, '2024-01-03', 80.00),
(5, 105, 6, '2024-01-03', 90.00);

SELECT * FROM Sales;

id, name cata, utit_price

CREATE TABLE Product (
	product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    catagory VARCHAR(50),
    unit_price DECIMAL(10, 2)
); 

ALTER TABLE Product RENAME TO Products;

INSERT INTO Products (product_id, product_name, catagory, unit_price) VALUES
(101, 'Laptop', 'Electronics', 500.00),
(102, 'Smartphone', 'Electronics', 300.00),
(103, 'Headphones', 'Electronics', 30.00),
(104, 'Keyboard', 'Electronics', 20.00),
(105, 'Mouse', 'Electronics', 15.00);

SELECT * FROM Sales;
SELECT * FROM Products;

SELECT sale_id, sale_date FROM Sales;
SELECT product_name, unit_price FROM Products;

SELECT * FROM Sales WHERE total_price > 100;

SELECT * FROM Products WHERE catagory = "Electronics";

-- Retrieve the sale_id and total_price from the Sales table for sales made on January 3, 2024.
SELECT sale_id, total_price FROM Sales WHERE sale_date = '2024-01-03';

-- Retrieve the product_id and product_name from the Products table for products with a unit_price greater than $100
SELECT product_id, product_name from Products WHERE unit_price > 100;

-- Calculate the total revenue generated from all sales in the Sales table.
SELECT SUM(total_price) AS total_revenue FROM Sales;

-- Calculate the average unit_price of products in the Products table.
SELECT AVG(unit_price) as avg_unit from Products;

-- Calculate the total quantity_sold from the Sales table.
SELECT SUM(quantity_sold) AS total_sales FROM Sales;
 
-- Count Sales Per Day from the Sales table
SELECT sale_date, SUM(quantity_sold) as sale_count 
from Sales 
group by sale_date;

-- Retrieve product_name and unit_price from the Products table with the Highest Unit Price

select product_name, unit_price 
from Products
order by unit_price DESC
limit 1;

-- Retrieve the sale_id, product_id, and total_price from the Sales table for sales with a quantity_sold greater than 4.
select sale_id, product_id, total_price from sales
where quantity_sold > 4;

-- Retrieve the product_name and unit_price from the Products table, ordering the results by unit_price in descending order
select product_name, unit_price from Products
order by unit_price DESC;

-- Retrieve the total_price of all sales, rounding the values to two decimal places
select ROUND(SUM(total_price), 2) as total from Sales;

-- Calculate the average total_price of sales in the Sales table
select ROUND(AVG(total_price), 2) as av_pr from Sales;

-- Retrieve the sale_id and sale_date from the Sales table, formatting the sale_date as 'YYYY-MM-DD'
select sale_id, date_format(sale_date, '%Y-%m-%d') as Date_ from Sales;

-- Calculate the total revenue generated from sales of products in the 'Electronics' category.
Select SUM(total_price) as total 
from Sales 
join Products on Sales.product_id = Products.product_id
WHERE Products.catagory="Electronics";

-- Retrieve the product_name and unit_price from the Products table, filtering the unit_price to show only values between $20 and $600.
SELECT product_name, unit_price from Products
where unit_price BETWEEN 20 AND 600;

-- Retrieve the product_name and category from the Products table, ordering the results by category in ascending order.
SELECT product_name, catagory from Products
Order by catagory ASC;


-------------------- --
--- INTERMEDIATE --- --
-------------------- --

-- Calculate the total quantity_sold of products in the 'Electronics' category.
SELECT SUM(quantity_sold) as tot_
from Sales
join Products on Sales.product_id = Products.product_id
where catagory = "Electronics";

-- Retrieve the product_name and total_price from the Sales table, calculating the total_price as quantity_sold multiplied by unit_price.
select product_name, quantity_sold * unit_price as total_price 
from Sales 
join Products on Sales.product_id = Products.product_id;

-- Identify the Most Frequently Sold Product from Sales table
select product_id, count(*) as sale_count
from Sales
group by product_id
order by sale_count DESC
limit 1;

-- Find the Products Not Sold from Products table
select product_id, product_name
from Products
WHERE product_id not in (
	select distinct product_id from Sales
);

-- Calculate the total revenue generated from sales for each product category.
select p.catagory, SUM(s.total_price) total_rev
from Products p
join Sales s on p.product_id = s.product_id
group by catagory;

-- Find the product category with the highest average unit price.
select catagory, AVG(unit_price) as avg_unit
from Products
-- join Sales s where s.product_id = p.product_id
group by catagory
order by avg_unit desc
limit 1;

-- Identify products with total sales exceeding 30.
select p.product_name 
from Sales s
join Products p on s.product_id = p.product_id
group by p.product_name
having SUM(s.total_price) > 30;


-- Count the number of sales made in each month.
select DATE_FORMAT(sale_date, '%Y-%m') as month_of, COUNT(*) as sales_count
from Sales
join 

-- Retrieve Sales Details for Products with 'Smart' in Their Name

-- Determine the average quantity sold for products with a unit price greater than $100.

-- Retrieve the product name and total sales revenue for each product.

-- List all sales along with the corresponding product names.

-- Retrieve the product name and total sales revenue for each product.

-- Rank products based on total sales revenue.

-- Calculate the running total revenue for each product category.

-- Categorize sales as "High", "Medium", or "Low" based on total price (e.g., > $200 is High, $100-$200 is Medium, < $100 is Low).

-- Identify sales where the quantity sold is greater than the average quantity sold.
