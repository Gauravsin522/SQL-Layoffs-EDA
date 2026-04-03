## Exploratory Data Analysis

use world_layoffs;

select * from layoffs_staging_2;

select substring(`date`,1,7) as `month`,sum(total_laid_off)
from layoffs_staging_2
where substring(`date`,1,7) is not null
group by `month`
order by `month` asc;

With Rolling_total as 
(
select substring(`date`,1,7) as `month`,sum(total_laid_off) as Total_lay_off
from layoffs_staging_2
where substring(`date`,1,7) is not null
group by `month`)

select `month`, Total_lay_off,
sum(total_lay_off) over(order by `month`) as rolling_total
from rolling_total
;

select company,year(`date`) as `year`, sum(total_laid_off)
from layoffs_staging_2
group by 1, `Year`
order by 3 desc;

with Company_year as 
(
select company,year(`date`) as `year`, sum(total_laid_off) as Total_lay_off
from layoffs_staging_2
group by 1, `Year`
order by 3 desc
),Company_Ranking  as
(select *, dense_rank() over (partition by `year` order by  total_lay_off DESC) As ranking
from company_year
where `year` is not null)
select * from 
company_ranking
where Ranking <= 5;