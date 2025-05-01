## Exemplary code conducted with rainfall data for Naples, Florida.

## This code chunk shows how I first loaded each package,
## cleaned the data, and created a graph for visualization.

## 1. Loading packages:
library("dplyr")
library("ggplot2")

## 2. Loading the dataset:
Naples <- read.csv("Naples_Rain.csv")

## 3. Filtering and mutating the data:
Naples <- Naples %>%
  filter(PRECIPITATION >= 0, MEAN.TEMP >= 0) %>%
  mutate(COOPID = if_else(COOPID == 86078, "Naples", as.character(COOPID)))

## 4. Data grouping and manipulation:
Naples <- Naples %>%
  group_by(YEAR) %>%
  summarize(
    total_precip = sum(PRECIPITATION, na.rm = TRUE),
    mean_temp = mean(MEAN.TEMP, na.rm = TRUE),
    .groups = "drop"
  )
  
## 5. Creating personalized plots with the clean dataset:
ggplot(Naples, aes(x = YEAR)) +
  geom_line(aes(y = total_precip, color = "Total Precip (in)")) +
  geom_smooth(aes(y = total_precip, color = "Total Precip (in)"), 
              method = "lm", se = FALSE, linetype = "dashed") +
  geom_line(aes(y = mean_temp, color = "Mean Temp (F)")) +
  scale_x_continuous(
    limits = c(1942, 2022)
  ) +
  scale_y_continuous(
    limits = c(0, 100),
    name = "Inches and Fahrenheit",
  ) +
  scale_color_manual(
    name = NULL,
    values = c("Total Precip (in)" = "blue", "Mean Temp (F)" = "red")
  ) +
  labs(
    title = "Annual Total Precip and Mean Temperature for Naples",
    x = "Year"
  ) +
  theme_minimal()