//
//  SnakeCaseDecoder.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import Foundation

class SnakeCaseDecoder<T: Decodable>: DefaultDecoder<T> {
    
    override func decode(from data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(expectation.self, from: data)
    }
}
