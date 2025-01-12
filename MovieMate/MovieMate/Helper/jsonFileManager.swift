//
//  JSONFile.swift
//  MovieMate
//
//  Created by Farid Rustamov on 12.01.25.
//

import Foundation

class jsonFileManager {
    var movies: [MovieModel] = []
    var categories: [CategoryModel] = []
    
    func getMovieList(completion: (([MovieModel]) -> Void)?) {
        if let fileUrl = Bundle.main.url(forResource: "Movies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                movies = try JSONDecoder().decode([MovieModel].self, from: data)
                completion?(movies)
                
            } catch {
                print("Movie list error: \(error.localizedDescription)")
            }
        }
    }
    
    func getCategoryList(completion: (([CategoryModel]) -> Void)?) {
        if let fileUrl = Bundle.main.url(forResource: "Categories", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                categories = try JSONDecoder().decode([CategoryModel].self, from: data)
                completion?(categories)
            } catch {
                print("Category list error: \(error.localizedDescription)")
            }
        }
    }
}
