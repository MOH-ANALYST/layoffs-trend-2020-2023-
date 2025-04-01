#exploring the data_set data was collected from year 2020-2023(early)

select min(`date`) as start_date,
max(`date`) as end_date
 from layoffs_sample2;


 select *
 from layoffs_sample2;
# layoff yearly trend and running total

select year(`date`) as `year`
, sum(total_laid_off) as total_layoff
,sum(sum(total_laid_off)) over(order by year(`date`)) running_total
from layoffs_sample2
where `date` is not null
group by year(`date`)
order by `year`;

#layoff monthly trend and running total
 
 select substring(`date`,1,7) month_year
 , sum(total_laid_off) total_layoffs
 ,sum(sum(total_laid_off)) over(order by substring(`date`,1,7)asc) running_total
 from layoffs_sample2
 where `date` is not null
 and total_laid_off is not null
 group by substring(`date`,1,7)
 order by 1 asc;



#running_total with cte

with rolling_total as
(select substring(`date`,1,7) month_year
 , sum(total_laid_off) total_layoffs
 from layoffs_sample2
 where `date` is not null
 group by substring(`date`,1,7)
 order by 1 asc)
 select month_year,total_layoffs 
 ,sum(total_layoffs) over(order by month_year) as running_total
 from rolling_total
 ;



#companies with the higest layoff (percentage) 
select company, max(percentage_laid_off) as highest_layoffs
from layoffs_sample2
group by company 
order by 2 desc 
;

#company with the highest number of laid staff

select company, sum(total_laid_off)
from layoffs_sample2
group by company
order by 2 desc ;

# noting special just playing around with the data
select*
from layoffs_sample2
where total_laid_off >10000 
order by funds_raised_millions desc;

select company,industry, sum(total_laid_off),max(percentage_laid_off)
from layoffs_sample2 
where percentage_laid_off is not null 
or total_laid_off is not null
group by industry,company
order by 3 desc ;

#country's average and total compared to overall average and sum
  
select country,
 sum(total_laid_off) as country_layoff
,round(avg(percentage_laid_off),2) as country_average,
(select sum(total_laid_off) from layoffs_sample2) as overall_sum ,
round((select avg(percentage_laid_off) from layoffs_sample2), 2) as overall_average,
 round(avg(percentage_laid_off)-(select avg(percentage_laid_off) from layoffs_sample2),2 )as difference_between_average,
 round(sum(total_laid_off)-(select sum(total_laid_off) from layoffs_sample2)) as difference_in_sum
 from layoffs_sample2
 where total_laid_off is not null 
 or percentage_laid_off is not null
 and (select avg(percentage_laid_off) from layoffs_sample2) is not null
 group by country
 order by 6 asc
;

select stage , sum(total_laid_off)
from layoffs_sample2
group by stage
order by 2 desc
;


#ranking based of layoff in each year(top 5)
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
 
 select company,
 year(`date`) as `year`
 ,sum(total_laid_off) as total_layoffs,
dense_rank()over(partition by year(`date`) order by sum(total_laid_off) desc) as `rank`
from layoffs_sample2 
WHERE TOTAL_LAID_OFF IS NOT NULL
AND `DATE` IS NOT NULL
group by company,year(`DATE`)
order by `rank` asc;



#cte version of ranking comapany based of total_layoff in each year (top 5)

with company_year (company,years ,total_laid_off) as 
( 
select company,
year(`date`) as `year`,
sum(total_laid_off) 
	from layoffs_sample2
    group by company,year(`date`)
	),company_year_ranking as
    (select *, dense_rank() over(partition by years order by total_laid_off desc) as ranks
    from company_year
    where years is not null
    order by ranks)
    select *
    from company_year_ranking
    where ranks <= 5;
    
    select country, sum(total_laid_off)
from layoffs_sample2
group by country
order by 2 desc ;
    
    
    