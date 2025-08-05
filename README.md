# Introduction
Dive into the data job market!! Focusing on data analyst roles, as well as Data Scientist, Engineers and more, this project explores top paying jobs, in demand skills, and where high demand meets high salary.

SQL Queries? Check them out here: [project_sql folder](/project_sql/) 

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in0demand skills, streamlining others work to find optimal jobs.  

The data used here was from a different source than my Data Profession Survey project.  It comes from a SQL course  I took (https://www.lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL Queries:
1. What are the top paying data analyst jobs?
2. What skills are required for these top paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I used
FOr my deep dive into the data analyst job market, I harnessed the power of several key tools:

-**SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.

-**PostgreSQL**: The chosen database management system, ideal for handling the job posting data.

-**Visual Studio Code**: My go-to for database management and executing SQL queries.

-**Git & Github**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest paying roles, I filtered data analyst postions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:

-**Wide Salary Range**: Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.

-**Diverse Employers**: Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.

-**Job Title Variety**: There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

### 2. Skills for the Top Paying Jobs
To understand what skills are required for the top paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high compensation roles.

 ```sql
 WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

-**SQL** is leading with a bold count of 8.

-**Python** follows closely behind with a bold count of 7.

-**Tableau** is also highly sought after, with a bold count of 6. Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees of demand.

### 3. In Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = true
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
Here's the breakdown of the most demanded skills for data analysts in 2023:

-**SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
-**Programming** and **Visualization Tools** like **Python**,**Tableau**, and **PowerBI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

### 4. Skillas Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
    AND job_work_from_home = true
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```

Here's a breakdown of the results for top payin skills for Data Analysts:

-**High Demand for Big Data & ML Skills** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the infustry's high valuation of data processing and predictive modeling capabilities.

-**Software Development & Deployment Proficiency**: Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow), indicates a lurative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipline management.

-**Cloud Computing Expertise**: Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

### 5. Most Optimal Skills to Learn

Combing insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) as demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

Here's a breakdown of the most optimal skills for Data Analysts in 2023:

-**High Demand Programming Languages** : Pythong and R stand out for the high deman, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is high valued but also widely available.

-**Cloud Tools and Technologies**: Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.

-**Business Intelligence and Visualization Tools**: Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionabale insights from data.

-**Database Technologies**: The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NOSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.
# What I Learned

Throughout the adventure, I've absolutely turbocharged my SQL toolkit with some serious firepower:

-**Complex Query Crafting**: Mastered the art of advanced SQL, merging tables like a profressional and wielding WITH clauses for ninja-level temp table maneuvers.

-**Data Aggregation**: Got very comfortable with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data summarizing sidekicks.

-**Analytical Mastery**: Leveled up my real-world puzzle-solving skills, turning questions into actionabale, insightful SQL queries.

# Conclusions

### Insights

1. **Top Paying Data Analyst Jobs**: The highest paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest being $650,000!
2. **Skills for Top Paying Jobs**: High paying data analyst jobs require advanced proficiency in SQL, suggesting it's a critical skill for earning a top salary.
3. **Most In Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on a niche expertise.
5. **Optimal Skills for Kob Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data anlysts to learn to maximize their market value.

### Closing Thoughts
This project really etablished an excellent foundation of SQL skills for me to better understand the use of it.  Not only was it insightful in learning the language better, but also with the dataset that was worked on, I was able to better understand the market prospects and strategies I should take to properly get into the field.  It showed me the skills I really need to focus on, develop, and practice with to get established as a data analyst.