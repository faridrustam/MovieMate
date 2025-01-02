//
//  HomeControllerViewModel.swift
//  MovieMate
//
//  Created by Farid Rustamov on 02.01.25.
//

import Foundation

class HomeViewModel {
    var movieList: [MovieModel] = []
    
    func getMovieList() {
        if let fileUrl = Bundle.main.url(forResource: "Movies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                movieList = try JSONDecoder().decode([MovieModel].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
