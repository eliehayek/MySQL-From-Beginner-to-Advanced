 -- The basic syntax of the SELECT statement:
 
SELECT select_list
[FROM table_source]
[WHERE search_condition]
[ORDER BY order_by_list]
[LIMIT row_limit]

-- A simple SELECT statement:

SELECT * FROM invoices
 
-- A SELECT statement that retrieves and sorts rows:

SELECT invoice_number, invoice_date, invoice_total
FROM invoices
ORDER BY invoice_total DESC

-- A SELECT statement that retrieves a calculated value:

SELECT invoice_id, invoice_total, credit_total + payment_total AS total_credits
FROM invoices
WHERE invoice_id = 17

-- A SELECT statement that retrieves all invoices between given dates:

SELECT invoice_number, invoice_date, invoice_total
FROM invoices
WHERE invoice_date BETWEEN '2018-06-01' AND '2018-06-30'
ORDER BY invoice_date

-- A SELECT statement that returns an empty result set:

SELECT invoice_number, invoice_date, invoice_total
FROM invoices
WHERE invoice_total > 50000

-- The expanded syntax of the SELECT clause:

SELECT [ALL|DISTINCT]
          column_specification [[AS] result_column]
       [, column_specification [[AS] result_column]] ...
       
-- Column specifications that use base table values
-- The * is used to retrieve all columns:

SELECT *

-- Column names are used to retrieve specific columns:

SELECT vendor_name, vendor_city, vendor_state
 
-- Column specifications that use calculated values:
-- An arithmetic expression that calculates the balance due:

SELECT invoice_total - payment_total – credit_total AS balance_due

-- A function that returns the full name:

SELECT CONCAT(first_name, ' ', last_name) AS full_name
 
-- A SELECT statement that renames the columns in the result set:

SELECT invoice_number AS "Invoice Number", invoice_date AS Date, invoice_total AS Total
FROM invoices
 

 -- A SELECT statement that doesn’t name a calculated column:
 
SELECT invoice_number, invoice_date, invoice_total, invoice_total - payment_total - credit_total 
FROM invoices
 
/*The arithmetic operators in order of precedence:

*		Multiplication		1
/		Division			1
DIV 	Integer division	1	
%		Modulo(remainder)	1
+		Addition			2
-		Substraction		2								*/

-- A SELECT statement that calculates the balance due:


SELECT invoice_total, payment_total, credit_total,
	   invoice_total - payment_total - credit_total AS balance_due
FROM invoices
 
-- Use parentheses to control the sequence of operations:

SELECT	invoice_id,
		invoice_id + 7 * 3 AS multiply_first,
		(invoice_id + 7) * 3 AS add_first
FROM invoices
ORDER BY invoice_id

-- Use the DIV and modulo operators:
   
SELECT 	  invoice_id,
          invoice_id / 3 AS decimal_quotient,
          invoice_id DIV 3 AS integer_quotient,
          invoice_id % 3 AS remainder
FROM invoices
ORDER BY invoice_id

-- The syntax of the CONCAT function:

CONCAT(string1[, string2]...)

-- How to concatenate string data:

SELECT vendor_city, vendor_state,
       CONCAT(vendor_city, vendor_state)
FROM vendors

-- How to format string data using literal values:
   
SELECT vendor_name,
		CONCAT(vendor_city, ', ', vendor_state, ' ', vendor_zip_code) AS address
FROM vendors 

--  How to include apostrophes in literal values:

SELECT  CONCAT(vendor_name, '''s Address: ') AS Vendor,
		CONCAT(vendor_city, ', ', vendor_state, ' ', vendor_zip_code) AS Address
FROM vendors


-- The syntax of the LEFT function:

LEFT(string, number_of_characters)

-- A SELECT statement that uses the LEFT function:

SELECT vendor_contact_first_name, vendor_contact_last_name,
       CONCAT(LEFT(vendor_contact_first_name, 1),LEFT(vendor_contact_last_name, 1)) AS initials
FROM vendors 
 
-- The syntax of the DATE_FORMAT function:

DATE_FORMAT(date, format_string)

-- A SELECT statement that uses the DATE_FORMAT function:
-- To specify the format of a date, you use the percent sign (%) to identify a format code:

SELECT invoice_date,
      DATE_FORMAT(invoice_date, '%m/%d/%y') AS 'MM/DD/YY',
      DATE_FORMAT(invoice_date, '%e-%b-%Y') AS 'DD-Mon-YYYY'
FROM invoices
ORDER BY invoice_date
 
-- The syntax of the ROUND function:
    
ROUND(number[, number_of_decimal_places])

-- A SELECT statement that uses the ROUND function:
    
SELECT invoice_date, invoice_total,
		ROUND(invoice_total) AS nearest_dollar,
		ROUND(invoice_total, 1) AS nearest_dime
FROM invoices
ORDER BY invoice_date
  
-- A SELECT statement that tests a calculation:
   
SELECT 1000 * (1 + .1) AS "10% More Than 1000"
 
-- A SELECT statement that tests the CONCAT function:
   
SELECT "Ed" AS first_name, "Williams" AS last_name,
       CONCAT(LEFT("Ed", 1), LEFT("Williams", 1)) AS initials
       
-- A SELECT statement that tests the DATE_FORMAT function:

SELECT CURRENT_DATE,
    DATE_FORMAT(CURRENT_DATE, '%m/%d/%y') AS 'MM/DD/YY',
    DATE_FORMAT(CURRENT_DATE, '%e-%b-%Y') AS 'DD-Mon-YYYY'
 
-- A SELECT statement that returns all rows:
 
SELECT vendor_city, vendor_state
FROM vendors
ORDER BY vendor_city

-- A SELECT statement that eliminates duplicate rows:
   
SELECT DISTINCT vendor_city, vendor_state
FROM vendors
ORDER BY vendor_city
 
-- The syntax of the WHERE clause with comparison operators:

WHERE expression_1 operator expression_2

-- The comparison operators:

=
<
>
<=
>=
<> 
!=
 
 
-- Examples of WHERE clauses that retrieve...
-- Vendors located in Iowa:

WHERE vendor_state = 'IA’
   
-- Invoices with a balance due (two variations):

WHERE invoice_total – payment_total – credit_total > 0
WHERE invoice_total > payment_total + credit_total

-- Vendors with names from A to L:
   
WHERE vendor_name < 'M’
 
-- Examples of WHERE clauses that retrieve (continued)
-- Invoices on or before a specified date:

WHERE invoice_date <= '2018-07-31’

-- Invoices on or after a specified date:

WHERE invoice_date >= '2018-07-01’

-- Invoices with credits that don’t equal zero (two variations):

WHERE credit_total <> 0
WHERE credit_total != 0

-- The syntax of the WHERE clause with logical operators:

WHERE [NOT] search_condition_1
{AND|OR}
	  [NOT] search_condition_2 ...
      
-- Examples of WHERE clauses that use logical operators:
-- The AND operator

WHERE vendor_state = 'NJ' AND vendor_city = 'Springfield'

-- The OR operator:

WHERE vendor_state = 'NJ' OR vendor_city = 'Pittsburg'

-- The NOT operator:

WHERE NOT vendor_state = 'CA'
 
-- Examples of WHERE clauses that use logical operators (continued):
-- The NOT operator in a complex search condition:

WHERE NOT (invoice_total >= 5000 OR NOT invoice_date <= '2018-08-01')
   
-- The same condition rephrased to eliminate the NOT operator:

WHERE invoice_total < 5000
  AND invoice_date <= '2018-08-01'
  
-- A compound condition without parentheses:

WHERE invoice_date > '2018-07-03' OR invoice_total > 500
  AND invoice_total - payment_total - credit_total > 0

-- The same compound condition with parentheses:

WHERE (invoice_date > '2018-07-03' OR invoice_total > 500)
  AND invoice_total - payment_total - credit_total > 0

-- The syntax of the WHERE clause with an IN phrase:

WHERE test_expression [NOT] IN
	  ({subquery|expression_1 [expression_2]...})

-- Examples of the IN phrase:
-- An IN phrase with a list of numeric literals:

WHERE terms_id IN (1, 3, 4)

-- An IN phrase preceded by NOT:

WHERE vendor_state NOT IN ('CA', 'NV', 'OR')

-- An IN phrase with a subquery:

WHERE vendor_id IN
    (SELECT vendor_id
	FROM invoices
	WHERE invoice_date = '2018-07-18')
 
-- The syntax of the WHERE clause with a BETWEEN phrase:

WHERE test_expression [NOT] BETWEEN
	  begin_expression AND end_expression
      
-- Examples of the BETWEEN phrase:
-- A BETWEEN phrase with literal values:

WHERE invoice_date BETWEEN '2018-06-01' AND '2018-06-30'

-- A BETWEEN phrase preceded by NOT:

WHERE vendor_zip_code NOT BETWEEN 93600 AND 93799

-- A BETWEEN phrase with a test expression coded as a calculated value:
    
WHERE invoice_total - payment_total - credit_total
BETWEEN 200 AND 500
    
-- A BETWEEN phrase with upper and lower limits:

WHERE payment_total
BETWEEN credit_total AND credit_total + 500

-- The syntax of the WHERE clause with a LIKE phrase:

WHERE match_expression [NOT] LIKE pattern 

-- WHERE clauses that use the LIKE operator:

Example 1

WHERE vendor_city LIKE 'SAN%'
-- Cities that will be retrieved 
“San Diego”, “Santa Ana”

Example 2

WHERE vendor_name LIKE 'COMPU_ER%'
-- Vendors that will be retrieved
“Compuserve”, “Computerworld”
 
-- The syntax of the WHERE clause with a REGEXP phrase:

WHERE match_expression [NOT] REGEXP pattern

/* REGEXP special characters and constructs:

^ - Beginning of the string
$ - End of the string
. – Any Character
[charlist]
[char1–char2]
| - Or                                */
   
 
-- WHERE clauses that use REGEXP:

Example 1

WHERE vendor_city REGEXP 'SA'
--Cities that will be retrieved
“Pasadena”, “Santa Ana”

Example 2

WHERE vendor_city REGEXP '^SA'
--Cities that will be retrieved
“Santa Ana”, “Sacramento”

Example 3

WHERE vendor_city REGEXP 'NA$'
--Cities that will be retrieved
“Gardena”, “Pasadena”, “Santa Ana”
 
Example 4

WHERE vendor_city REGEXP 'RS|SN'
--Cities that will be retrieved
“Traverse City”, “Fresno”

Example 5

WHERE vendor_state REGEXP 'N[CV]'
--States that will be retrieved
“NC” and “NV” but not “NJ” or “NY”

Example 6

WHERE vendor_state REGEXP 'N[A-J]'
--States that will be retrieved
“NC” and “NJ” but not “NV” or “NY”

Example 7

WHERE vendor_contact_last_name REGEXP 'DAMI[EO]N'
--Last names that will be retrieved
“Damien” and “Damion”

Example 8

WHERE vendor_city REGEXP '[A-Z][AEIOU]N$'
--Cities that will be retrieved
“Boston”, “Mclean”, “Oberlin”

-- The syntax of the WHERE clause with the IS NULL clause:

WHERE expression IS [NOT] NULL

-- The contents of the Null_Sample table:

SELECT * FROM null_sample

-- A SELECT statement that retrieves rows with zero values:

SELECT * FROM null_sample
WHERE invoice_total = 0

-- A SELECT statement that retrieves rows with non-zero values:

SELECT * FROM null_sample
WHERE invoice_total <> 0

-- A SELECT statement that retrieves rows with null values:

SELECT *
FROM null_sample
WHERE invoice_total IS NULL

-- A SELECT statement that retrieves rows without null values:

SELECT *
FROM null_sample
WHERE invoice_total IS NOT NULL

-- The expanded syntax of the ORDER BY clause:

   ORDER BY expression [ASC|DESC][, expression [ASC|DESC]] ...
   
-- An ORDER BY clause that sorts by one column:

SELECT vendor_name,
       CONCAT(vendor_city, ', ', vendor_state, ' ', vendor_zip_code) AS address
FROM vendors
ORDER BY vendor_name

 /* The default sequence for an ascending sort
 
∙ Null values
∙ Special characters
∙ Numbers
∙ Letters

Note: Null values appear first in the sort sequence, even if you’re using DESC*/
 
-- An ORDER BY clause that sorts by one column in descending sequence:

SELECT vendor_name,
       CONCAT(vendor_city, ', ', vendor_state, ' ', vendor_zip_code) AS address
FROM vendors
ORDER BY vendor_name DESC
 
-- An ORDER BY clause that sorts by three columns:

SELECT vendor_name,
	CONCAT(vendor_city, ', ', vendor_state, ' ', vendor_zip_code) AS address
FROM vendors
ORDER BY vendor_state, vendor_city, vendor_name
 
-- An ORDER BY clause that uses an alias:

SELECT vendor_name,
       CONCAT(vendor_city, ', ', vendor_state, ' ', vendor_zip_code) AS address
FROM vendors
ORDER BY address, vendor_name

-- An ORDER BY clause that uses an expression:

SELECT vendor_name,
       CONCAT(vendor_city, ', ', vendor_state, ' ', vendor_zip_code) AS address
FROM vendors
ORDER BY CONCAT(vendor_contact_last_name, vendor_contact_first_name)
 
-- An ORDER BY clause that uses column positions:

SELECT vendor_name,
       CONCAT(vendor_city, ', ', vendor_state, ' ', vendor_zip_code) AS address
FROM vendors
ORDER BY 2, 1
 

-- The expanded syntax of the LIMIT clause:

LIMIT [offset,] row_count

-- A SELECT statement with a LIMIT clause that starts with the first row:

SELECT vendor_id, invoice_total
FROM invoices
ORDER BY invoice_total DESC
LIMIT 5

-- A SELECT statement with a LIMIT clause that starts with the third row:

SELECT invoice_id, vendor_id, invoice_total
FROM invoices
ORDER BY invoice_id
LIMIT 2, 3
 
-- A SELECT statement with a LIMIT clause that starts with the 101st row:

SELECT invoice_id, vendor_id, invoice_total
FROM invoices
ORDER BY invoice_id
LIMIT 100, 1000
 



 




 