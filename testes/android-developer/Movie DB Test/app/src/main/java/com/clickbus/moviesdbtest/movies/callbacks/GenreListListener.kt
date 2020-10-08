package com.clickbus.moviesdbtest.movies.callbacks

import com.clickbus.moviesdbtest.movies.models.Genre

interface GenreListListener {
    fun onSuccess(list: List<Genre>)
    fun onFailure(message: String? = null)
}