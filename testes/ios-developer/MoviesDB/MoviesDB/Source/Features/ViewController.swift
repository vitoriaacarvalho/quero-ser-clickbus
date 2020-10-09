//
//  ViewController.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // EXEMPLO DE COMO OBTER A LISTA DE FILMES POPULARES
        
        MovieListWorker().fetchMovieList(
            section: .popular,
            sucess: { response in
                guard let movies = response?.results else { return }
                print(movies)
            },
            failure: { error in
                print(error!)
            })
        
        
        // EXEMPLO DE COMO OBTER OS DETALHES DE UM FILME
        
        MovieDetailsWorker().fetchMovieDetails(
            of: 497582, // COLOQUE O ID DO FILME AQUI
            sucess: { details in
                guard let details = details else { return }
                print(details)
            },
            failure: { error in
                print(error!)
            })
        
        
        // EXEMPLO DE COMO OBTER A LISTA GÊNEROS
        
        GenreListWorker().fetchGenreList(
            sucess: { response in
                guard let genres = response?.genres else { return }
                print(genres)
            },
            failure: { error in
                print(error!)
            })
    }
}

