# Spotify Songs v2
Check out the finished website here: [Spotify Songs v2](https://alienjao.quarto.pub/spotify-songs-v2/). 

## Introduction
My name is Alan Tao, and this website is a project I made in [Kane’s Free Data Science Bootcamp](https://bootcamp.davidkane.info/). I’m really interested in music in general, so I decided to focus my project on this topic. Making this website took a lot of effort because Bayesian regression models take a long time to run. Please support me by viewing my work and also my [YouTube Channel](https://www.youtube.com/channel/UCzdtyvYuUM6EGKhtsbF_jhQ).

## Project Summary
This project is an extension to [Spotify Songs v1](https://alienjao.quarto.pub/spotify-songs). This is a more in-depth analysis of specifically the [30000 Spotify Songs](https://www.kaggle.com/datasets/joebeachcapital/30000-spotify-songs) dataset from [Kaggle](https://www.kaggle.com/). It contains a Bayesian Regression Model using the brms package form R. I modeled popularity, a variable from 0 to 100 where 100 means most popular, as a logistic function of genre, danceabillity, speechiness, valence, tempo, and duration.  Specifically here is the formula:

$$trackPopularity_i = \beta_{0} + \beta_{1}playlistGenre_i + \beta_{2}danceability_i + \beta_{3}speechiness_i + \beta_{4}valence_i + \beta_{5}tempo_i + \beta_{6}duration_i + \epsilon_{i}$$
