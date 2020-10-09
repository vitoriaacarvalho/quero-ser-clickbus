//
//  GenreListResponse.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import Foundation

struct GenreListResponse: Decodable {
    
    let genres: [Genre]
}
