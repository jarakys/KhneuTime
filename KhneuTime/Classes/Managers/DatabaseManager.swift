//
//  DatabaseManager.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 31.01.2021.
//

import CoreData

class DatabaseManager {
    
    static let shared = DatabaseManager()

    let dataStack = DataStack()
    
    func insertOrUpdateSchedule(groupId: String, specialtyId: String, completion: @escaping(Bool) -> Void) {
        saveContext()
    }
    
    func insertOrUpdateFaculties() {
        
    }
    
    func inserOrUpdateSpecialties() {
        
    }
    
    func getFaculties() -> NSFetchedResultsController<SpecialtyDB> {
        let request: NSFetchRequest<SpecialtyDB> = SpecialtyDB.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: request,
                                                    managedObjectContext: dataStack.context,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        return controller
    }
    
    func getSpecialties() {
        
    }
    
    func getGroups() {
        
    }
    
    func saveContext() {
        if dataStack.context.hasChanges {
            do {
                try dataStack.context.save()
            } catch {
                print("Error")
            }
        }
    }
}

