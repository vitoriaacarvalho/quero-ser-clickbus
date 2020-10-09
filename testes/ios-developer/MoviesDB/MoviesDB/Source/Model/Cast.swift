//
//  Movie.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import Foundation

struct Cast: Decodable {
    
    let name: String
    
    let character: String
    
    let profilePath: String?
}
