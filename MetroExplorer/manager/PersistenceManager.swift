//
//  PersistenceManager.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/26/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import Foundation

class PersistenceManager {
    static let sharedInstance = PersistenceManager()
    
    let favlandmarksKey = "favlandmarks"
    
    func saveLandmark(favlandmark: FavLandmark) {
        let userDefaults = UserDefaults.standard
        
        var favlandmarks = fetchFavLandmarks()
        favlandmarks.append(favlandmark)
        
        let encoder = JSONEncoder()
        let encodedLandmarks = try? encoder.encode(favlandmarks)
        
        userDefaults.set(encodedLandmarks, forKey: favlandmarksKey)
    }
    
    func fetchFavLandmarks() -> [FavLandmark] {
        let userDefaults = UserDefaults.standard
        
        if let favlandmarkData = userDefaults.data(forKey: favlandmarksKey), let favlandmarks = try? JSONDecoder().decode([FavLandmark].self, from: favlandmarkData) {
            //workoutData is non-nil and successfully decoded
            return favlandmarks
        }
        else {
            return [FavLandmark]()
        }
    }
    
    func fetchLandmarksRecord() -> [FavLandmark] {
        let favlandmarks = fetchFavLandmarks()
        return favlandmarks
    }
    
//    func updateFavLandmarks(FavLandmarks: [FavLandmark]) -> [FavLandmark]{
//
//    }
    
//    func deleteFavLandmarks(favlandmark: FavLandmark) {
//        let userDefaults = UserDefaults.standard
//
//        var favlandmarks = fetchFavLandmarks()
//        favlandmarks.remove(at: IndexPath.item)
//
//        let encoder = JSONEncoder()
//        let encodedLandmarks = try? encoder.encode(favlandmarks)
//
//        userDefaults.set(encodedLandmarks, forKey: favlandmarksKey)    }
}
