-- Priorities Given:
# Check for column names 
# Remove '$' sign and '-' from all columns where they are present
# Used CASE Statement to replace Parentheses to negative int
# Change datatype from objects to int after the above two
# Clean the rest of the data

-- Clean Data
#Step 1: Remove Duplicates
#Step 2: Standardize the data
#Step 3: Look and any Null or Blank Values
#Step 4: Remove any Columns or Rows not needed

SELECT *
FROM financials;

CREATE TABLE financials_staging
LIKE financials;

INSERT financials_staging
SELECT *
FROM financials;

SELECT *
FROM financials_staging;

ALTER TABLE financials_staging
	RENAME COLUMN Segment to segment,
    RENAME COLUMN Country to country,
    RENAME COLUMN Product to product,
    RENAME COLUMN `Discount Band` to discount_band,
    RENAME COLUMN `Units Sold` to units_sold,
    RENAME COLUMN `Manufacturing Price` to manufacturing_price,
	RENAME COLUMN `Gross Sales` to gross_sales,
    RENAME COLUMN Discounts to discounts,
    RENAME COLUMN Sales to sales,
    RENAME COLUMN COGS to cogs,
	RENAME COLUMN Profit to profit,
    RENAME COLUMN `Date` to `date`,
    RENAME COLUMN `Month Number` to month_number,
    RENAME COLUMN `Month Name` to month_name,
    RENAME COLUMN `Year` to year,
    RENAME COLUMN `Sale Price` to sale_price;

-- Step 2 Standardize
# Renamed all columns 
# Trimmed unwanted spaces 
# Replaced all $ and - (these are zero I put the code in step 3)
# Removed commas
# Changed parenthesis to negative int
# Chanaged data type for most columns to int
# Changed date to fit best practice for SQL

SELECT *
FROM financials_staging;

SELECT gross_sales, TRIM(gross_sales) 
FROM financials_staging;

UPDATE financials_staging
SET cogs = TRIM(cogs);

SELECT REPLACE (gross_sales, '$', '') as new_gross_sales, gross_sales
FROM financials_staging;

UPDATE financials_staging
SET profit = REPLACE(profit, '$', '');

SELECT REPLACE (gross_sales, ',', '') as new_gross_sales, gross_sales
FROM financials_staging;

UPDATE financials_staging
SET profit = REPLACE (profit, ',', '');

SELECT profit,
CASE
    WHEN profit LIKE '(%)' 
    THEN 
    REPLACE(
    REPLACE(profit, '(', '-')
   ,')', '' )
ELSE profit
END AS profit2
FROM financials_staging;

UPDATE financials_staging
SET profit =
CASE
    WHEN profit LIKE '(%)' 
    THEN 
    REPLACE(
    REPLACE(profit, '(', '-')
   ,')', '' )
ELSE profit
END;

ALTER TABLE financials_staging
MODIFY COLUMN units_sold int,
MODIFY COLUMN sale_price int,
MODIFY COLUMN gross_sales int,
MODIFY COLUMN discounts int,
MODIFY COLUMN sales int,
MODIFY COLUMN cogs int,
MODIFY COLUMN profit int,
MODIFY COLUMN manufacturing_price int;

SELECT `date`, str_to_date(`date`, '%d/%m/%Y') as new_date
FROM financials_staging;

UPDATE financials_staging
SET `date` = str_to_date(`date`, '%d/%m/%Y');

ALTER TABLE financials_staging
MODIFY COLUMN `date` date;

-- Step 3 Null or Blank Values
# In this section I found that a dash (-) was used in the data for 0. I replaced all dashes into zeroes. 
# The data was clean enough to not have any null values or blanks

SELECT *
FROM financials_staging
WHERE profit LIKE '-';

SELECT *
FROM financials_staging
WHERE profit LIKE '%-%';

SELECT REPLACE (discounts, '-', '0') as new_discounts, discounts
FROM financials_staging;

UPDATE financials_staging
SET discounts = REPLACE (discounts, '-', '0');

SELECT *
FROM financials_staging
WHERE `year` IS NULL OR '';

-- Step 4 Delete columns or rows
# There are no columns or rows that need to be delted with null values or blanks. 


