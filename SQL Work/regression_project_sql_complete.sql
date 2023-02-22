-- 1. Create a database called `house_price_regression`. 
create database if not exists house_price_regression;
use house_price_regression;

--  2. Create a table `house_price_data` with the same columns as given in the csv file. Please make sure you use the correct data types for the columns. 
-- You can find the names of the headers for the table in the `regression_data.xls` file. Use the same column names as the names in the excel file. Please make sure you use the correct data types for each of the columns.

drop table if exists house_price_data;

CREATE TABLE house_price_data (
  `id` VARCHAR(50) UNIQUE NOT NULL,
  `date` date DEFAULT NULL,
  `bedrooms` int(4) DEFAULT NULL,
  `bathrooms` float DEFAULT NULL,
  `sqft_living` int(11) DEFAULT NULL,
  `sqft_lot` int(11) DEFAULT NULL,
  `floors` float DEFAULT NULL,
  `waterfront` int(4) DEFAULT NULL,
  `view` int(4) DEFAULT NULL,
  `condition_score` int(4) DEFAULT NULL,
  `grade` int(4) DEFAULT NULL,
  `sqft_above` int(11) DEFAULT NULL,
  `sqft_basement` int(11) DEFAULT NULL,
  `yr_built` int(11) DEFAULT NULL,
  `yr_renovated` int(11) DEFAULT NULL,
  `zip_code` int(11) DEFAULT NULL,
  `lat` float DEFAULT NULL,
  `lon` float DEFAULT NULL,
  `sqft_living15` int(11) DEFAULT NULL,
  `sqft_lot15` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (`id`)  -- constraint keyword is optional but its a good practice
);
-- I had to change the 'id' column type to VARCHAR as only ~5500 rows were importing due to id being out of range of the original column settings
--  Also Changed 'condition' column to 'condition_score' to work around issues with the condition keyword in SQL


--  3. Import the data from the csv file into the table.
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

load data local infile '/Users/chris/data_class_git/mid_bootcamp_regression_project/SQL Work/regression_data_SQL_copy.csv'
into table house_price_data
fields terminated BY ','; 

-- 4.  Select all the data from table `house_price_data` to check if the data was imported correctly 
select * from house_price_data
;

 -- 5.  Use the alter table command to drop the column `date` from the database, as we would not use it in the analysis with SQL. 
 -- Select all the data from the table to verify if the command worked. Limit your returned results to 10. 
 ALTER TABLE house_price_data
 DROP COLUMN date;
select * from house_price_data
limit 10;

-- 6.  Use sql query to find how many rows of data you have. 
select count(*) from house_price_data;



-- 7.  Now we will try to find the unique values in some of the categorical columns:
--     - What are the unique values in the column `bedrooms`?
--     - What are the unique values in the column `bathrooms`?
--     - What are the unique values in the column `floors`?
--     - What are the unique values in the column `condition`?
--     - What are the unique values in the column `grade`?

select distinct bedrooms from house_price_data
order by bedrooms desc;

select distinct bathrooms from house_price_data
order by bathrooms desc;

select distinct floors from house_price_data
order by floors desc;

select distinct condition_score from house_price_data
;

select distinct grade from house_price_data
order by grade desc;


-- 8.  Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.? 

select id from house_price_data
order by price desc
limit 10;

-- 9.  What is the average price of all the properties in your data?

select avg(price) from house_price_data;

-- 10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data

--  - What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. 
	-- Use an alias to change the name of the second column.
    
    select bedrooms, truncate(avg(price),2) as 'average_sale_price' from house_price_data
	group by bedrooms
    order by bedrooms
    ;
    
--   - What is the average `sqft_living` of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the `sqft_living`. 
	-- Use an alias to change the name of the second column.
    
    select bedrooms, truncate(avg(sqft_living),2) as 'average_living_sqft' from house_price_data
    group by bedrooms
    order by bedrooms
    ;
    
--   - What is the average price of the houses with a waterfront and without a waterfront? 
	-- The returned result should have only two columns, waterfront and `Average` of the prices. Use an alias to change the name of the second column.
    
    select waterfront, truncate(avg(price),2) as 'avg_sale_price' from house_price_data
    group by waterfront
    ;
    
--   - Is there any correlation between the columns `condition` and `grade`? You can analyse this by grouping the data by one of the variables and then aggregating 
	-- the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
		-- You might also have to check the number of houses in each category (ie number of houses for a given `condition`) to assess if that category is well represented in 
          -- the dataset to include it in your analysis. For eg. If the category is under-represented as compared to other categories, ignore that category in this analysis
    
    select condition_score, avg(grade) as 'average_grade', count(*) as 'houses_with_score' from house_price_data
    group by condition_score
    order by condition_score;
    -- The reult indicates a near 0 correlation. The median Condition Score has the highest Grade; while the Grade goes down whether condition score is higher or lower
    
    select grade, avg(condition_score), count(*) as 'houses_with_grade' from house_price_data
    group by grade
    order by grade;
    -- Reversing the query indicates again a correlation close to 0. For the most populated grade values  the Average Condition shows little variation between different Grades.  
    
    SELECT (Avg(condition_score * grade) - (Avg(condition_score) * Avg(grade))) / (STDDEV_POP(condition_score) * STDDEV_POP(grade)) AS `Pearsons r`
FROM house_price_data;
-- Checking the Pearsons correlation coefficient confirms the assessment of near 0 correlation between Grade and Condition scores. The negative score indicates that a higher condition_score should result in a slightly lower grade
    


          
--           
--  11. One of the customers is only interested in the following houses:
-- 	- Number of bedrooms either 3 or 4
--     - Bathrooms more than 3
--     - One Floor
--     - No waterfront
--     - Condition should be 3 at least
--     - Grade should be 5 at least
--     - Price less than 300000
-- For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?         

select * from house_price_data
where bedrooms between 3 and 4 and
bathrooms > 3 and
floors = 1 and
waterfront = 0 and
condition_score >= 3 and
grade >= 5 and
price < 300000
;
  --   No results in the data match these criteria. This customer will hve to keep shopping or adjust their criteria


-- 12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. 
-- 	Write a query to show them the list of such properties. You might need to use a sub query for this problem.
select * from house_price_data
where price > 2*(
select avg(price) from house_price_data)
;

-- 13. Since this is something that the senior management is regularly interested in, create a view called `Houses_with_higher_than_double_average_price` of the same query.
CREATE VIEW `Houses_with_higher_than_2x_average_price` AS
select * from house_price_data
where price > 2*(
select avg(price) from house_price_data)
;

select * from Houses_with_higher_than_double_average_price;

-- 14. Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms? 
	-- In this case you can simply use a group by to check the prices for those particular houses
   
   select truncate(avg(price),2) as 'average_sale_price', bedrooms
   from house_price_data
   where bedrooms between 3 and 4
   group by bedrooms;
   
--    15. What are the different locations where properties are available in your database? (distinct zip codes)
select distinct(zip_code) from house_price_data;

--  16. Show the list of all the properties that were renovated.
select * from house_price_data
where yr_renovated > 0
order by yr_renovated desc;



-- 17. Provide the details of the property that is the 11th most expensive property in your database.

SELECT * from(
 select *, RANK() OVER (
        ORDER BY price desc
    ) price_rank
FROM
    house_price_data) as gg
   where price_rank = 11 ;




