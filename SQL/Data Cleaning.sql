-- DATA CLEANING

create table layoffs_staging
like layoffs;

insert layoffs_staging
select * from layoffs;

select * from layoffs_staging;


-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null or Blank Values
-- 4. Removes any Columns

with duplicate_cte as(
select *, row_number() over(partition by company ,location , industry ,total_laid_off ,
percentage_laid_off ,`date`, stage,  country, funds_raised_millions ) as `Row_Number`
from layoffs_staging)  
select * from duplicate_cte
where `row_number` > 1;

CREATE TABLE `layoffs_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoffs_staging_2 
select *, row_number() over(partition by  company ,location , industry ,total_laid_off ,
percentage_laid_off ,`date`, stage,  country, funds_raised_millions ) as `Row_Number`
from layoffs_staging;

DELETE 
from layoffs_staging_2 
WHERE row_num > 1;

-- Standardizing Data

select * from layoffs_staging_2;

select company, trim(company)
from layoffs_staging_2;

update layoffs_staging_2
set company = trim(company);


select distinct country, trim(trailing "." from country)	
from layoffs_staging_2
order by 1;

update layoffs_staging_2 
set country = trim(trailing "." from country);

select distinct industry
from layoffs_staging_2
where industry like '%crypto%';

update layoffs_staging_2
set industry = 'crypto'
where industry like '%crypto%';

select `date`,
str_to_date(`date`,'%m/%d/%Y') as `Date`
from layoffs_staging_2;

update layoffs_staging_2
set `date` = str_to_date(`date`,'%m/%d/%Y');

alter table layoffs_staging_2
modify column `date` date;

-- Null or Blank Values

select * from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;

update layoffs_staging_2
set industry = null
where industry = "";

select t1.industry,t2.industry from
layoffs_staging_2 as t1
join layoffs_staging_2 as t2
	on t1.company = t2.company
where t1.industry is null
and t2.industry is not null;

update layoffs_staging_2 as t1
join layoffs_staging_2 as t2
	on t1.company = t2.company
set t1.industry = t2.industry 
where t1.industry is null
and t2.industry is not null;

-- Delete unneccesary column

select * from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;

Alter table layoffs_staging_2
drop column row_num;

select * from layoffs_staging_2




 
