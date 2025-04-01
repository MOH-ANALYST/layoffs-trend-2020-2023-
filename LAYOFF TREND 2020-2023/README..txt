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
Example query to get **top 5 companies with highest layoffs**:  

select *
from
(select company,
 year(`date`) as `year`
 ,sum(total_laid_off) as total_layoffs,
dense_rank()over(partition by year(`date`) order by sum(total_laid_off) desc) as `rank`
from layoffs_sample2 
WHERE TOTAL_LAID_OFF IS NOT NULL
AND `DATE` IS NOT NULL
group by company,year(`DATE`)) as company_year_ranking
where `rank` <= 5
order by `rank` asc
 ;
