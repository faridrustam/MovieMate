//
//  MovieSearchViewModel.swift
//  MovieMate
//
//  Created by Farid Rustamov on 12.01.25.
//

import Foundation

class MovieSearchViewModel {
    let jsonManager = jsonFileManager()
    var movies: [MovieModel] = []
    var filteredMovies: [MovieModel] = []
    
    func getMovies() {
        jsonManager.getMovieList { movies in
            self.movies = movies
        }
    }
    
    func filterSearch(searchText: String, completion: (() -> Void)?) {
        filteredMovies = movies.filter {
            ($0.movieName?.lowercased().contains(searchText.lowercased()) ?? false) ||
            ($0.category?.lowercased().contains(searchText.lowercased()) ?? false)
        }
        completion?()
    }
    
    func movieSearchChange(searchTextField: String, completion: (() -> Void)?) {
        if searchTextField.isEmpty {
            filteredMovies = movies
            completion?()
        } else {
            filterSearch(searchText: searchTextField) {
                completion?()
            }
        }
    }
}
