//
//  UserDefaulsManager.swift
//  MovieMate
//
//  Created by Farid Rustamov on 08.01.25.
//

import Foundation

class UserDefaultsManager {
    
    func saveBookmarkState(movieName: String, isBookmarked: Bool) {
        UserDefaults.standard.set(isBookmarked, forKey: "bookmark_\(movieName)")
    }

    func getBookmarkState(movieName: String) -> Bool {
        return UserDefaults.standard.bool(forKey: "bookmark_\(movieName)")
    }
}
