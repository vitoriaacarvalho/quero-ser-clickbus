//
//  MovieAPI.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import Foundation

struct MovieAPI {

    // MARK: - Definitions
    
    enum ImageSize: String {
        case original
        case w780
        case w500
        case w300
        case w200
    }

    // MARK: - Internal Properties
    
    static let key: String = "API_KEY" // COLOQUE SUA API_KEY DO TMDB AQUI
    static let version: Int = 3
    static let baseURL: String = "https://api.themoviedb.org/\(MovieAPI.version)"
    static let imageURL: String = "https://image.tmdb.org/t/p"
    static let genreURL: String = "\(MovieAPI.baseURL)/genre/movie/list?api_key=\(MovieAPI.key)"
    
    static var language: String {
        return Locale.current.collatorIdentifier ?? "pt-BR"
    }
    
    static func build(image: String, size: ImageSize) -> String {
        return "\(MovieAPI.imageURL)/\(size.rawValue)/\(image)"
    }
    
    static func build(section: Section, page: Int) -> String {
        return "\(MovieAPI.baseURL)/movie/\(section.rawValue)"
            + "?api_key=\(MovieAPI.key)&language=\(language)&page=\(page)"
    }
    
    static func build(detailsOf id: Int) -> String {
        return "\(MovieAPI.baseURL)/movie/\(id)?api_key=\(MovieAPI.key)"
            + "&language=\(language)&append_to_response=videos,credits,recommendations"
    }
}
