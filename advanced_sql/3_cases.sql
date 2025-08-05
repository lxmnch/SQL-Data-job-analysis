SELECT
    COUNT(job_id) AS job_count,
    CASE
        WHEN salary_year_avg >= 100000 THEN 'High Salary'
        WHEN salary_year_avg BETWEEN 50000 AND 99999 THEN 'Medium Salary'
        WHEN salary_year_avg BETWEEN 0 AND 49999 THEN 'Low Salary'
        ELSE 'No Salary Data'
    END AS salary_year_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Scientist' AND
    salary_year_avg IS NOT NULL
GROUP BY
    salary_year_category
ORDER BY
    job_count DESC
LIMIT 100;

SELECT
    COUNT(job_id) AS job_count,
    CASE
        WHEN salary_hour_avg >= 50 THEN 'High Hourly Salary'
        WHEN salary_hour_avg BETWEEN 20 AND 49.99 THEN 'Medium Hourly Salary'
        WHEN salary_hour_avg BETWEEN 0 AND 19.99 THEN 'Low Hourly Salary'
        ELSE 'No Hourly Salary Data'
    END AS salary_hour_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Scientist' AND
    salary_hour_avg IS NOT NULL
GROUP BY
    salary_hour_category
ORDER BY
    job_count DESC
LIMIT 100;