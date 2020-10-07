package com.clickbus.moviesdbtest.movies.callbacks

import com.clickbus.moviesdbtest.movies.models.Movie

interface MovieListListener {
    fun onSuccess(list: List<Movie>)
    fun onFailure(message: String? = null)
}