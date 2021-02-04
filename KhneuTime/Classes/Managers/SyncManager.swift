//
//  SyncManager.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 04.02.2021.
//

import Foundation

enum SyncEntitiesEnum: CaseIterable {
    case specialties
    case faculties
    case groups
    case schedule
    
    var route: APIRouter {
        .faculties
    }
    
    var description: String {
        "Specialties"
    }
    
    var entityName: String {
        "SpecialtyDB"
    }
}

class SyncManager {
    
    static let shared = SyncManager()
    
    let entities = SyncEntitiesEnum.allCases
    
    private init() { }
    
    func startInit() { }
    
    func startSync() {
    }
    
}
