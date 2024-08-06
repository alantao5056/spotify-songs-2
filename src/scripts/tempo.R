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
speechiness = c(10.9)
valence = c(50.6)
tempo = c(-2, -1, 0, 1, 2)
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
    tempo = case_when(
      tempo == -2 ~ "Very Slow (-2σ)",
      tempo == -1 ~ "Slightly Slow (-1σ)",
      tempo == 0 ~ "Average (0σ)",
      tempo == 1 ~ "Slightly Fast (1σ)",
      tempo == 2 ~ "Very Fast (2σ)"
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
  stat_slab(aes(fill = fct_reorder(tempo, .epred)), alpha = 0.7) +
  theme_bw() +
  labs(title = "Prediction of Popularity Given Genre and Tempo",
       subtitle = "Assuming that all other variables are set to the average",
       x = "Popularity",
       y = "Genre",
       fill = "Tempo")

ggsave("src/plots/tempo.png", width = 8, height = 6)
