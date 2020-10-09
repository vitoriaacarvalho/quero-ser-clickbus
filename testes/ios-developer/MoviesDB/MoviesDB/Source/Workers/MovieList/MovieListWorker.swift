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
    
    var currentPage: Int { get }
    
    func nextPage()
    
    func fetchMovieList(section: Section,
                        sucess: @escaping MovieListSuccess,
                        failure: @escaping MovieListError)
}

class MovieListWorker: MovieListWorkerProtocol {

    var currentPage = 1
    
    func fetchMovieList(section: Section,
                        sucess: @escaping MovieListSuccess,
                        failure: @escaping MovieListError) {
        
        let enconding = JSONEncoding.default
        let url = MovieAPI.build(section: section, page: currentPage)
        
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
    
    func nextPage() {
        self.currentPage += 1
    }
}
