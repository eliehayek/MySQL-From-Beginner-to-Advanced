/* Write a SELECT statement that returns four columns from the Products table: 
product_code, product_name, list_price, and discount_percent. 
Add an ORDER BY clause to this statement that sorts the result set by list price in descending sequence */


SELECT product_code, product_name, list_price, discount_percent
FROM products
ORDER BY list_price DESC 


/* Write a SELECT statement that returns three columns from the Customers table named 
first_name, last_name and full_name that combines the last_name and first_name columns.

Format this column with the last name, a comma, a space, and the first name like this:
Doe, John

Sort the result set by the last_name column in ascending sequence.
Return only the customers whose last name begins with letters from M to Z.
NOTE: When comparing strings of characters, ‘M’ comes before any string of characters that begins with ‘M’. 
For example, ‘M’ comes before ‘Murach’ */


SELECT  first_name, last_name, 
		CONCAT(last_name, ', ',first_name) AS full_name
FROM customers
WHERE last_name <= 'M'
ORDER BY last_name ASC 
        

/* Write a SELECT statement that returns these columns from the Products table:
product_name The product_name column
list_price The list_price column
date_added The date_added column
Return only the rows with a list price that’s greater than 500 and less than 2000.
Sort the result set by the date_added column in descending sequence */


SELECT product_name, list_price, date_added
FROM products
WHERE list_price BETWEEN 500 AND 2000
ORDER BY date_added DESC 


/* Write a SELECT statement that returns these column names and data from the Products table:
product_name The product_name column
list_price The list_price column
discount_percent The discount_percent column
discount_amount A column that’s calculated from the previous two columns
discount_price A column that’s calculated from the previous three columns
Round the discount_amount and discount_price columns to 2 decimal places.
Sort the result set by the discount_price column in descending sequence.
Use the LIMIT clause so the result set contains only the first 5 rows */


SELECT  product_name AS 'The product name',
		list_price AS 'The list price',
		discount_percent AS 'The discount percent',
		ROUND(list_price * (discount_percent / 100), 2) AS 'The discount amount',
		ROUND(list_price - list_price * (discount_percent / 100), 2) AS 'The discount price'
FROM products
ORDER BY (list_price - list_price * (discount_percent / 100)) DESC
LIMIT 5 


/* Write a SELECT statement that returns these column names and data from the Order_Items table:
-item_id The item_id column
-item_price The item_price column
-discount_amount The discount_amount column
-quantity The quantity column
-price_total A column that’s calculated by multiplying the item price by the quantity
-discount_total A column that’s calculated by multiplying the discount amount by the quantity
-item_total A column that’s calculated by subtracting the discount
amount from the item price and then multiplying by the quantity.
Only return rows where the item_total is greater than 500.
Sort the result set by item total in descending sequence */


SELECT 	item_id AS 'The item id',
		item_price AS 'The item price',
		discount_amount AS 'The discount amount',
		quantity AS 'The quantity',
		(item_price * quantity) AS 'The price total',
		(discount_amount * quantity) AS 'The discount_total',
		((item_price - discount_amount) * quantity) AS 'The item total'
FROM order_items
WHERE ((item_price - discount_amount) * quantity) > 500
ORDER BY ((item_price - discount_amount) * quantity) DESC 



/* Write a SELECT statement that returns these columns from the Orders table:
-order_id The order_id column
-order_date The order_date column
-ship_date The ship_date column
Return only the rows where the ship_date column contains a null value */


SELECT order_id AS 'The order id',
	   order_date AS 'The order date',
       ship_date AS 'The ship date'
FROM orders
WHERE ship_date IS NULL



/* Write a SELECT statement without a FROM clause that creates a row with these columns:
-price 100 (dollars)
-tax_rate .07 (7 percent)
-tax_amount The price multiplied by the tax
-total The price plus the tax 
To calculate the fourth column, add the expressions you used for the first and third */


SELECT  100 AS price,
		0.07 AS tax_rate,
		100 * 0.07 AS tax_amount,
		100 + 0.07 * 100 AS total


