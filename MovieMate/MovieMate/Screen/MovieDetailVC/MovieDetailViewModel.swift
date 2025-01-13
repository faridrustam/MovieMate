//
//  MovieDetailViewModel.swift
//  MovieMate
//
//  Created by Farid Rustamov on 12.01.25.
//

import Foundation

class MovieDetailViewModel {
    var movieDetail: MovieModel?
    var categorySelected: String?
    var movieSelected = [WatchList]()
    var savedMovies = [MovieModel]()
    let dataManager = WatchListCoreData()
    let userDefaultsManager = UserDefaultsManager()
}
