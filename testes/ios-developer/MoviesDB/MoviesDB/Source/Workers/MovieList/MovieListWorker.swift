//
//  MovieListWorker.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import Alamofire

typealias MovieListSuccess = (_ response: MovieListResponse?) -> Void
typealias MovieListError = (_ error: AFError?) -> Void

protocol MovieListWorkerProtocol {
    
    func fetchMovieList(section: Section, page: Int,
                        sucess: @escaping MovieListSuccess,
                        failure: @escaping MovieListError)
}

class MovieListWorker: MovieListWorkerProtocol {
    
    func fetchMovieList(section: Section, page: Int,
                        sucess: @escaping MovieListSuccess,
                        failure: @escaping MovieListError) {
        
        let enconding = JSONEncoding.default
        let url = MovieAPI.build(section: section, page: page)
        
        Network().request(
            data: RequestData(url: url, method: .get, encoding: enconding),
            decoder: SnakeCaseDecoder(expectation: MovieListResponse.self),
            success: { response in
                sucess(response)
            },
            failure: {error in
                failure(error)
            })
    }
}
