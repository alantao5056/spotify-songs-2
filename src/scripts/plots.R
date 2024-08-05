library(tidyverse)
library(tidybayes)
library(gtsummary)
library(brms)

# load model
model <- readRDS("C:/git/alantao5056/R/projects2/spotify-songs-2/src/scripts/model.rds")

# get mean of variables
spotify |>
  summarize(
    danceability = mean(danceability),
    speechiness = mean(speechiness),
    valence = mean(valence),
    tempo = mean(tempo),
    duration_s = mean(duration_s))

# generate ndata for only genre
playlist_genre <- c("edm", "latin", "pop", "r&b", "rap", "rock")
danceability = c(65.4)
speechiness = c(10.9)
valence = c(50.6)
tempo = c(121)
duration_s = c(225)

ndata1 <- expand_grid(playlist_genre, danceability, speechiness, valence, tempo, duration_s)

# drawing for only genre
draws1 <-
  model |>
    add_epred_draws(newdata = ndata1)

# plot for only genre
draws1 |>
  ggplot(aes(x = .epred, y = fct_reorder(playlist_genre, .epred))) +
  stat_slab() +
  theme_bw() +
  labs(title = "Posterior for Popularity Given Playlist Genre",
       subtitle = "Assuming that all other variables are set to the average",
       x = "Popularity",
       y = "Genre")

ggsave("src/plots/genre.png", width = 8, height = 6)
