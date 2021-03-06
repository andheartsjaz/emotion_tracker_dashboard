library(data.table)
library(ggplot2)
library(plotly)
source("utils/read_data.R")


# nolint start
EMOTIONS = c("Angry", "Scared", "Happy", "Sad", "Surprised", "Neutral")

EMOTION_DF = read_data()

# Create sort order of app names for alphabetical with "NA" at end
non_na_apps = setdiff(unique(EMOTION_DF$active_app_name), "NA")

APPS = c(sort(non_na_apps), "NA")
APPS_OF_INTEREST = c("PyCharm", "RStudio", "Microsoft Excel",
                     "Tableau Public", "Terminal")

EMOTION_DF[, active_app_name := factor(active_app_name, levels = rev(APPS))]

SCL_EMOTION_DF = data.table::copy(EMOTION_DF)
SCL_EMOTION_DF[, (EMOTIONS) := lapply(.SD, scale), .SDcols = EMOTIONS]

MIN_DATE = EMOTION_DF[, as.Date(min(timestamp))]
MAX_DATE = EMOTION_DF[, as.Date(max(timestamp))]
A_MONTH_AGO = seq(from=MAX_DATE, length.out = 2, by="-1 month")[2]

MIN_HOUR = EMOTION_DF[, min(ts_hour)]
MAX_HOUR = EMOTION_DF[, max(ts_hour)]
# nolint end
