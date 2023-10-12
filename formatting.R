install.packages('tidyverse')
library(tidyverse)
install.packages("lubridate")  
install.packages("dplyr")
library(lubridate)
library(dplyr)

heartrate_seconds <- read.csv("../input/filesfitbit/heartrate_seconds_merged.csv")
head(heartrate_seconds)
heartrate_seconds <- heartrate_seconds %>%
  mutate(Time = mdy_hms(Time) %>% format("%m/%d/%Y %H:%M:%S"))
write.csv(heartrate_seconds_merged, file = "../input/filesfitbit/heartrate_seconds_merged.csv", row.names = FALSE)

hourlyCalories <- read.csv("../input/filesfitbit/hourlyCalories_merged.csv")
head(hourlyCalories)
hourlyCalories <- hourlyCalories %>%
  mutate(ActivityHour = mdy_hms(ActivityHour) %>% format("%m/%d/%Y %H:%M:%S"))
write.csv(hourlyCalories, file = "../input/filesfitbit/hourlyCalories_merged.csv", row.names = FALSE)

hourlyIntensities <- read.csv("../input/filesfitbit/hourlyIntensities_merged.csv")
head(hourlyIntensities)
hourlyIntensities <- hourlyIntensities %>%
  mutate(ActivityHour = mdy_hms(ActivityHour) %>% format("%m/%d/%Y %H:%M:%S"))
write.csv(hourlyIntensities, file = "../input/filesfitbit/hourlyIntensities_merged.csv", row.names = FALSE)

hourlySteps <- read.csv("../input/filesfitbit/hourlySteps_merged.csv")
head(hourlySteps)
hourlySteps <- hourlySteps %>%
  mutate(ActivityHour = mdy_hms(ActivityHour) %>% format("%m/%d/%Y %H:%M:%S"))
write.csv(hourlySteps, file = "../input/filesfitbit/hourlySteps_merged.csv", row.names = FALSE)

minuteCaloriesNarrow <- read.csv("../input/filesfitbit/minuteCaloriesNarrow_merged.csv")
head(minuteCaloriesNarrow)
minuteCaloriesNarrow <- minuteCaloriesNarrow %>%
  mutate(ActivityMinute = mdy_hms(ActivityMinute) %>% format("%m/%d/%Y %H:%M:%S"))
write.csv(minuteCaloriesNarrow, file = "../input/filesfitbit/minuteCaloriesNarrow_merged.csv", row.names = FALSE)

minuteCaloriesWide <- read.csv("../input/filesfitbit/minuteCaloriesWide_merged.csv")
head(minuteCaloriesWide)
minuteCaloriesWide <- minuteCaloriesWide %>%
  mutate(ActivityHour = mdy_hms(ActivityHour) %>% format("%m/%d/%Y %H:%M:%S"))
write.csv(minuteCaloriesWide, file = "../input/filesfitbit/minuteCaloriesWide_merged.csv", row.names = FALSE)

minuteIntensitiesNarrow <- read.csv("../input/filesfitbit/minuteIntensitiesNarrow_merged.csv")
head(minuteIntensitiesNarrow)
minuteIntensitiesNarrow <- minuteIntensitiesNarrow %>%
  mutate(ActivityMinute = mdy_hms(ActivityMinute) %>% format("%m/%d/%Y %H:%M:%S"))
write.csv(minuteIntensitiesNarrow, file = "../input/filesfitbit/minuteIntensitiesNarrow_merged.csv", row.names = FALSE)

minuteIntensitiesWide <- read.csv("../input/filesfitbit/minuteIntensitiesWide_merged.csv")
head(minuteIntensitiesWide)
minuteIntensitiesWide <- minuteIntensitiesWide %>%
  mutate(ActivityHour = mdy_hms(ActivityHour) %>% format("%m/%d/%Y %H:%M:%S"))
write.csv(minuteIntensitiesWide, file = "../input/filesfitbit/minuteIntensitiesWide_merged.csv", row.names = FALSE)

minuteMETsNarrow <- read.csv("../input/filesfitbit/minuteMETsNarrow_merged.csv")
head(minuteMETsNarrow)
minuteMETsNarrow <- minuteMETsNarrow %>%
  mutate(ActivityMinute = mdy_hms(ActivityMinute) %>% format("%m/%d/%Y %H:%M:%S"))
write.csv(minuteMETsNarrow, file = "../input/filesfitbit/minuteMETsNarrow_merged.csv", row.names = FALSE)

minuteSleep <- read.csv("../input/filesfitbit/minuteSleep_merged.csv")
head(minuteSleep)
minuteSleep <- minuteSleep %>%
  mutate(date = mdy_hms(date) %>% format("%m/%d/%Y %H:%M:%S"))
write.csv(minuteSleep, file = "../input/filesfitbit/minuteSleep_merged.csv", row.names = FALSE)

minuteStepsNarrow <- read.csv("../input/filesfitbit/minuteStepsNarrow_merged.csv")
head(minuteStepsNarrow)
minuteStepsNarrow <- minuteStepsNarrow %>%
  mutate(ActivityMinute = mdy_hms(ActivityMinute) %>% format("%m/%d/%Y %H:%M:%S"))
write.csv(minuteStepsNarrow, file = "../input/filesfitbit/minuteStepsNarrow_merged.csv", row.names = FALSE)

minuteStepsWide <- read.csv("../input/filesfitbit/minuteStepsWide_merged.csv")
head(minuteStepsWide)
minuteStepsWide <- minuteStepsWide %>%
  mutate(ActivityHour = mdy_hms(ActivityHour) %>% format("%m/%d/%Y %H:%M:%S"))
write.csv(minuteStepsWide, file = "../input/filesfitbit/minuteStepsWide_merged.csv", row.names = FALSE)

sleepDay <- read.csv("../input/filesfitbit/sleepDay_merged.csv")
head(sleepDay)
sleepDay <- sleepDay %>%
  mutate(SleepDay = mdy_hms(SleepDay) %>% format("%m/%d/%Y %H:%M:%S"))
write.csv(sleepDay, file = "../input/filesfitbit/sleepDay_merged.csv", row.names = FALSE)

weightLogInfo <- read.csv("../input/filesfitbit/weightLogInfo_merged.csv")
head(weightLogInfo)
weightLogInfo <- weightLogInfo %>%
  mutate(Date = mdy_hms(Date) %>% format("%m/%d/%Y %H:%M:%S"))
write.csv(weightLogInfo, file = "../input/filesfitbit/weightLogInfo_merged.csv", row.names = FALSE)