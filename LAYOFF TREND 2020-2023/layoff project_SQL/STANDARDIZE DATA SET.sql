# standardizing the data

select company ,
trim(company)
from layoffs_sample2;


UPDATE layoffs_sample2
SET company = trim(company);

SELECT distinct INDUSTRY
 FROM layoffs_sample2
 ORDER BY 1;
 
 SELECT  *
 FROM layoffs_sample2
 where industry like 'crypto%';
 
 update layoffs_sample2
 set industry ='crypto'
 where industry like 'crypto%'
 ;
 
  SELECT distinct country, trim(trailing '.' from country)
 from layoffs_sample2
;
 
 
 update layoffs_sample2
 set country =  trim(trailing '.' from country)
 ; 
 
 select distinct `date` 
 from layoffs_sample2
 limit 50;

update layoffs_sample2
set `date` = str_to_date
(replace(date,'/','-'), '%m-%d-%Y')
;

alter table layoffs_sample2
modify column`date` date ;

select * 
from layoffs_sample2
where industry is null;

SELECT *
FROM layoffs_sample2 L1
join layoffs_sample2 L2
on L1.COMPANY= L2.COMPANY
WHERE L1.INDUSTRY IS NULL 
AND L2.INDUSTRY IS NOT NULL
;

update layoffs_sample2 L1
join layoffs_sample2 L2
on L1.COMPANY= L2.COMPANY
SET L1.INDUSTRY=L2.INDUSTRY
WHERE L1.INDUSTRY IS NULL 
AND L2.INDUSTRY IS NOT NULL
;

SELECT *
from layoffs_sample2
where total_laid_off is null
and percentage_laid_off is null ;


delete 
from layoffs_sample2
where total_laid_off is null
and percentage_laid_off is null ;

SELECT *
from layoffs_sample2;

alter table layoffs_sample2
drop `row_number` ;

select *
from layoff_sample



 