//
//  HomeControllerViewModel.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import Foundation

class HomeViewModel {
    var movieList: [MovieModel] = []
    var categoryList: [CategoryModel] = []
    var filteredMovieList: [MovieModel] = []
    var callBack: (() -> Void)?
    
    func getMovieList() {
        if let fileUrl = Bundle.main.url(forResource: "Movies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                movieList = try JSONDecoder().decode([MovieModel].self, from: data)
            } catch {
                print("Movie list error: \(error.localizedDescription)")
            }
        }
    }
    
    func getCategoryList() {
        if let fileUrl = Bundle.main.url(forResource: "Categories", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                categoryList = try JSONDecoder().decode([CategoryModel].self, from: data)
            } catch {
                print("Category list error: \(error.localizedDescription)")
            }
        }
    }
    
    func filterMoviesByCategory(category: CategoryModel) {
        filteredMovieList = movieList.filter { $0.category == category.categoryName }
        callBack?()
    }
}
