# Summery Queries Lab

1. Write a SELECT statement that returns these columns:

The count of the number of orders in the Orders table named order_count
The sum of the tax_amount columns in the Orders table named tax_total
The average of the tax_amount columns in the Orders table named tax_average.

```sql
SELECT 	COUNT(*) AS order_count,
	SUM(tax_amount) AS tax_total,
	AVG(tax_amount) AS tax_average
FROM orders 
```


2. Write a SELECT statement that returns one row for each category that has products with these columns:

The category_name column from the Categories table
The count of the products in the Products table aliased as product_count
The list price of the most expensive product in the Products table aliased as most_expensive_product
Sort the result set so the category with the most products appears first.

```sql
SELECT 	c.category_name, 
	COUNT(p.product_id) AS product_count,
        MAX(p.list_price) AS most_expensive_product
        
FROM 	categories c 
	JOIN 
	products p ON c.category_id = p.category_id
        
GROUP BY c.category_name
ORDER BY product_count DESC 
```

3. Write a SELECT statement that returns one row for each customer that has orders with these columns:

The email_address column from the Customers table
The sum of the item price in the Order_Items table multiplied by the quantity in the Order_Items table aliased as item_price_total
The sum of the discount amount column in the Order_Items table multiplied by the quantity in the Order_Items table aliased as discount_amount_total
Sort the result set in descending sequence by the item price total for each customer.

```sql
SELECT  c.email_address AS email,
        SUM(oi.item_price * quantity) AS item_price_total,
        SUM(oi.discount_amount * quantity) AS discount_total
	
FROM 	customers c
        JOIN
	orders o ON c.customer_id = o.customer_id
        JOIN
	order_items oi ON o.order_id = oi.order_id
        
GROUP BY c.email_address
ORDER BY item_price_total ASC 
```

4. Write a SELECT statement that returns one row for each customer that has orders with these columns:

The email_address column from the Customers table
A count of the number of orders aliased as order_count
The total amount for each order aliased as order_total (Hint: First, subtract the discount amount from the price. Then, multiply by the quantity.)
Return only those rows where the customer has more than 1 order.
Sort the result set in descending sequence by the sum of the line item amounts.

```sql
SELECT  c.email_address AS email,
	COUNT(o.order_id) AS order_count,
        SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS order_total
        
FROM 	customers c 
	JOIN 
        orders o ON c.customer_id = o.customer_id
        JOIN 
        order_items oi ON o.order_id = oi.order_id
        
GROUP BY c.email_address
HAVING order_count > 1 
ORDER BY order_total DESC 
```


5. Modify the solution to lab 4 so it only counts and totals line items that have an item_price value that’s greater than 400.

Here are the directions for lab 4:
Write a SELECT statement that returns one row for each customer that has orders with these columns:

The email_address column from the Customers table
A count of the number of orders aliased as order_count
The total amount for each order aliased as order_total (Hint: First, subtract the discount amount from the price. Then, multiply by the quantity.)
Return only those rows where the customer has more than 1 order.
Sort the result set in descending sequence by the sum of the line item amounts.

```sql
SELECT  c.email_address AS email,
        COUNT(o.order_id) AS order_count,
        SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS order_total
        
FROM 	customers c 
        JOIN 
        orders o ON c.customer_id = o.customer_id
        JOIN 
        order_items oi ON o.order_id = oi.order_id
        
WHERE oi.item_price > 400        
GROUP BY c.email_address
HAVING order_count > 1 
ORDER BY order_total DESC 
```
