-- Exploratory Data Analysis (Data Finances)
# Sales and profit are the main objective to analyze
# Analyze other useful data and find insights to graph on Tableau

SELECT *
FROM financials_staging;

SELECT segment, MAX(profit) 
FROM financials_staging
GROUP BY segment
ORDER BY 2 DESC;
-- Government has the most amount of profit followed by small business

SELECT country, sum(profit) 
FROM financials_staging
GROUP BY country
ORDER BY 2 DESC;

-- France has the most in profit

SELECT product, sales, profit, segment, country
FROM financials_staging
ORDER BY profit DESC;

-- Paseo is the product that has sold and profitted the most in the USA

SELECT product, SUM(sales)
FROM financials_staging
GROUP BY product
ORDER BY SUM(sales) desc;

-- Paseo has made the most profit with VTT coming in second. Paseo has also sold the most as well
