# US Houshold Income (Exploratory Data Analysis)


SELECT * FROM us_project.us_household_income;

SELECT * FROM us_project.us_household_income_statistics;

-- Show me the top 10 states with the largest land area.
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name 
ORDER BY 2 DESC
LIMIT 10
;


SELECT *
FROM us_project.us_household_income u
JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
;

-- Show me the 10 states with the lowest average household income.
SELECT u.State_Name, ROUND(AVG(Mean), 1), ROUND(AVG(Median), 1)
FROM us_project.us_household_income u
JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 3 ASC
LIMIT 10
;

-- Show me the average household income grouped by location type.
SELECT Type, COUNT(Type), ROUND(AVG(Mean), 1), ROUND(AVG(Median), 1)
FROM us_project.us_household_income u
JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 3 ASC
;

-- Show me the highest-earning cities based on average household income.
SELECT u.State_Name, City,  ROUND(AVG(Mean), 1), ROUND(AVG(Median), 1)
FROM us_project.us_household_income u
JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean), 1) DESC
;
