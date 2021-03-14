-- The syntax of the aggregate functions

AVG([ALL|DISTINCT] expression)
SUM([ALL|DISTINCT] expression)
MIN([ALL|DISTINCT] expression)
MAX([ALL|DISTINCT] expression)
COUNT([ALL|DISTINCT] expression)
COUNT(*)

-- A summary query:

SELECT COUNT(*) AS number_of_invoices,
       SUM(invoice_total – payment_total – credit_total) AS total_due
FROM invoices
WHERE invoice_total – payment_total – credit_total > 0
 
-- A summary query with COUNT(*), AVG, and SUM:

SELECT 'After 1/1/2018' AS selection_date,
       COUNT(*) AS number_of_invoices,
       ROUND(AVG(invoice_total), 2) AS avg_invoice_amt,
       SUM(invoice_total) AS total_invoice_amt
FROM invoices
WHERE invoice_date > '2018-01-01'
 
-- A summary query with MIN and MAX:

SELECT 'After 1/1/2018' AS selection_date,
       COUNT(*) AS number_of_invoices,
       MAX(invoice_total) AS highest_invoice_total,
       MIN(invoice_total) AS lowest_invoice_total
FROM invoices
WHERE invoice_date > '2018-01-01'

-- A summary query for non-numeric columns:

SELECT MIN(vendor_name) AS first_vendor,
       MAX(vendor_name) AS last_vendor,
       COUNT(vendor_name) AS number_of_vendors
FROM vendors

-- A summary query with the DISTINCT keyword:

SELECT COUNT(DISTINCT vendor_id) AS number_of_vendors,
       COUNT(vendor_id) AS number_of_invoices,
       ROUND(AVG(invoice_total), 2) AS avg_invoice_amt,
       SUM(invoice_total) AS total_invoice_amt
FROM invoices
WHERE invoice_date > '2018-01-01'
 
-- The syntax of a SELECT statement with GROUP BY and HAVING clauses:

SELECT select_list
FROM table_source
[WHERE search_condition]
[GROUP BY group_by_list]
[HAVING search_condition]
[ORDER BY order_by_list]

-- A summary query that calculates the average invoice amount by vendor:

SELECT vendor_id, ROUND(AVG(invoice_total), 2) AS average_invoice_amount
FROM invoices
GROUP BY vendor_id
HAVING AVG(invoice_total) > 2000
ORDER BY average_invoice_amount DESC

-- A summary query that includes a functionally dependent column:

SELECT vendor_name, vendor_state,
     ROUND(AVG(invoice_total), 2) AS average_invoice_amount
FROM vendors JOIN invoices
     ON vendors.vendor_id = invoices.vendor_id
GROUP BY vendor_name
HAVING AVG(invoice_total) > 2000
ORDER BY average_invoice_amount DESC
 
-- A summary query that counts the number of invoices by vendor:

SELECT vendor_id, COUNT(*) AS invoice_qty
FROM invoices
GROUP BY vendor_id

-- A summary query with a join:

SELECT vendor_state, vendor_city, COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total), 2) AS invoice_avg
FROM invoices JOIN vendors
    ON invoices.vendor_id = vendors.vendor_id
GROUP BY vendor_state, vendor_city
ORDER BY vendor_state, vendor_city
 
 -- A summary query that limits the groups to those with two or more invoices:
 
SELECT vendor_state, vendor_city, COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total), 2) AS invoice_avg
FROM invoices JOIN vendors
    ON invoices.vendor_id = vendors.vendor_id
GROUP BY vendor_state, vendor_city
HAVING COUNT(*) >= 2
ORDER BY vendor_state, vendor_city
 
-- A summary query with a search condition in the HAVING clause:
  
SELECT vendor_name,
       COUNT(*) AS invoice_qty,
       ROUND(AVG(invoice_total), 2) AS invoice_avg
FROM vendors JOIN invoices
       ON vendors.vendor_id = invoices.vendor_id
GROUP BY vendor_name
HAVING AVG(invoice_total) > 500
ORDER BY invoice_qty DESC

-- A summary query with a search condition in the WHERE clause:

SELECT vendor_name,
       COUNT(*) AS invoice_qty,
       ROUND(AVG(invoice_total), 2) AS invoice_avg
FROM vendors JOIN invoices
       ON vendors.vendor_id = invoices.vendor_id
WHERE invoice_total > 500
GROUP BY vendor_name
ORDER BY invoice_qty DESC
 
-- A summary query with a compound condition in the HAVING clause:
   
SELECT invoice_date,
       COUNT(*) AS invoice_qty,
       SUM(invoice_total) AS invoice_sum
FROM invoices
GROUP BY invoice_date
HAVING invoice_date BETWEEN '2018-05-01' AND '2018-05-31'
       AND COUNT(*) > 1
       AND SUM(invoice_total) > 100
ORDER BY invoice_date DESC  

-- The same query coded with a WHERE clause:

SELECT invoice_date,
       COUNT(*) AS invoice_qty,
       SUM(invoice_total) AS invoice_sum
FROM invoices
WHERE invoice_date BETWEEN '2018-05-01' AND '2018-05-31'
GROUP BY invoice_date
HAVING COUNT(*) > 1 AND SUM(invoice_total) > 100
ORDER BY invoice_date DESC

-- A summary query with a final summary row:

SELECT vendor_id, COUNT(*) AS invoice_count,
       SUM(invoice_total) AS invoice_total
FROM invoices
GROUP BY vendor_id WITH ROLLUP
    
-- A summary query with a summary row for each grouping level:

SELECT vendor_state, vendor_city, COUNT(*) AS qty_vendors
FROM vendors
WHERE vendor_state IN ('IA', 'NJ')
GROUP BY vendor_state, vendor_city WITH ROLLUP
 
-- The basic syntax of the GROUPING function:

GROUPING(expression)

-- A summary query that uses WITH ROLLUP on a table with null values:

SELECT invoice_date, payment_date,
          SUM(invoice_total) AS invoice_total,
          SUM(invoice_total - credit_total - payment_total)
AS balance_due
FROM invoices
WHERE invoice_date BETWEEN '2018-07-24' AND '2018-07-31'
GROUP BY invoice_date, payment_date WITH ROLLUP

-- A query that substitutes literals for nulls in summary rows:

SELECT IF(GROUPING(invoice_date) = 1, 'Grand totals', invoice_date) AS invoice_date,
	   IF(GROUPING(payment_date) = 1, 'Invoice date totals', payment_date) AS payment_date,
          SUM(invoice_total) AS invoice_total,
          SUM(invoice_total - credit_total - payment_total) AS balance_due
FROM invoices
WHERE invoice_date BETWEEN '2018-07-24' AND '2018-07-31'
GROUP BY invoice_date, payment_date WITH ROLLUP
 
-- A query that displays only summary rows:

SELECT IF(GROUPING(invoice_date) = 1, 'Grand totals', invoice_date) AS invoice_date,
       IF(GROUPING(payment_date) = 1, 'Invoice date totals', payment_date) AS payment_date,
       SUM(invoice_total) AS invoice_total,
       SUM(invoice_total - credit_total - payment_total) AS balance_due
FROM invoices
WHERE invoice_date BETWEEN '2018-07-24' AND '2018-07-31'
GROUP BY invoice_date, payment_date WITH ROLLUP
HAVING GROUPING(invoice_date) = 1 OR GROUPING(payment_date) = 1

-- The basic syntax of the OVER clause:

OVER([PARTITION BY expression1 [, expression2]...
        [ORDER BY expression1 [ASC|DESC]
               [, expression2 [ASC|DESC]]...)
               

-- A SELECT statement with two aggregate window functions:

SELECT vendor_id, invoice_date, invoice_total,
          SUM(invoice_total)   OVER()     AS total_invoices,
          SUM(invoice_total)   OVER(PARTITION BY vendor_id)   AS vendor_total
FROM invoices
WHERE invoice_total > 5000
  
-- A SELECT statement with a cumulative total:

SELECT vendor_id, invoice_date, invoice_total,
          SUM(invoice_total)   OVER()     AS total_invoices,
          SUM(invoice_total)   OVER(PARTITION BY vendor_id ORDER BY invoice_total) AS vendor_total
FROM invoices
WHERE invoice_total > 5000

-- The syntax for defining a frame:

   {ROWS | RANGE} {frame_start | BETWEEN frame_start AND frame_end}
                   
-- Possible values for frame_start and frame_end:

CURRENT ROW
UNBOUNDED PRECEDING
UNBOUNDED FOLLOWING
expr PRECEDING
expr FOLLOWING
 
-- A SELECT statement that defines a frame:

SELECT vendor_id, invoice_date, invoice_total,
       SUM(invoice_total) OVER() AS total_invoices,
       SUM(invoice_total) OVER(PARTITION BY vendor_id ORDER BY invoice_date 
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS vendor_total
FROM invoices
WHERE invoice_date BETWEEN '2018-04-01' AND '2018-04-30'
 
-- A SELECT statement that creates peer groups:

SELECT vendor_id, invoice_date, invoice_total,
       SUM(invoice_total) OVER() AS total_invoices,
       SUM(invoice_total) OVER(PARTITION BY vendor_id ORDER BY invoice_date
         RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS vendor_total
FROM invoices
WHERE invoice_date BETWEEN '2018-04-01' AND '2018-04-30'
    
-- A SELECT statement that calculates moving averages:

SELECT MONTH(invoice_date) AS month,
       SUM(invoice_total) AS total_invoices,
       ROUND(AVG(SUM(invoice_total)) OVER(ORDER BY MONTH(invoice_date)
         RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) AS 3_month_avg
FROM invoices
GROUP BY MONTH(invoice_date)
    
-- The syntax for naming a window:

WINDOW window_name AS
    ([partition_clause] [order_clause] [frame_clause])
    
-- A SELECT statement with four functions that use the same window:

SELECT vendor_id, invoice_date, invoice_total,
       SUM(invoice_total) OVER(PARTITION BY vendor_id) AS vendor_total,
       ROUND(AVG(invoice_total) OVER(PARTITION BY vendor_id), 2) AS vendor_avg,
       MAX(invoice_total) OVER(PARTITION BY vendor_id) AS vendor_max,
       MIN(invoice_total) OVER(PARTITION BY vendor_id) AS vendor_min
FROM invoices
WHERE invoice_total > 5000

-- A SELECT statement with a named window:

SELECT vendor_id, invoice_date, invoice_total,
       SUM(invoice_total) OVER vendor_window AS vendor_total,
       ROUND(AVG(invoice_total) OVER vendor_window, 2) AS vendor_avg,
       MAX(invoice_total) OVER               AS vendor_max,
       MIN(invoice_total) OVER               AS vendor_min
FROM invoices
WHERE invoice_total > 5000
WINDOW vendor_window AS (PARTITION BY vendor_id)

 
-- A SELECT statement that adds to the specification for a named window:

SELECT vendor_id, invoice_date, invoice_total,
       SUM(invoice_total)  OVER (vendor_window ORDER BY invoice_date ASC) AS invoice_date_asc,
       SUM(invoice_total)  OVER (vendor_window ORDER BY invoice_date DESC) AS invoice_date_desc
FROM invoices
WHERE invoice_total > 5000
WINDOW vendor_window AS (PARTITION BY vendor_id)
 
    
 