CREATE TABLE january_jobs As
    SELECT*
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs As
    SELECT*
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs As
    SELECT*
    FROM
    job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

CREATE TABLE april_jobs As
    SELECT*
    FROM
    job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 4;

CREATE TABLE may_jobs As
    SELECT*
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 5;

CREATE TABLE june_jobs As
    SELECT*
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 6;

CREATE TABLE july_jobs As
    SELECT*
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 7;

CREATE TABLE august_jobs As
    SELECT*
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 8;

CREATE TABLE september_jobs As
    SELECT*
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 9;

CREATE TABLE october_jobs As
    SELECT*
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 10;

CREATE TABLE november_jobs As
    SELECT*
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 11;

CREATE TABLE december_jobs As
    SELECT*
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 12;

SELECT job_posted_date
FROM march_jobs
