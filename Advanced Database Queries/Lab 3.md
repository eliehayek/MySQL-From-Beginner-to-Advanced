# Data types Lab


1. Write a SELECT statement that returns these columns from the Products table:
The list_price column
A column that uses the FORMAT function to return the list_price column with 1 digit to the right of the decimal point.  
Name this column price_format
A column that uses the CONVERT function to return the list_price column as an integer.  
Name this column price_convert
A column that uses the CAST function to return the list_price column as an integer.  
Name this column price_cast
Sort the result set by the list_price column in ascending sequence. 

```sql
SELECT FORMAT(list_price,1)  AS list_price,
	   CONVERT(list_price, UNSIGNED)    AS price_format,
       CAST(list_price AS UNSIGNED)      AS price_cast
FROM products
ORDER BY list_price ASC
```

2. Write a SELECT statement that returns these columns from the Products table:
The date_added column
A column that uses the CAST function to return the date_added column with its date only (year, month, and day). Name this column added_date
A column that uses the CAST function to return the date_added column with just the year and the month.  Name this column added_char7
A column that uses the CAST function to return the date_added column with its full time only (hour, minutes, and seconds). Name this column added_time
Sort the result set by the date_added column in ascending sequence. 


```sql
SELECT CAST(date_added AS DATE) AS added_date,
	   CAST(date_added AS CHAR(7)) AS added_char7,
       CAST(date_added AS TIME) AS added_time
FROM products 
ORDER BY date_added
```




