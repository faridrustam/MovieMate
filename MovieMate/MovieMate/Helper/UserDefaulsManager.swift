//
//  UserDefaulsManager.swift
//  MovieMate
//
//  Created by Farid Rustamov on 08.01.25.
//

import Foundation

class UserDefaultsManager {
    
    func setBookmarkState(movieName: String, isBookmarked: Bool) {
        UserDefaults.standard.set(isBookmarked, forKey: "\(movieName)")
    }

    func getBookmarkState(movieName: String) -> Bool {
        return UserDefaults.standard.bool(forKey: "\(movieName)")
    }
    
    func setWatchListState(movieName: String, isWatchlisted: Bool) {
        UserDefaults.standard.set(isWatchlisted, forKey: "\(movieName)")
    }
    
    func getWatchListState(movieName: String) -> Bool {
        return UserDefaults.standard.bool(forKey: "\(movieName)")
    }
}
