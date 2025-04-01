# cleaning data


select*
from layoffs;

/*1.remove duplicate
2.standardize the data
3.check out the null value and blank values 
4. remove any extra column or row */

create table layoffs_sample
like layoffs;

select *
from layoffs_sample;

insert layoffs_sample
select *
from layoffs;

select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,
`date`,stage,country,funds_raised_millions) as row_num
from layoffs_sample
;


with duplicate_cte as
(select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,
`date`,stage,country,funds_raised_millions) as row_num
from layoffs_sample
)
select*
from  duplicate_cte
where row_num >1;

select *
from layoffs_sample;


CREATE TABLE `layoffs_sample2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_number` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from layoffs_sample2;

insert layoffs_sample2
select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,
`date`,stage,country,funds_raised_millions) as row_num
from layoffs_sample;


delete
from layoffs_sample2
where `row_number` > 1 ;

select *
from layoffs_sample2;


