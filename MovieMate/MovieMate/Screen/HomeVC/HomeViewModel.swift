//
//  HomeControllerViewModel.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import Foundation

class HomeViewModel {
    let jsonManager = jsonFileManager()
    var movieList: [MovieModel] = []
    var categoryList: [CategoryModel] = []
    var filteredMovieList: [MovieModel] = []
    var isSegmentCellConfigured = false
    var callBack: (() -> Void)?
    
    func getMovies() {
        jsonManager.getMovieList { movies in
            self.movieList = movies
        }
    }
    
    func getCategories() {
        jsonManager.getCategoryList { categories in
            self.categoryList = categories
        }
    }
    
    func filterMoviesByCategory(category: CategoryModel) {
        filteredMovieList = movieList.filter { $0.category == category.categoryName }
        callBack?()
    }
}
