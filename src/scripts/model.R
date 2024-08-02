library(tidyverse)
library(tidybayes)
library(gtsummary)
library(brms)

spotify <- read_csv("src/data/spotify_30000.csv")

fit <- brm(
  data = spotify,
  family = gaussian(),
  formula = track_popularity ~ playlist_genre + danceability + speechiness + valence + tempo,
  silent = 2,
  refresh = 0,
  seed = 9
)

fit
