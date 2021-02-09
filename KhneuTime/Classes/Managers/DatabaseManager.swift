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
    
    func insertOrUpdateObject(entity: SyncEntitiesEnum, data: Data) {
        guard let dictionaries = data.convertToDictionary() else { return }
        for dictionary in dictionaries {
            let object = NSEntityDescription.insertNewObject(forEntityName: entity.entityName, into: dataStack.context)
            for key in Array(dictionary.keys) {
                object.setValue(dictionary[key], forKey: key)
            }
        }
        saveContext()
    }
    
    func getFaculties() -> NSFetchedResultsController<FacultyDB> {
        let request: NSFetchRequest<FacultyDB> = FacultyDB.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: request,
                                                    managedObjectContext: dataStack.context,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        return controller
    }
    
    func getSpecialties(facultyId: Int) -> NSFetchedResultsController<SpecialtyDB> {
        let request: NSFetchRequest<SpecialtyDB> = SpecialtyDB.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: request,
                                                    managedObjectContext: dataStack.context,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        return controller
    }
    
    func getGroups(specialtyId: Int) {
        
    }
    
    func getSchedule(groupId: Int) {
        
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

