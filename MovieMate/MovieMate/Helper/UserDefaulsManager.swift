//
//  UserDefaulsManager.swift
//  MovieMate
//
//  Created by Farid Rustamov on 08.01.25.
//

import Foundation

class UserDefaultsManager {
    enum Keys: String, CaseIterable {
        case movieSaved = "movieSaved"
    }
    
    func setValue(value: Any, key: Keys) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    
    func getValue(key: Keys = .movieSaved) -> Bool {
        UserDefaults.standard.bool(forKey: key.rawValue)
    }
}
