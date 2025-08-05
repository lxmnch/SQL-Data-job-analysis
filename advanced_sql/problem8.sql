SELECT 
    q1_job_postings.job_title_short,
    q1_job_postings.job_location,
    q1_job_postings.job_via,
    q1_job_postings.job_posted_date::DATE,
    q1_job_postings.salary_year_avg
FROM (
    SELECT*
    from january_jobs
    UNION ALL
    SELECT *
    from february_jobs
    UNION ALL
    SELECT *
    from march_jobs
) as q1_job_postings
WHERE q1_job_postings.salary_year_avg > 70000 AND
      q1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    q1_job_postings.salary_year_avg DESC

LIMIT 100;