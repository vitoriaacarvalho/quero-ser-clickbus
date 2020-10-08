package com.clickbus.moviesdbtest.movies.models

import com.google.gson.annotations.SerializedName

data class GenreListContainer(@SerializedName("genres") val genres: List<Genre>)