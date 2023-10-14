-- How many unique users are in each table?
SELECT
COUNT(DISTINCT A.Id) as DailyActivity,
COUNT(DISTINCT S.Id) as SleepActivity,
COUNT(DISTINCT W.Id) as WeightActivity,
FROM
Fitabase.dailyactivity A
FULL JOIN Fitabase.sleepDay S ON A.Id = S.Id
FULL JOIN Fitabase.weightLogInfo W ON A.Id = W.Id;
-- 33 in DailyActivitu, 24 in SleepActivity and 8 in WeightActivity.
  
-- Steps, distances, and individual average calories?
SELECT DISTINCT Id,
 COUNT(Id) AS logs,
 AVG(TotalSteps) AS avg_steps,
 AVG(TotalDistance) AS avg_total_distance, 
 AVG(VeryActiveMinutes) AS avg_very_min,
 AVG(FairlyActiveMinutes) AS avg_fair_min,
 AVG(LightlyActiveMinutes) AS avg_light_min,
 AVG(SedentaryMinutes) AS avg_sedentary_min,
 AVG(Calories) AS avg_calories_burned
FROM Fitabase.dailyactivity
GROUP BY Id
ORDER BY Id;

-- Is there any trend in activity over time?
SELECT DISTINCT ActivityDate,
 AVG(TotalSteps) AS avg_steps,
 AVG(TotalDistance) AS avg_total_distance, 
 AVG(VeryActiveMinutes) AS avg_very_act_min,
 AVG(FairlyActiveMinutes) AS avg_fairly_act_min,
 AVG(LightlyActiveMinutes) AS avg_light_min,
 AVG(SedentaryMinutes) AS avg_sedentary_min,
 AVG(Calories) AS avg_calories_burned
FROM Fitabase.dailyactivity
GROUP BY ActivityDate 
ORDER BY ActivityDate;

-- Individual average performance.
  WITH stacked_data AS (
  SELECT
    Id,
    'VeryActiveMinutes' AS ActivityType,
    VeryActiveMinutes AS Minutes,
  FROM
    Fitabase.dailyactivity
  UNION ALL
  SELECT
    Id,
    'FairlyActiveMinutes' AS ActivityType,
    FairlyActiveMinutes AS Minutes,
  FROM
    Fitabase.dailyactivity
  UNION ALL
  SELECT
    Id,
    'LightlyActiveMinutes' AS ActivityType,
    LightlyActiveMinutes AS Minutes,
  FROM
    Fitabase.dailyactivity
  UNION ALL
  SELECT
    Id,
    'SedentaryMinutes' AS ActivityType,
    SedentaryMinutes AS Minutes,
  FROM
    Fitabase.dailyactivity
)
SELECT
  Id,
  ActivityType,
  AVG(Minutes) AS avg_minutes,
FROM
  stacked_data
GROUP BY
  Id, ActivityType
ORDER BY
  Id, ActivityType;

-- Number of individuals who exercised for more than 30 minutes per day.
SELECT 
  Id,
  SUM(AvgVeryActiveMinutes + AvgFairlyActiveMinutes) AS TotalActiveMinutes
FROM
(
  SELECT
    Id,
    AVG(VeryActiveMinutes) as AvgVeryActiveMinutes,
    AVG(FairlyActiveMinutes) as AvgFairlyActiveMinutes
  FROM
    Fitabase.dailyactivity
  GROUP BY
    Id
) AS SubqueryAlias
GROUP BY
  Id
HAVING
  TotalActiveMinutes > 30;
-- Seventeen individuals exercised for more than 30 minutes daily.

-- Which days have the most activities?
SELECT
FORMAT_DATE('%A', DATE(ActivityDate)) as Day,
 AVG(TotalSteps) AS avg_steps,
 AVG(VeryActiveMinutes) AS avg_very_act_min,
 AVG(FairlyActiveMinutes) AS avg_fairly_act_min,
 AVG(LightlyActiveMinutes) AS avg_lightly_act_min,
 AVG(SedentaryMinutes) AS avg_sedentary_min,
 AVG(TotalDistance) AS avg_total_dist,
 AVG(Calories) AS avg_calories_burned
FROM Fitabase.dailyactivity
GROUP BY Day
ORDER BY
     CASE
WHEN Day = 'Sunday' THEN 1
WHEN Day = 'Monday' THEN 2  
WHEN Day = 'Tuesday' THEN 3  
WHEN Day = 'Wednesday' THEN 4
WHEN Day = 'Thursday' THEN 5
WHEN Day = 'Friday' THEN 6
WHEN Day = 'Saturday' THEN 7
     END ASC;
-- Monday, Tuesday and Saturday

-- Which hours have the highest intensity?
SELECT
  DISTINCT TIME(ActivityHour) as Time,
  FORMAT_DATE('%A', DATE(ActivityHour)) as Day,
  AVG(TotalIntensity) AS avg_intensity,
FROM Fitabase.hourlyIntensities
GROUP BY Time, Day
ORDER BY
     CASE
WHEN Day = 'Sunday' THEN 1
WHEN Day = 'Monday' THEN 2  
WHEN Day = 'Tuesday' THEN 3  
WHEN Day = 'Wednesday' THEN 4
WHEN Day = 'Thursday' THEN 5
WHEN Day = 'Friday' THEN 6
WHEN Day = 'Saturday' THEN 7
     END ASC;

-- How many step Id's are in the range?
SELECT 
    SUM(CASE WHEN avg_steps > 12000 THEN 1 ELSE 0 END) AS steps_gt_12000,
    SUM(CASE WHEN avg_steps BETWEEN 8000 AND 12000 THEN 1 ELSE 0 END) AS steps_between_8000_12000,
    SUM(CASE WHEN avg_steps BETWEEN 4000 AND 8000 THEN 1 ELSE 0 END) AS steps_between_4000_8000,
    SUM(CASE WHEN avg_steps < 4000 THEN 1 ELSE 0 END) AS steps_lt_4000
FROM (
    SELECT 
        Id,
        AVG(TotalSteps) AS avg_steps
    FROM Fitabase.dailyactivity
    GROUP BY Id
) AS subquery;

-- How do the steps vary by time and day?
SELECT 
    DISTINCT TIME(ActivityHour) as Time,
    FORMAT_DATE('%A', DATE(ActivityHour)) as Day,
    AVG(StepTotal) AS avg_steps,
FROM Fitabase.hourlySteps
GROUP BY Time, Day
ORDER BY
  CASE      
    WHEN Day = 'Sunday' THEN 1      
    WHEN Day = 'Monday' THEN 2      
    WHEN Day = 'Tuesday' THEN 3     
    WHEN Day = 'Wednesday' THEN 4     
    WHEN Day = 'Thursday' THEN 5      
    WHEN Day = 'Friday' THEN 6      
    WHEN Day = 'Saturday' THEN 7      
 END ASC;
-- 12-14h and 17-19h

-- Individual sleep?
SELECT *,
(avg_min_asleep/60) AS avg_hour_asleep     
FROM (      
   SELECT DISTINCT Id,              
    AVG(TotalMinutesAsleep) AS avg_min_asleep     
 FROM Fitabase.sleepDay     
 GROUP BY Id      
 ORDER BY Id );

--- How many people have more than 7 hours of sleep?
SELECT
  Id,
  AVG(TotalMinutesAsleep/60) as AvgSleep
FROM
  Fitabase.sleepDay
GROUP BY
  Id
HAVING
  AvgSleep > 7;
-- 50%

-- Which days have more or less sleep?
SELECT 
    FORMAT_DATE('%A', DATE(sleepDay.SleepDay)) as Day, 
    COUNT(*) AS number_of_days,
    AVG(TotalTimeInBed) AS avg_min_awake_in_bed,   
    AVG(TotalMinutesAsleep) AS avg_min_asleep,
    AVG(TotalMinutesAsleep) / 60 AS avg_hour_asleep 
FROM 
    Fitabase.sleepDay
GROUP BY 
    Day
ORDER BY
CASE      
WHEN Day = 'Sunday' THEN 1      
WHEN Day = 'Monday' THEN 2      
WHEN Day = 'Tuesday' THEN 3     
WHEN Day = 'Wednesday' THEN 4     
WHEN Day = 'Thursday' THEN 5      
WHEN Day = 'Friday' THEN 6      
WHEN Day = 'Saturday' THEN 7      
 END ASC;

-- Is there any sleep trend over time?
SELECT *,
(avg_min_asleep/60) AS avg_hour_asleep ## Add column with minutes asleep converted to hours
FROM (
 SELECT DISTINCT SleepDay,        
 SUM(TotalTimeInBed) AS total_min_awake_in_bed,     
 AVG(TotalTimeInBed) AS avg_min_awake_in_bed,     
 SUM(TotalMinutesAsleep) AS total_min_asleep,      
 AVG(TotalMinutesAsleep) AS avg_min_asleep     
 FROM Fitabase.sleepDay S  
 GROUP BY SleepDay  ## Results in user ids being grouped into single average entry for each date
 ORDER BY SleepDay ) ;

