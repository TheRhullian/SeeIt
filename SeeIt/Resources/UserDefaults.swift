//
//  UserDefaults.swift
//  SeeIt
//
//  Created by Rhullian Damião on 03/02/22.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    enum Keys {
        static let favorites = "Favoritos"
    }
    
    
    let defaults = UserDefaults.standard
    
    var favorites: [Show] {
        get {
            guard let favsData = defaults.object(forKey: Keys.favorites) as? Data,
                  let favs = try? JSONDecoder().decode([Show].self, from: favsData) else { return [] }
            return favs
        }
        
        set {
            guard let encoded = try? JSONEncoder().encode(newValue) else { return }
            defaults.set(encoded, forKey: Keys.favorites)
        }
    }
}
