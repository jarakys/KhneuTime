//
//  RouteEntitiesForUpdateFabric.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 07.02.2021.
//

import Foundation

class RouteEntitiesForUpdateFabric {
    static func getRouteEntities(entity: SyncEntitiesEnum) -> [APIRouter] {
        var routes = [APIRouter]()
        switch entity {
        case .faculties:
            routes = [.faculties]
//        case .groups:
//            routes = [.groups]
//        case .specialties:
//            routes = [.specialties]
//        case .schedule:
//            let ids = PrefsManager.shared.get(pref: .selectedGroups)
//            for id in ids {
//                routes.append(.shedule(groupId: id))
//            }
        }
        return routes
    }
}
