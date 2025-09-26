# US Houshold Income (Data Cleaning)


SELECT * FROM us_project.us_household_income;

SELECT * FROM us_project.us_household_income_statistics;

-- Show me all duplicate records based on ID.
SELECT id, COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

SELECT id, COUNT(id)
FROM us_project.us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1
;


SELECT *
FROM (
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
FROM us_project.us_household_income
) Duplicates
WHERE row_num > 1
;


-- Remove all identified duplicate records.
DELETE FROM us_project.us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id,
				id,
				ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM us_project.us_household_income
		) Duplicates
	WHERE row_num > 1)
;

SELECT DISTINCT State_Name
FROM us_household_income
ORDER BY 1
;



SELECT id, COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1;


DELETE FROM us_project.us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id,
				id,
				ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM us_project.us_household_income
		) Duplicates
	WHERE row_num > 1);


-- Standardize misspelled state names.
UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;

UPDATE us_project.us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama'
;

-- Correct inconsistent place data.
SELECT DISTINCT *
FROM us_household_income
WHERE County = 'Autauga County'
ORDER BY 1
;

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND city = 'Vinemont'
;

SELECT Type, COUNT(Type)
FROM us_household_income
GROUP BY Type
;

-- Standardize location types from plural to singular.
UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

