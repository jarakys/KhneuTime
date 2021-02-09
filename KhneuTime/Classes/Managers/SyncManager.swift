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
    //    case schedule(groupId: Int)
    
    static var allCases: [SyncEntitiesEnum] {
        return [.faculties, .specialties, .groups /*, .schedule(groupId: -1)*/]
    }
    
    var description: String {
        switch self {
        case .faculties:
            return "Faculties"
        case .specialties:
            return "Specialties"
        case .groups:
            return "Groups"
        default:
            return ""
        }
        
    }
    
    var entityName: String {
        switch self {
        case .faculties:
            return "FacultyDB"
        case .specialties:
            return "SpecialtyDB"
        case .groups:
            return "GroupDB"
        default:
            return ""
        }
    }
    
    var routes: [APIRouter] {
        switch self {
        case .faculties:
            return [.faculties]
        case .specialties:
            return [.specialties]
        case .groups:
            return [.groups]
        default: return [.faculties]
        }
    }
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
            if let currentOperation = currentOperation {
                operation.addDependency(currentOperation)
            }
            operation.block = {
                let sem = DispatchSemaphore(value: 0)
                for route in entity.routes {
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
