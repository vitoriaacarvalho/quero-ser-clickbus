//
//  Movie.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import Foundation

struct Movie: Decodable {

    let id: Int

    let title: String

    let overview: String
    
    let releaseDate: String
    
    let genreIds: [Int]
    
    let voteCount: Int
    
    let voteAverage: Double
    
    let posterPath: String?
    
    let backdropPath: String?
    
    var relaseDateFormatted: String? {
        releaseDate
            .asDate(format: "yyyy-MM-dd")?
            .stringFormat
    }
}
