//
//  DefaultDecoder.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import Foundation

class DefaultDecoder<T: Decodable> {
    
    var expectation: T.Type
    
    init(expectation: T.Type) {
        self.expectation = expectation
    }
    
    func decode(from data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
