USE ocd_patients;

SELECT *
FROM ocd_patient_dataset;

CREATE TABLE ocd_patient_dataset2
LIKE ocd_patient_dataset;

SELECT *
FROM ocd_patient_dataset2;


INSERT INTO ocd_patient_dataset2
SELECT *
FROM ocd_patient_dataset;

# CHECK FOR DUPLICATES

SELECT * , ROW_NUMBER() OVER(PARTITION BY Patient_ID, Age, Gender, Ethnicity, Marital_Status, Education_Level, OCD_Diagnosis_Date, Duration_of_Symptoms_months, Previous_Diagnoses, Family_History_of_OCD, Obsession_Type, Compulsion_Type, `Y-BOCS_Score_Obsessions`, `Y-BOCS_Score_Compulsions`, Depression_Diagnosis, Anxiety_Diagnosis, Medications) as ROW_NUM
FROM ocd_patient_dataset2;

WITH DUPLICATE_CTE AS (
  SELECT * , ROW_NUMBER() OVER(PARTITION BY Patient_ID, Age, Gender, Ethnicity, Marital_Status, Education_Level, OCD_Diagnosis_Date, Duration_of_Symptoms_months, Previous_Diagnoses, Family_History_of_OCD, Obsession_Type, Compulsion_Type, `Y-BOCS_Score_Obsessions`, `Y-BOCS_Score_Compulsions`, Depression_Diagnosis, Anxiety_Diagnosis, Medications) as ROW_NUM
FROM ocd_patient_dataset2
)
SELECT *
FROM DUPLICATE_CTE
WHERE ROW_NUM > 1;

# NO DUPLICATES

SELECT *
FROM ocd_patient_dataset2;

# STANDARDIZATION AND SPELL CHECK EACH COLUMN

SELECT DISTINCT Compulsion_Type
FROM ocd_patient_dataset2
ORDER BY 1;

-- CHECK DATA TYPES

SELECT OCD_Diagnosis_Date,
STR_TO_DATE(OCD_Diagnosis_Date, '%m/%d/%Y') 
FROM ocd_patient_dataset2;

UPDATE ocd_patient_dataset2
SET OCD_Diagnosis_Date = STR_TO_DATE(OCD_Diagnosis_Date, '%m/%d/%Y'); 

ALTER TABLE ocd_patient_dataset2
MODIFY COLUMN OCD_Diagnosis_Date DATE;

-- CHECK FOR NULL AND BLANK SPACES


-- 1. What are the count and percentage of OCD diagnoses by gender, and what is the average obsession score for males and females
SELECT *
FROM ocd_patient_dataset2;

SELECT Gender, 
COUNT(Patient_ID) as Patient_cnt, 
ROUND(AVG(`Y-BOCS_Score_Obsessions`),2) as Avg_obs_score,
ROUND(COUNT(Patient_ID) * 100 / SUM(COUNT(Patient_ID)) OVER (),2) as percentage
FROM ocd_patient_dataset2
GROUP BY 1;


-- 2. What is the count and average obsession score among individuals diagnosed with OCD, grouped by ethnicity?
SELECT *
FROM ocd_patient_dataset2;

SELECT Ethnicity,
COUNT(Patient_ID) Patient_cnt,
ROUND(AVG(`Y-BOCS_Score_Obsessions`),2) AVG_OBSESSION
FROM ocd_patient_dataset2
GROUP BY 1;

-- 3. Number of individuals diagnosed with OCD on a month-over-month basis
SELECT *
FROM ocd_patient_dataset2;


WITH MoM AS (
SELECT DATE_FORMAT(OCD_Diagnosis_Date, '%Y-%M') as Month_over_Month,
COUNT(*) AS PATIENT_CNT,
DATE_FORMAT(OCD_Diagnosis_Date, '%Y-%m') as MoM_dig
FROM ocd_patient_dataset2
GROUP BY 1, 3
ORDER BY 3
)
SELECT Month_over_Month,PATIENT_CNT
FROM MoM;


-- 4. What is the most common obsession type based on count, and what is its corresponding average obsession score
SELECT *
FROM ocd_patient_dataset2;

SELECT Obsession_Type,
COUNT(Obsession_Type) AS Cnt,
ROUND(AVG(`Y-BOCS_Score_Obsessions`),2) AS AVG_SCORE
FROM ocd_patient_dataset2
GROUP BY 1
ORDER BY 3 DESC;


-- 5. What is the most common compulsion type based on count, and what is its corresponding average obsession score
SELECT *
FROM ocd_patient_dataset2;

SELECT Compulsion_Type, 
COUNT(Compulsion_Type) AS CNT,
ROUND(AVG(`Y-BOCS_Score_Compulsions`),2) AS AVG_SCORE
FROM ocd_patient_dataset2
GROUP BY 1
ORDER BY 3 DESC;

-- Which age group has the highest prevalence of OCD
SELECT *
FROM ocd_patient_dataset2;

-- SELECT DISTINCT AGE
-- FROM ocd_patient_dataset2
-- ORDER BY 1;

SELECT 
CASE WHEN Age BETWEEN 0 AND 1 THEN 'Infant'
WHEN Age BETWEEN 1 AND 5 THEN 'Toddler'
WHEN Age BETWEEN 5 AND 13 THEN 'Children'
WHEN Age BETWEEN 13 AND 19 THEN 'Teenager'
WHEN Age BETWEEN 20 AND 29 THEN 'Young Adult'
WHEN Age BETWEEN 30 AND 39 THEN 'Adult'
WHEN Age BETWEEN 40 AND 59 THEN 'Middle Age'
WHEN Age >= 60 THEN 'Old age'
END as age_group ,
COUNT(*)
FROM ocd_patient_dataset2
GROUP BY 1
ORDER BY 2 DESC;


-- MEDICATION

SELECT *
FROM ocd_patient_dataset2;

SELECT Obsession_Type,
Medications, 
COUNT(*)
FROM ocd_patient_dataset2
GROUP BY 1,2
ORDER BY 1, 2, 3 DESC;


# Previous_Diagnoses
SELECT *
FROM ocd_patient_dataset2;

SELECT Obsession_Type,
Previous_Diagnoses, 
COUNT(*)
FROM ocd_patient_dataset2
GROUP BY 1, 2
ORDER BY 1, 3 DESC;


# Find out if there is a relationship between obsession type and anxiety diagnosis?
SELECT *
FROM ocd_patient_dataset2;
 

SELECT Obsession_Type, 
Anxiety_Diagnosis, 
ROUND(AVG(`Y-BOCS_Score_Obsessions`),2) AVG_OBS
FROM ocd_patient_dataset2
GROUP BY 1, 2;


# Find out if there is a link between family history of OCD and OCD diagnosis?
SELECT *
FROM ocd_patient_dataset2;

SELECT Family_History_of_OCD,
COUNT(Patient_ID)
FROM ocd_patient_dataset2
GROUP BY 1;


