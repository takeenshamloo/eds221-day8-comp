library(tidyverse)
library(patchwork)
library(here)

lizards <- read_csv(here("data_tidy", "lizards.csv"))

two_lizards <- lizards |>
  filter(common_name %in% c("eastern fence", "western whiptail"))

p1 <- ggplot(two_lizards, aes(x = total_length, y = weight)) +
  geom_point(aes(color = common_name)) +
  theme_bw() +
  scale_color_manual(values = c("maroon", "cyan4"),
                     name = "Lizard Species",
                     labels = c("Eastern fence lizard",
                                "Western whiptail lizard")) +
  theme(legend.position = c(0.2, 0.85),
        legend.background = element_blank()) +
  labs(x = "Weight (g)", y = "Total Length (mm)")

p2 <- ggplot(lizards, aes(x = weight, y = site)) +
  geom_boxplot() +
  labs(x = "Weight (g)",
       y = "Site")

p3 <- ggplot(lizards, aes(x = weight)) +
  geom_histogram() +
  labs(x = "Weight (g)",
       y = "Count (n)")

((p1 + p2) / p3) & theme_minimal()