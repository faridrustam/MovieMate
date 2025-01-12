//
//  CoreDataModel.swift
//  MovieMate
//
//  Created by Farid Rustamov on 08.01.25.
//

import Foundation

class WatchListCoreData {
    let context = AppDelegate().persistentContainer.viewContext
    var watchList = [WatchList]()
    let userDefaultsManager = UserDefaultsManager()
    
    func fetchWatchList(completion: (() -> Void)?) {
        do {
            watchList = try context.fetch(WatchList.fetchRequest())
            completion?()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveWatchList(movieModel: MovieModel) {
        let model = WatchList(context: context)
        
        model.categoryId = movieModel.category
        model.movieName = movieModel.movieName
        model.posterImage = movieModel.posterImage
        model.bacgroundImage = movieModel.backgroundImage
        model.aboutMovie = movieModel.aboutMovie
        model.rating = movieModel.rating ?? 0
        model.releaseDate = movieModel.releaseDate
        model.time = movieModel.time
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteWatchList(movie: WatchList, completion: (() -> Void)?) {
        context.delete(movie)
        do {
            try context.save()
            completion?()
        } catch {
            print("Failed to delete movie: \(error)")
        }
    }
}
