#---
#title: Shot Chart Script
#description: Creating a shot chart of makes/misses
#input: 
#output: 
#---

library(ggplot2)
library(grid)
library(jpeg)
klay_scatterplot <- ggplot(data = thompson) +
  geom_point(aes(x = x, y = y, color = shot_made_flag))

curry_scatterplot <- ggplot(data = curry) +
  geom_point(aes(x = x, y = y, color = shot_made_flag))

green_scatterplot <- ggplot(data = green) +
  geom_point(aes(x = x, y = y, color = shot_made_flag))

iggy_scatterplot <- ggplot(data = iggy) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag))

durant_scatterplot <- ggplot(data = durant) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag))

# court image (to be used as background of plot)
court_file <- "images/nba-court.jpg"

# create raste object
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc"))

# shot chart with court background
klay_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()

curry_shot_chart <- ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Steph Curry (2016 season)') +
  theme_minimal()

green_shot_chart <- ggplot(data = green) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()

durant_shot_chart <- ggplot(data = durant ) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()

iggy_shot_chart <- ggplot(data = durant ) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()

facetted_big <- ggplot(data = gi_df) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Combined Chart of Warrior Players') +
  theme_minimal() + facet_wrap(name ~.)
  
ggsave("../images/kevin-durant-shot-chart.pdf", durant_shot_chart, 
     width = 6.5, height = 5)

ggsave("../images/andre-iguodala-shot-chart.pdf", iggy_shot_chart, 
       width = 6.5, height = 5)

ggsave("../images/draymond-green-shot-chart.pdf", green_shot_chart, 
       width = 6.5, height = 5)

ggsave("../images/steph-curry-shot-chart.pdf", curry_shot_chart, 
       width = 6.5, height = 5)


ggsave("../images/klay-thompson-shot-chart.pdf", klay_shot_chart, 
       width = 6.5, height = 5)


ggsave("../images/gsw-shot-charts.pdf", facetted_big,
       width = 8, height = 7)
ggsave("../images/gsw-shot-charts.png", facetted_big,
       width = 8, height = 7)

