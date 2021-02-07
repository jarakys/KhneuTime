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
}

class PrefsManager {
    
    static let shared = PrefsManager()
    
    private let prefs = UserDefaults.standard
    
    private init() { }
    
    func set(pref: Prefs, id: Int) {
        var array = get(pref: pref)
        array.append(id)
        prefs.setValue(array, forKey: pref.rawValue)
    }
    
    func get(pref: Prefs) -> [Int] {
        prefs.array(forKey: pref.rawValue)?.compactMap({$0 as? Int}) ?? []
    }
}
