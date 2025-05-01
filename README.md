# Portfolio

This repository contains some examples of my best, polished code chunks, along with a slide deck built in R using xaringan and a codebook done in R Markdown. My research topic focuses on climate data, where extreme winter weather events in Europe were analyzed in the codebook, and trends in Florida rainfall amounts were looked at in the slide deck. The code chunk below serves as an example of the skills I have gathered during my Data Analysis course. 

# Data Source and Code: 
[Download the data file](Naples Rain.csv)
https://climatecenter.fsu.edu/climate-data-access-tools/downloadable-data

Naples <- Naples %>%
  filter(PRECIPITATION >= 0, MEAN.TEMP >= 0) %>%
  mutate(COOPID = if_else(COOPID == 86078, "Naples", as.character(COOPID)))
  group_by(YEAR) %>%
  summarize(
    total_precip = sum(PRECIPITATION, na.rm = TRUE),
    mean_temp = mean(MEAN.TEMP, na.rm = TRUE),
    .groups = "drop"
  )

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
