# Functions Lab

1. Write a SELECT statement that returns these columns from the Products table:
The list_price column
The discount_percent column
A column named discount_amount that uses the previous two columns to calculate the discount amount 
and uses the ROUND function to round the result so it has 2 decimal digits
Sort the result set by the discount_amount column in ascending sequence. 

```sql
SELECT  list_price, 
        discount_percent,
	ROUND(list_price * (discount_percent / 100), 2) AS discount_amount
FROM products
```

2. Write a SELECT statement that returns these columns from the Orders table:
The order_date column
A column that uses the DATE_FORMAT function to return the four-digit year that’s stored in the order_date column.  Alias the column order_year
A column that uses the DATE_FORMAT function to return the order_date column in this format: Mon-DD-YYYY. 
In other words, use abbreviated months and separate each date component with dashes. Alias the column order_date_formatted
A column that uses the DATE_FORMAT function to return the order_date column with only the hours and minutes on a 12-hour clock with an am/pm indicator. 
Alias the column order_time
A column that uses the DATE_FORMAT function to return the order_date column in this format: MM/DD/YY HH:MM. In other words, use two-digit months, days, 
and years and separate them by slashes. Use 2-digit hours and minutes on a 24-hour clock. And use leading zeros for all date/time components. 
Alias the column  order_datetime
Sort the result set by the order_date column in ascending sequence. 




3. Write a SELECT statement that returns these columns from the Orders table:
The card_number column
The length of the card_number column aliased as card_number_length
The last four digits of the card_number column aliased as last_four_digits
A column that displays an X for each digit of the card_number column except for the last four digits. 
If the card number contains 16 digits, it should be displayed in this format: XXXX-XXXX-XXXX-1234, 
where 1234 are the actual last four digits of the number. If the card number contains 15 digits, 
it should be displayed in this format: XXXX-XXXXXX-X1234. (Hint: Use an IF function to determine which format to use.).  
This column should be aliased as formatted_number
Sort the result set by the card_number column in ascending sequence.


4. Write a SELECT statement that returns these columns from the Orders table:
The order_id column
The order_date column
A column named approx_ship_date that’s calculated by adding 2 days to the order_date column
The ship_date column if it doesn’t contain a null value
A column named days_to_ship that shows the number of days between the order date and the ship date
add a WHERE clause that retrieves just the orders for March 2018 that have shipped.
Sort the result set by the order_id column in ascending sequence. 

