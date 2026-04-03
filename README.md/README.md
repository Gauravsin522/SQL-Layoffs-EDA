# 📊 Layoffs Data Analysis (SQL EDA Project)

## 📌 Overview

This project focuses on performing Exploratory Data Analysis (EDA) on a global layoffs dataset using SQL. The goal is to uncover trends, patterns, and insights related to layoffs across companies and time.

---

## 🛠️ Tools & Technologies

* SQL (MySQL)
* Data Cleaning & Transformation
* Window Functions
* Aggregations

---

## 📂 Dataset

* Dataset: Global Layoffs Dataset
* Contains information about companies, industries, dates, and layoffs.

---

## 🔍 Key Analysis Performed

### 1. Monthly Layoff Trends

* Extracted month from date
* Calculated total layoffs per month

### 2. Rolling Total Analysis

* Used window functions (`SUM OVER`)
* Tracked cumulative layoffs over time

### 3. Company-wise Layoffs

* Analyzed layoffs per company per year
* Identified companies with highest layoffs

### 4. Top Companies by Year

* Used `DENSE_RANK`
* Extracted top 5 companies with highest layoffs each year

---

## 📈 Key Insights

* Layoffs increased significantly during certain months indicating economic downturns
* Some companies consistently appeared in top layoffs across multiple years
* Cumulative layoffs trend shows long-term impact on workforce

---

## 📸 Sample Queries

```sql
SELECT substring(`date`,1,7) AS month, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY month;
```

---

## 🚀 How to Use

1. Import dataset into MySQL
2. Run SQL queries from `analysis.sql`
3. Explore insights

---

## 👨‍💻 Author

Gaurav Singh

* LinkedIn: https://www.linkedin.com/in/gaurav-singh522/
* GitHub: https://github.com/Gauravsin522
