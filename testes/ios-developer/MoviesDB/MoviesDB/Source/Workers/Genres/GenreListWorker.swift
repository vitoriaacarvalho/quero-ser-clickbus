//
//  GenresWorker.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import Alamofire
import Foundation

typealias GenresSuccess = (_ response: GenreListResponse?) -> Void
typealias GenresError = (_ error: AFError?) -> Void

protocol GenreListWorkerProtocol {
    
    func fetchGenreList(sucess: @escaping GenresSuccess,
                        failure: @escaping GenresError)
}

class GenreListWorker: GenreListWorkerProtocol {
    
    func fetchGenreList(sucess: @escaping GenresSuccess,
                        failure: @escaping GenresError) {
        
        let enconding = JSONEncoding.default
        let url = MovieAPI.genreURL
        
        Network().request(
            data: RequestData(url: url, method: .get, encoding: enconding),
            decoder: SnakeCaseDecoder(expectation: GenreListResponse.self),
            success: { response in
                sucess(response)
            },
            failure: {error in
                failure(error)
            })
    }
}
