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

-- id, name cata, utit_price

CREATE TABLE Product (
	product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2)
); 

ALTER TABLE Product RENAME TO Products;

INSERT INTO Products (product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'Electronics', 500.00),
(102, 'Smartphone', 'Electronics', 300.00),
(103, 'Headphones', 'Electronics', 30.00),
(104, 'Keyboard', 'Electronics', 20.00),
(105, 'Mouse', 'Electronics', 15.00);

-- 1. Retrieve all columns from the Sales table.
SELECT * FROM Sales;
SELECT * FROM Products;

-- 2. Retrieve the product_name and unit_price from the Products table.
SELECT product_name, unit_price FROM Products;
SELECT sale_id, sale_date FROM Sales;

-- 4. Filter the Sales table to show only sales with a total_price greater than $100.
SELECT * FROM Sales WHERE total_price > 100;

-- 5. Filter the Products table to show only products in the 'Electronics' category.
SELECT * FROM Products WHERE category = "Electronics";

-- 6. Retrieve the sale_id and total_price from the Sales table for sales made on January 3, 2024.
SELECT sale_id, total_price FROM Sales WHERE sale_date = '2024-01-03';

-- 7. Retrieve the product_id and product_name from the Products table for products with a unit_price greater than $100
SELECT product_id, product_name from Products WHERE unit_price > 100;

-- 8. Calculate the total revenue generated from all sales in the Sales table.
SELECT SUM(total_price) AS total_revenue FROM Sales;

-- 9. Calculate the average unit_price of products in the Products table.
SELECT AVG(unit_price) as avg_unit from Products;

-- 10. Calculate the total quantity_sold from the Sales table.
SELECT SUM(quantity_sold) AS total_sales FROM Sales;
 
-- 11. Count Sales Per Day from the Sales table
SELECT sale_date, SUM(quantity_sold) as sale_count 
from Sales 
group by sale_date;

-- 12. Retrieve product_name and unit_price from the Products table with the Highest Unit Price

select product_name, unit_price 
from Products
order by unit_price DESC
limit 1;

-- 13. Retrieve the sale_id, product_id, and total_price from the Sales table for sales with a quantity_sold greater than 4.
select sale_id, product_id, total_price from sales
where quantity_sold > 4;

-- 14. Retrieve the product_name and unit_price from the Products table, ordering the results by unit_price in descending order
select product_name, unit_price from Products
order by unit_price DESC;

-- 15. Retrieve the total_price of all sales, rounding the values to two decimal places
select ROUND(SUM(total_price), 2) as total from Sales;

-- 16. Calculate the average total_price of sales in the Sales table
select ROUND(AVG(total_price), 2) as av_pr from Sales;

-- 17. Retrieve the sale_id and sale_date from the Sales table, formatting the sale_date as 'YYYY-MM-DD'
select sale_id, date_format(sale_date, '%Y-%m-%d') as Date_ from Sales;

-- 18. Calculate the total revenue generated from sales of products in the 'Electronics' category.
Select SUM(total_price) as total 
from Sales 
join Products on Sales.product_id = Products.product_id
WHERE Products.category="Electronics";

-- 19. Retrieve the product_name and unit_price from the Products table, filtering the unit_price to show only values between $20 and $600.
SELECT product_name, unit_price from Products
where unit_price BETWEEN 20 AND 600;

-- 20. Retrieve the product_name and category from the Products table, ordering the results by category in ascending order.
SELECT product_name, category from Products
Order by category ASC;


-------------------- --
--- INTERMEDIATE --- --
-------------------- --

-- 1. Calculate the total quantity_sold of products in the 'Electronics' category.
SELECT SUM(quantity_sold) as tot_
from Sales
join Products on Sales.product_id = Products.product_id
where category = "Electronics";

-- 2. Retrieve the product_name and total_price from the Sales table, calculating the total_price as quantity_sold multiplied by unit_price.
select product_name, quantity_sold * unit_price as total_price 
from Sales 
join Products on Sales.product_id = Products.product_id;

-- 3. Identify the Most Frequently Sold Product from Sales table
select product_id, count(*) as sale_count
from Sales
group by product_id
order by sale_count DESC
limit 1;

-- 4. Find the Products Not Sold from Products table
select product_id, product_name
from Products
WHERE product_id not in (
	select distinct product_id from Sales
);

-- 5. Calculate the total revenue generated from sales for each product category.
select p.category, SUM(s.total_price) total_rev
from Products p
join Sales s on p.product_id = s.product_id
group by category;

-- 6. Find the product category with the highest average unit price.
select category, AVG(unit_price) as avg_unit
from Products

-- join Sales s where s.product_id = p.product_id
group by category
order by avg_unit desc
limit 1;

-- 7. Identify products with total sales exceeding 30.
select p.product_name 
from Sales s
join Products p on s.product_id = p.product_id
group by p.product_name
having SUM(s.total_price) > 30;


-- 8. Count the number of sales made in each month.
select DATE_FORMAT(sale_date, '%Y-%m') as month_, COUNT(*) as sales_
from Sales
group by month_ ;


-- 9. Retrieve Sales Details for Products with 'Smart' in Their Name
select * 
from Sales s
join Products p on s.product_id = p.product_id
where p.product_name like '%Smart%';
 
-- 10. Determine the average quantity sold for products with a unit price greater than $100.
select AVG(quantity_sold) as avg_sale
from Products p
join Sales s on s.product_id = p.product_id
where p.unit_price > 100;

-- 11. Retrieve the product name and total sales revenue for each product.
select p.product_name, SUM(s.total_price) as total_rev
from Sales s
join Products p on s.product_id = p.product_id
group by p.product_name;

-- 12. List all sales along with the corresponding product names.
select s.sale_id, p.product_name  
from Sales s
join products p on s.product_id = p.product_id;

-- 13. Incorrect question in GFG
select p.category, 
	SUM(s.total_price) as category_total,
    (SUM(s.total_price) / (select sum(total_price) from Sales)) * 100 as Percentage_rev
from Sales s
join products p on s.product_id = p.product_id
group by p.category
order by Percentage_rev DESC
limit 1;
    
-- 14. Rank products based on total sales revenue.
select p.product_name, SUM(s.total_price) as total_reve,
	RANK() OVER (ORDER BY SUM(s.total_price) DESC) AS revenue_rank
from Sales s
join products p on s.product_id = p.product_id
group by p.product_name;

-- 15. Calculate the running total revenue for each product category.
select p.category, p.product_name, s.sale_date, 
    SUM(s.total_price) OVER (partition by p.category order by s.sale_date) as running_total
from Sales s
join Products p on s.product_id = p.product_id;

-- 16. Categorize sales as "High", "Medium", or "Low" based on total price (e.g., > $200 is High, $100-$200 is Medium, < $100 is Low).
select * ,
	case 
		WHEN total_price > 200 THEN "High"
--      WHEN total_price BETWEEN 100 AND 200 THEN "Mid"
        WHEN total_price > 100 THEN "Mid"
        else "low"
	end as price_category
from sales;

-- 17. Identify sales where the quantity sold is greater than the average quantity sold.
-- subquery
-- select AVG(quantity_sold) from Sales; 

select * 
from Sales
where quantity_sold > (
	select AVG(quantity_sold) from Sales
);

-- 18. Extract the month and year from the sale date and count the number of sales for each month.
select date_format(sale_date, "%Y-%m") as Date_Y_m, COUNT(*) as sale_cnt
from Sales
group by Date_Y_m;

-- 19. Calculate the number of days between the current date and the sale date for each sale.
select sale_id, datediff(NOW(), sale_date) as days_since_sale
from Sales;

select sale_id, CONCAT(
		timestampdiff(YEAR, sale_date, NOW()), ' years, ',
        TIMESTAMPDIFF(MONTH, sale_date, NOW()) % 12, ' months, ',
        DATEDIFF(NOW(), sale_date) - TIMESTAMPDIFF(MONTH, sale_date, NOW()) * 30, ' days'
    ) as days_since_sale
from Sales;


-- 20. Identify sales made during weekdays versus weekends.
select sale_id,dayofweek(sale_date),
	CASE
		WHEN dayofweek(sale_date) != 1 -- Sunday 
			 or dayofweek(sale_date) != 7 -- Saturday
				THEN "Weekday"
        ELSE "Weekend"
    END as dat_type
from sales;