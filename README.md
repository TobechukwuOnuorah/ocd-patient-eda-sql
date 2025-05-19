# ocd-patient-eda-sql
SQL-based data cleaning and exploratory data analysis (EDA) on an OCD patient dataset

###  Dataset Overview

- **Database:** `ocd_patients`
- **Primary Table:** `ocd_patient_dataset`
- **Cloned Table for Processing:** `ocd_patient_dataset2`
  
Each record represents an OCD patient's demographic and clinical information, including obsession/compulsion types, diagnosis dates, and symptom scores.

### Data Sourse 
The OCD patient dataset used in this project was sourced from [Dataset Link](https://www.kaggle.com/datasets/ohinhaque/ocd-patient-dataset-demographics-and-clinical-data/data) 

### Tools 
- Excel - Data Cleaning 
- MySQL - Data Analysis

###  Data Cleaning & Preparation

1. **Cloned the original dataset** to preserve raw data.
2. **Duplicate Detection** using `ROW_NUMBER()` and CTEs.
3. **Date Standardization**:
   - Converted `OCD_Diagnosis_Date` from `VARCHAR` to `DATE` format using `STR_TO_DATE`.
4. **Spell Check & Standardization**:
   - Reviewed distinct values in fields like `Compulsion_Type`.
5. **Null & Blank Space Checks** (to be expanded).

### 📊 Exploratory Data Analysis (EDA)

#### 1. **Gender-Based Analysis**
- Count and percentage of OCD diagnoses by gender.
- Average obsession scores by gender.

#### 2. **Ethnicity-Based Analysis**
- Patient count and average obsession scores grouped by ethnicity.

#### 3. **Time Trend Analysis**
- Monthly trend of OCD diagnoses using formatted diagnosis dates.

#### 4. **Obsession & Compulsion Patterns**
- Most common obsession and compulsion types.
- Average severity scores for each type.

#### 5. **Age Group Prevalence**
- Categorized patients into age groups (Infant to Old age).
- Identified the age group with the highest prevalence of OCD.

#### 6. **Medication Analysis**
- Frequency of medications by obsession type.

#### 7. **Previous Diagnoses**
- Distribution of prior diagnoses across obsession types.

#### 8. **Anxiety Correlation**
- Assessed potential relationship between obsession type and anxiety diagnosis.

#### 9. **Family History Insight**
- Distribution of patients with and without a family history of OCD.

### 🛠️ SQL Features Used

- `CTE` with `ROW_NUMBER()` for duplicate detection.
- `CASE WHEN` for age group classification.
- `STR_TO_DATE()` for date formatting.
- Aggregate functions: `COUNT()`, `AVG()`, `ROUND()`
- `GROUP BY`, `ORDER BY`, and conditional logic for insights.


### ✅ Future Improvements

- Implement NULL and blank space cleanup.
- Add data validation rules.
- Visualize results using a BI tool or Python (e.g., seaborn, matplotlib).

---

### 📌 Note

This project is intended for educational and analytical purposes only. The dataset has been anonymized and used strictly for demonstrating SQL skills in a healthcare context.

---

### 📧 Contact

For questions or feedback, feel free to reach out via GitHub Issues or connect with me on [LinkedIn](https://www.linkedin.com/in/tobechukwu-onuorah-4a69ba2b0/)
