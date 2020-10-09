//
//  MovieDetailsWorker.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import Alamofire
import Foundation

typealias MovieDetailsSuccess = (_ response: MovieDetails?) -> Void
typealias MovieDetailsError = (_ error: AFError?) -> Void

protocol MovieDetailsWorkerProtocol {
    
    func fetchMovieDetails(of movieId: Int,
                           sucess: @escaping MovieDetailsSuccess,
                           failure: @escaping MovieDetailsError)
}

class MovieDetailsWorker: MovieDetailsWorkerProtocol {
    
    func fetchMovieDetails(of movieId: Int,
                           sucess: @escaping MovieDetailsSuccess,
                           failure: @escaping MovieDetailsError) {
        
        let enconding = JSONEncoding.default
        let url = MovieAPI.build(detailsOf: movieId)
        
        Network().request(
            data: RequestData(url: url, method: .get, encoding: enconding),
            decoder: SnakeCaseDecoder(expectation: MovieDetails.self),
            success: { response in
                sucess(response)
            },
            failure: {error in
                failure(error)
            })
        
    }
}
