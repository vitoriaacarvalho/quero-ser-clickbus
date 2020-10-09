//
//  String+Extensions.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import Foundation

extension String {
    
    func asDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter.date(from: self)
    }
}
