//
//  CacheManagerImpl.swift
//  ios-app
//
//  Created by Koji Osugi on 15/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

class CacheManagerImpl: CacheManager {
    
    func getString(key: String, defaultValue: String = "") -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: key) ?? defaultValue
    }
    
    func putString(key: String, value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    func getBoolean(key: String, defaultValue: Bool) -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: key)
    }
    
    func putBoolean(key: String, value: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
}
