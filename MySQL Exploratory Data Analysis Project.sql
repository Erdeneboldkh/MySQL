-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off=1
ORDER BY funds_raised_millions DESC;


SELECT INDUSTRY, SUM(TOTAL_LAID_OFF)
FROM layoffs_staging2
group by INDUSTRY
ORDER BY 2 DESC;

SELECT MIN(`DATE`), MAX(`DATE`)
FROM layoffs_staging2;


SELECT country, SUM(TOTAL_LAID_OFF)
FROM layoffs_staging2
group by country
ORDER BY 2 DESC;

SELECT YEAR(`date`), SUM(TOTAL_LAID_OFF)
FROM layoffs_staging2
group by YEAR(`date`)
ORDER BY 2 DESC;

SELECT STAGE, SUM(TOTAL_LAID_OFF)
FROM layoffs_staging2
group by STAGE
ORDER BY 2 DESC;


SELECT substring(`DATE`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(`DATE`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH Rolling_total AS
(
SELECT substring(`DATE`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE substring(`DATE`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`,total_off
, SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_total;

SELECT company,YEAR(`date`), SUM(TOTAL_LAID_OFF)
FROM layoffs_staging2
group by company,YEAR(`date`)
ORDER BY 3 desc;




with Company_year(company, years, total_laid_off) as
( 
SELECT company,YEAR(`date`), SUM(TOTAL_LAID_OFF)
FROM layoffs_staging2
group by company,YEAR(`date`)
), 
Company_Year_Ranking as
(select *, dense_rank() over(partition by years order by total_laid_off desc) as Ranking
from company_year
where years is not null
)
select *
from Company_Year_ranking
where ranking<=5





