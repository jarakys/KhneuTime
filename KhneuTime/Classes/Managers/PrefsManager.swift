//
//  PrefsManager.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 07.02.2021.
//

import Foundation

enum Prefs: String {
    case selectedGroups
    case selectedFaculties
    case synced
    case notFirstLaunch
}

class PrefsManager {
    
    static let shared = PrefsManager()
    
    private let prefs = UserDefaults.standard
    
    private init() { }
    
    func set<T>(pref: Prefs, value: T) {
        prefs.setValue(value, forKey: pref.rawValue)
    }
    
    func get<T>(pref: Prefs) -> T? {
        prefs.object(forKey: pref.rawValue) as? T
    }
}
