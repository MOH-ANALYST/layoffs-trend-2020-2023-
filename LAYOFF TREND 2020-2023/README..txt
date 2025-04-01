# 📊 Unpacking Layoff Trends (2020-2023) with SQL  

## Overview  
This project analyzes layoff trends from March 11, 2020, to March 6, 2023, using **SQL**.  
Key insights include which **companies, countries, and industries** were most affected.  

## Key Findings  
- **Top 3 companies with the highest layoffs:**  
  1️. Amazon – 18,150 layoffs  
  2️. Google – 12,000 layoffs  
  3️. Meta – 11,000 layoffs  

- **Countries with the most layoffs:**  
  🇺🇸 United States – 256,559 layoffs  
  🇮🇳 India – 35,993 layoffs  
  🇳🇱 Netherlands – 17,220 layoffs  

## 📂 Project Files  
- **Dataset:** `data/layoffs_data.csv`  
- **SQL Queries:** `sql/layoff_analysis.sql`  
- **Dashboard Screenshots:** `screenshots/layoff_trends.png`  

##  Tools Used  
- **SQL (MySQL)** – Data cleaning, standardization, and querying  
- **Excel** – Data storage and initial review    

## SQL Queries  
Example query to get **top 3 companies with highest layoffs**:  

```sql
SELECT company, SUM(total_laid_off) AS total_layoffs
FROM layoffs_data
GROUP BY company
ORDER BY total_layoffs DESC
LIMIT 3;
