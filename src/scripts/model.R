library(tidyverse)
library(tidybayes)
library(gtsummary)
library(brms)

# data cleaning
spotify <- read_csv("src/data/spotify_30000.csv")

spotify <-
spotify |>
  distinct(track_name, track_artist, .keep_all = TRUE) |>
  select(track_popularity,
         playlist_genre,
         danceability,
         speechiness,
         valence,
         tempo,
         duration_ms) |>
  mutate(danceability = danceability * 100,
         speechiness = speechiness * 100,
         valence = valence * 100,
         duration_s = duration_ms / 1000)


# model
fit <- brm(
  data = spotify,
  family = gaussian(),
  formula = track_popularity ~ playlist_genre + danceability + speechiness + valence + tempo + duration_s,
  silent = 2,
  refresh = 0,
  seed = 9,
  file = "model.rds"
)

