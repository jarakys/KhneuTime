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
    case studentTypes
    case schedule
    
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
        case .schedule:
            return "ScheduleDB"
        case .studentTypes:
            return "StudentTypeDB"
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
        case .studentTypes:
            return [.studentTypes]
        default: return [.faculties]
        }
    }
}

class SyncManager {
    
    static let shared = SyncManager()
    
    let entities: [SyncEntitiesEnum] = [.specialties, .faculties, .groups, .studentTypes]
    
    private init() { }
    
    func startInit(completion: @escaping() -> Void) {
        var currentOperation: Operation?
        let operationQueue = OperationQueue()
        for entity in entities {
            for route in entity.routes {
                let operation = NetworkAsyncOperation(route: route, entity: entity)
                operation.block = {
                    if operationQueue.operations.count == 0 {
                        completion()
                    }
                }
                if let currentOperation = currentOperation {
                    operation.addDependency(currentOperation)
                }
                operationQueue.addOperation(operation)
                currentOperation = operation
            }
            
        }
    }
    
    func startSync() {
    }
    
    func setSchedule(for groupId: Int, completion: @escaping(Bool) -> Void) {
        NetworkManager.shared.sendRequest(route: .shedule(groupId: groupId), completion: { result in
            if case let .success(schedule) = result {
                DatabaseManager.shared.deleteSchedule(for: groupId)
                DatabaseManager.shared.insertOrUpdateObject(entity: .schedule, data: schedule, completion: {
                    completion(true)
                })
            } else {
                completion(false)
            }
        })
    }
}
