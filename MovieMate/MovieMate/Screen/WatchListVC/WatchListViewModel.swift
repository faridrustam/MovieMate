//
//  WatchListViewModel.swift
//  MovieMate
//
//  Created by Farid Rustamov on 12.01.25.
//

import Foundation

class WatchListViewModel {
    var watchList: [WatchList] = []
    let dataManager = WatchListCoreData()
    let movieDetailVC = MovieDetailVC()
    
    func fetchData(completion: (() -> Void)?) {
        dataManager.fetchWatchList {
            self.watchList = self.dataManager.watchList
            completion?()
        }
    }
    
    func deleteMovie(index: Int, completion: (() -> Void)?) {
        dataManager.deleteWatchList(movie: watchList[index]) {
            self.watchList.remove(at: index)
            completion?()
        }
    }
}


