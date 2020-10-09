//
//  Movie.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import Foundation

struct Credits: Decodable {
    
    let cast: [Cast]
    
    let crew: [Crew]
    
}
