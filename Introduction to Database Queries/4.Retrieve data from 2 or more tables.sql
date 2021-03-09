--The explicit syntax for an inner join:
 
SELECT select_list
FROM table_1
       [INNER] JOIN table_2
           ON join_condition_1
      [[INNER] JOIN table_3
           ON join_condition_2]...

--An inner join of the Vendors and Invoices tables:
 
SELECT invoice_number, vendor_name
FROM vendors INNER JOIN invoices

--The syntax for an inner join that uses table aliases:

SELECT select_list
FROM table_1 a1
       [INNER] JOIN table_2 a2
           ON a1.column_name operator a2.column_name
      [[INNER] JOIN table_3 a3
           ON a2.column_name operator a3.column_name]...
           
--An inner join with aliases for all tables:

SELECT invoice_number, vendor_name, invoice_due_date,
       invoice_total - payment_total - credit_total
       AS balance_due
FROM vendors v JOIN invoices i
       ON v.vendor_id = i.vendor_id
WHERE invoice_total - payment_total - credit_total > 0
ORDER BY invoice_due_date DESC

--An inner join with an alias for only one table:

SELECT invoice_number, line_item_amount,
       line_item_description
FROM invoices JOIN invoice_line_items line_items
       ON invoices.invoice_id = line_items.invoice_id
WHERE account_number = 540
ORDER BY invoice_date

--The syntax of a table name that’s qualified with a database name:

database_name.table_name

--A join to a table in another database:

SELECT vendor_name, customer_last_name,
      customer_first_name, vendor_state AS state,
      vendor_city AS city
FROM vendors v
      JOIN om.customers c
      ON v.vendor_zip_code = c.customer_zip
ORDER BY state, city

--An inner join with two conditions: 

SELECT customer_first_name, customer_last_name
FROM customers c JOIN employees e
       ON c.customer_first_name = e.first_name
      AND c.customer_last_name = e.last_name
      
--A self-join that returns vendors from cities in common with other vendors:

SELECT DISTINCT v1.vendor_name, v1.vendor_city,
       v1.vendor_state
FROM vendors v1 JOIN vendors v2
       ON v1.vendor_city = v2.vendor_city AND
          v1.vendor_state = v2.vendor_state AND
          v1.vendor_name <> v2.vendor_name
ORDER BY v1.vendor_state, v1.vendor_city
 
--A statement that joins four tables:

SELECT vendor_name, invoice_number, invoice_date,
       line_item_amount, account_description
FROM vendors v
       JOIN invoices i
           ON v.vendor_id = i.vendor_id
       JOIN invoice_line_items li
           ON i.invoice_id = li.invoice_id
       JOIN general_ledger_accounts gl
           ON li.account_number = gl.account_number
WHERE invoice_total - payment_total - credit_total > 0
ORDER BY vendor_name, line_item_amount DESC
 
--The implicit syntax for an inner join:

SELECT select_list
FROM table_1, table_2 [, table_3]...
WHERE table_1.column_name operator table_2.column_name
 [AND table_2.column_name operator table_3.column_name]...
 
--Join the Vendors and Invoices tables:

SELECT invoice_number, vendor_name
FROM vendors v, invoices i
WHERE v.vendor_id = i.vendor_id
ORDER BY invoice_number

--Join four tables:

SELECT vendor_name, invoice_number, invoice_date,
       line_item_amount, account_description
FROM  vendors v, invoices i, invoice_line_items li,
       general_ledger_accounts gl
WHERE v.vendor_id = i.vendor_id
     AND i.invoice_id = li.invoice_id
     AND li.account_number = gl.account_number
     AND invoice_total - payment_total - credit_total > 0
ORDER BY vendor_name, line_item_amount DESC

--The explicit syntax for an outer join:

SELECT select_list
FROM table_1
       {LEFT|RIGHT} [OUTER] JOIN table_2
           ON join_condition_1
      [{LEFT|RIGHT} [OUTER] JOIN table_3
           ON join_condition_2]...
           
--A left outer join of the Vendors and Invoices tables:

SELECT vendor_name, invoice_number, invoice_total
FROM vendors LEFT JOIN invoices
       ON vendors.vendor_id = invoices.vendor_id
ORDER BY vendor_name

--A left outer join:

SELECT department_name, d.department_number, last_name
FROM departments d
       LEFT JOIN employees e
       ON d.department_number = e.department_number
ORDER BY department_name

--A right outer join:

SELECT department_name, e.department_number, last_name
FROM departments d
       RIGHT JOIN employees e
       ON d.department_number = e.department_number
ORDER BY department_name

--Join three tables using left outer joins:

SELECT department_name, last_name, project_number
FROM departments d
       LEFT JOIN employees e
           ON d.department_number = e.department_number
       LEFT JOIN projects p
           ON e.employee_id = p.employee_id
ORDER BY department_name, last_name
 
--Combine an outer and an inner join:
 
SELECT department_name, last_name, project_number
FROM departments d
       JOIN employees e
           ON d.department_number = e.department_number
       LEFT JOIN projects p
           ON e.employee_id = p.employee_id
ORDER BY department_name, last_name


--The syntax for a join that uses the USING keyword:

SELECT select_list
FROM table_1
        [{LEFT|RIGHT} [OUTER]] JOIN table_2
            USING (join_column_1[, join_column_2]...)
       [[{LEFT|RIGHT} [OUTER]] JOIN table_3
            USING (join_column_1[, join_column_2]...)]...

--Use the USING keyword to join two tables:

SELECT invoice_number, vendor_name
FROM vendors
        JOIN invoices USING (vendor_id)
ORDER BY invoice_number

--Use the USING keyword to join three tables:

SELECT department_name, last_name, project_number
FROM departments
       JOIN employees USING (department_number)
       LEFT JOIN projects USING (employee_id)
ORDER BY department_name

--The syntax for a join that uses the NATURAL keyword:

SELECT select_list
FROM table_1
         NATURAL JOIN table_2
        [NATURAL JOIN table_3]...
        
--Use the NATURAL keyword to join tables:

SELECT invoice_number, vendor_name
FROM vendors
        NATURAL JOIN invoices
ORDER BY invoice_number

--Use the NATURAL keyword in a statement that joins three tables:

SELECT department_name AS dept_name, last_name,
   project_number
FROM departments
       NATURAL JOIN employees
       LEFT JOIN projects USING (employee_id)
ORDER BY department_name

--The explicit syntax for a cross join:

SELECT select_list
FROM table_1 CROSS JOIN table_2

--A cross join that uses the explicit syntax:

SELECT departments.department_number, department_name,
       employee_id, last_name
FROM departments CROSS JOIN employees
ORDER BY departments.department_number

--The implicit syntax for a cross join:

SELECT select_list
FROM table_1, table_2
 
--A cross join that uses the implicit syntax:

SELECT departments.department_number, department_name,
       employee_id, last_name
FROM departments, employees
ORDER BY departments.department_number

--The syntax for a union operation:

	SELECT_statement_1
UNION [ALL]
    SELECT_statement_2
[UNION [ALL]
    SELECT_statement_3]...
[ORDER BY order_by_list]
 
 --A union that combines result sets from two different tables:
 
SELECT 'Active' AS source, invoice_number,
        invoice_date, invoice_total
    FROM active_invoices
    WHERE invoice_date >= '2018-06-01'
UNION
    SELECT 'Paid' AS source, invoice_number,
        invoice_date, invoice_total
    FROM paid_invoices
    WHERE invoice_date >= '2018-06-01'
ORDER BY invoice_total DESC

--A union that combines result sets from a single table:

	SELECT 'Active' AS source, invoice_number,
        invoice_date, invoice_total
    FROM invoices
    WHERE invoice_total - payment_total - credit_total > 0
UNION
    SELECT 'Paid' AS source, invoice_number,
        invoice_date, invoice_total
    FROM invoices
    WHERE invoice_total - payment_total - credit_total <= 0
ORDER BY invoice_total DESC

--A union that combines result sets from the same two tables:

	SELECT invoice_number, vendor_name,
        '33% Payment' AS payment_type,
        invoice_total AS total,
        invoice_total * 0.333 AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total > 10000
UNION
    SELECT invoice_number, vendor_name,
        '50% Payment' AS payment_type,
        invoice_total AS total,
        invoice_total * 0.5 AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total BETWEEN 500 AND 10000
UNION
    SELECT invoice_number, vendor_name,
        'Full amount' AS payment_type,
        invoice_total AS total,
        invoice_total AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total < 500
ORDER BY payment_type, vendor_name, invoice_number
    
--A union that simulates a full outer join:

SELECT department_name AS dept_name,
       d.department_number AS d_dept_no,
       e.department_number AS e_dept_no,
       last_name
FROM departments d
LEFT JOIN employees e ON
  d.department_number = e.department_number
UNION
SELECT department_name AS dept_name,
       d.department_number AS d_dept_no,
       e.department_number AS e_dept_no,
       last_name
FROM departments d
RIGHT JOIN employees e ON
  d.department_number = e.department_number
ORDER BY dept_name
 

 
 
 
 
 

 
 
 

 
            



 

 

           

 