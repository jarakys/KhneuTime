//
//  SyncManager.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 04.02.2021.
//

import Foundation

enum SyncEntitiesEnum: CaseIterable {
//    case specialties
    case faculties
//    case groups
//    case schedule(groupId: Int)
    
    static var allCases: [SyncEntitiesEnum] {
        return [.faculties/*.specialties, .faculties, .groups, .schedule(groupId: -1)*/]
    }
    
    var description: String {
        "Faculties"
    }
    
    var entityName: String {
        "FacultyDB"
    }
    
    //    var route: APIRouter {
    //        switch self {
    //        case .faculties:
    //            return .faculties
    //        case let .specialties(facultyId):
    //            return .specialties(facultetId: facultyId)
    //        case let .groups(facultyId, specialtyId, course):
    //            return .groups(facultetId: facultyId, specialitId: specialtyId, course: course)
    //        default: return .faculties
    //        }
    //    }
}

class SyncManager {
    
    static let shared = SyncManager()
    
    let entities = SyncEntitiesEnum.allCases
    
    private init() { }
    
    func startInit() {
        var currentOperation: Operation?
        let operationQueue = OperationQueue()
        for entity in entities {
            let operation = AsynchronousOperation()
            let routes = RouteEntitiesForUpdateFabric.getRouteEntities(entity: entity)
            if let currentOperation = currentOperation {
                operation.addDependency(currentOperation)
            }
            operation.block = {
                let sem = DispatchSemaphore(value: 0)
                for route in routes {
                    NetworkManager.shared.sendRequest(route: route, completion: {result in
                        if case let .success(data) = result {
                            DatabaseManager.shared.insertOrUpdateObject(entity: entity, data: data)
                        }
                        sem.signal()
                    })
                }
                sem.wait()
            }
            currentOperation = operation
            operationQueue.addOperation(operation)
        }
    }
    
    func startSync() {
    }
}
