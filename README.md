# Google Data Analytics Capstone: Belabeat case study

## Introduction:
This is the case study for the Google Data Analytics Professional Capstone Program. I am a junior data analyst working for Bellabeat, and my task is to analyze fitness data from smart devices to help uncover new growth opportunities for the company.

## Stakeholders:
Urška Sršen: Bellabeat’s cofounder and Chief Creative Officer.

Sando Mur: Mathematician and Bellabeat’s cofounder; key member of the Bellabeat executive team
Bellabeat marketing analytics team: A team of data analysts responsible for collecting, analyzing, and
reporting data that helps guide Bellabeat’s marketing strategy.



# Prepare, Process, Analyze and Share:
### 1 - First, I had to format the TIMESTAMP type in R so I could query it correctly using BigQuery.
##### The script is in [formatting.R](https://github.com/thaciopimenta/GoogleDA/blob/main/formatting.R)

### 2 - The queries and explanations aim to identify patterns related to daily activity, sleep, steps, days, and usage times.
##### The script is in [SQL_QUERIES.sql](https://github.com/thaciopimenta/GoogleDA/edit/main/SQL_QUERIES.sql)

### 3 - The DataViz with the patterns found.
##### The script is in [Visualizations.md](https://github.com/thaciopimenta/GoogleDA/blob/main/Visualizations.md)


# Act (Recommendations):
..* A lot of users are close to reaching the CDC recommendations for daily steps, daily minutes, and sleep.

So, if we add a feature for them to set a specific goal and provide them with some encouragement alongside, we can do this by focusing on the hour before their usual workout or in the evening, informing them about how many hours they slept and whether it is below or above the CDC recommendations.
