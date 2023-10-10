-- Quantos usuários únicos estão em cada planilha?
SELECT
COUNT(DISTINCT A.Id) as DailyActivity,
COUNT(DISTINCT S.Id) as SleepActivity,
COUNT(DISTINCT W.Id) as WeightActivity,
FROM
Fitabase.dailyactivity A
FULL JOIN Fitabase.sleepDay S ON A.Id = S.Id
FULL JOIN Fitabase.weightLogInfo W ON A.Id = W.Id

  
-- Performance média individual?
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
ORDER BY Id

-- Sono individual?
SELECT *,
(avg_min_asleep/60) AS avg_hour_asleep     
FROM (      
   SELECT DISTINCT Id,      
    COUNT(Id) AS total_logs,      
    SUM(TotalTimeInBed) AS total_min_awake_in_bed,     
    AVG(TotalTimeInBed) AS avg_min_awake_in_bed,     
    SUM(TotalMinutesAsleep) AS total_min_asleep,      
    AVG(TotalMinutesAsleep) AS avg_min_asleep     
 FROM Fitabase.sleepDay     
 GROUP BY Id      
 ORDER BY Id )

-- Combinando sono com atividade
SELECT *
FROM Fitabase.id_activity
JOIN Fitabase.id_sleep ON id_activity.Id = id_sleep.Id
ORDER BY id_sleep.Id

-- Quais dias tem mais atividades
SELECT
FORMAT_DATE('%A', DATE(ActivityDate)) as Day,
COUNT(ActivityDate) AS logs,
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
     END ASC

-- Quais dias tem mais ou menos sono?
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
 END ASC

-- Há alguma tendencia de atividade ao longo do tempo?
SELECT DISTINCT ActivityDate,
 COUNT(Id) AS logs,
 AVG(TotalSteps) AS avg_steps,
 AVG(TotalDistance) AS avg_total_distance, 
 AVG(VeryActiveMinutes) AS avg_very_act_min,
 AVG(FairlyActiveMinutes) AS avg_fairly_act_min,
 AVG(LightlyActiveMinutes) AS avg_light_min,
 AVG(SedentaryMinutes) AS avg_sedentary_min,
 AVG(Calories) AS avg_calories_burned
FROM Fitabase.dailyactivity
GROUP BY ActivityDate 
ORDER BY ActivityDate

-- Há alguma tendencia de sono ao longo do tempo?
SELECT *,
(avg_min_asleep/60) AS avg_hour_asleep ## Add column with minutes asleep converted to hours
FROM (
 SELECT DISTINCT SleepDay,      
 COUNT(SleepDay) AS logs,      
 SUM(TotalTimeInBed) AS total_min_awake_in_bed,     
 AVG(TotalTimeInBed) AS avg_min_awake_in_bed,     
 SUM(TotalMinutesAsleep) AS total_min_asleep,      
 AVG(TotalMinutesAsleep) AS avg_min_asleep     
 FROM Fitabase.sleepDay S  
 GROUP BY SleepDay  ## Results in user ids being grouped into single average entry for each date
 ORDER BY SleepDay ) 
