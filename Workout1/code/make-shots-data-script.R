#---
#title: Data Script
#description: Creating csv file
#input: 
#output: 
#---

curry <- read.csv("data/stephen-curry.csv", stringsAsFactors = FALSE)
green <- read.csv("data/draymond-green.csv", stringsAsFactors = FALSE)
thompson <- read.csv("data/klay-thompson.csv", stringsAsFactors = FALSE)
iggy <- read.csv("data/andre-iguodala.csv", stringsAsFactors = FALSE)
durant <- read.csv("data/Kevin-Durant.csv", stringsAsFactors = FALSE)

library(dplyr)
curry <- mutate(curry, name = "Steph Curry")
green <- mutate(green, name = "Draymond Green")
thompson <- mutate(thompson, name = "Klay Thompson")
iggy <- mutate(iggy, name = "Andre Iguodala")
durant <- mutate(durant, name = "Kevin Durant")


iggy[iggy$shot_made_flag== "y", ]$shot_made_flag <- "shot_yes"
iggy[iggy$shot_made_flag == "n", ]$shot_made_flag <- "shot_no"

durant[durant$shot_made_flag == "y", ]$shot_made_flag <- "shot_yes"
durant[durant$shot_made_flag == "n", ]$shot_made_flag <- "shot_no"

curry[curry$shot_made_flag == "y", ]$shot_made_flag <- "shot_yes"
curry[curry$shot_made_flag == "n", ]$shot_made_flag <- "shot_no"

thompson[thompson$shot_made_flag =="y", ]$shot_made_flag <- "shot_yes"
thompson[thompson$shot_made_flag == "n", ]$shot_made_flag <- "shot_no"

green[green$shot_made_flag == "y", ]$shot_made_flag <- "shot_yes"
green[green$shot_made_flag == "n", ]$shot_made_flag <- "shot_no"

iggy_minute <- iggy$period * 12 - iggy$minutes_remaining
iggy$minute = iggy_minute

curry_minute <- curry$period * 12 - curry$minutes_remaining
curry$minute = curry_minute

durant_minute <- durant$period * 12 - durant$minutes_remaining
durant$minute = durant_minute

green_minute <- green$period * 12 - green$minutes_remaining
green$minute = green_minute

thompson_minute <- thompson$period * 12 - thompson$minutes_remaining
thompson$minute = thompson_minute

curry <- mutate(curry, name = "Steph Curry", minute = curry_minute)
green <- mutate(green, name = "Draymond Green", minute = green_minute)
thompson <- mutate(thompson, name = "Klay Thompson", minute = thompson_minute)
iggy <- mutate(iggy, name = "Andre Iguodala", iggy_minute)
durant <- mutate(durant, name = "Kevin Durant", durant_minute)

gi_df <- rbind(curry, thompson, durant, green, iggy)

#sink option
sink("andre-iguodala-summary.txt")
print(summary(iggy))
sink()

sink("draymond-green-summary.txt")
print(summary(green))
sink()

sink("kevin-durant-summary.txt")
print(summary(durant))
sink()

sink("stephen-curry-summary.txt")
print(summary(curry))
sink()

sink("klay-thompson-summary.txt")
print(summary(thompson))
sink()

write.csv(gi_df, "shots-data.csv")
sink("shots-data-summary.txt")
print(summary(gi_df))
sink()