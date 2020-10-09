//
//  ResquestData.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import Alamofire

struct RequestData {
    
    var url: String
    
    var method: HTTPMethod
    
    var encoding: ParameterEncoding
    
    var parameters: [String: Any]?
}
