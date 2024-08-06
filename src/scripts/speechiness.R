library(tidyverse)
library(tidybayes)
library(gtsummary)
library(brms)
library(viridis)

# load model
model <- readRDS("C:/git/alantao5056/R/projects2/spotify-songs-2/src/scripts/model.rds")

# generate ndata for only genre
playlist_genre <- c("edm", "latin", "pop", "r&b", "rap", "rock")
danceability = c(65.4)
speechiness = c(0, 25, 50, 75, 100)
valence = c(50.6)
tempo = c(0)
duration_s = c(0)

ndata <- expand_grid(playlist_genre, danceability, speechiness, valence, tempo, duration_s)

# drawing for only genre
draws <-
  model |>
  add_epred_draws(newdata = ndata)

# cleaning draws
draws <-
  draws |>
  mutate(
    speechiness = case_when(
      speechiness == 0 ~ "Not Speechy - 0",
      speechiness == 25 ~ "Slightly Speechy - 25",
      speechiness == 50 ~ "Moderately Speechy - 50",
      speechiness == 75 ~ "Very Speechy - 75",
      speechiness == 100 ~ "Extremely Speechy - 100"
    ),
    playlist_genre = case_when(
      playlist_genre == "pop" ~ "Pop",
      playlist_genre == "rock" ~ "Rock",
      playlist_genre == "rap" ~ "Rap",
      playlist_genre == "latin" ~ "Latin",
      playlist_genre == "r&b" ~ "R&B",
      playlist_genre == "edm" ~ "EDM"
    )
  )

# plot for only genre
draws |>
  ggplot(aes(x = .epred, y = fct_reorder(playlist_genre, .epred))) +
  scale_fill_viridis_d() +
  stat_slab(aes(fill = fct_reorder(speechiness, .epred, .desc = TRUE)), alpha = 0.7) +
  theme_bw() +
  labs(title = "Prediction of Popularity Given Genre and Speechiness",
       subtitle = "Assuming that all other variables are set to the average",
       x = "Popularity",
       y = "Genre",
       fill = "Speechiness")

ggsave("src/plots/speechiness.png", width = 8, height = 6)
