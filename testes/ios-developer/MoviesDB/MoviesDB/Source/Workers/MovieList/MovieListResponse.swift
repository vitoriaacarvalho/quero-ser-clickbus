//
//  MovieListResponse.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import Foundation

struct MovieListResponse: Decodable {
    
    let page: Int
    
    let totalPages: Int
    
    let results: [Movie]
    
    let totalResults: Int
    
}
