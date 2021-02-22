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
            
            if dictionary is [String: [Dictionary<String, Any>]] {
                guard let relationshipName = dictionary.keys.first else { continue }
                let entity = NSEntityDescription.entity(forEntityName: entity.entityName, in: dataStack.context)
                guard let relationship = entity?.relationshipsByName.first(where: { $0.key == relationshipName}), let destinationEntityName = relationship.value.destinationEntity?.name else { continue }
                let arrayData = dictionary.values as! [Dictionary<String, Any>]
//                for child in arrayData {
//                    let childObject = NSEntityDescription.entity(forEntityName: destinationEntityName, in: dataStack.context)
//                    for key in Array(child.keys) {
//                        childObject.setValue(dictionary[key], forKey: key)
//                    }
//                }
            }
            for key in Array(dictionary.keys) {
                object.setValue(dictionary[key], forKey: key)
            }
        }
        saveContext()
    }
    
    func getFaculties() -> [FacultyDB] {
        let request: NSFetchRequest<FacultyDB> = FacultyDB.fetchRequest()
        let faculties = try? dataStack.context.fetch(request)
        return faculties ?? []
    }
    
    func getSpecialties(facultyId: Int) -> [SpecialtyDB] {
        let request: NSFetchRequest<SpecialtyDB> = SpecialtyDB.fetchRequest()
        request.predicate = NSPredicate(format: "facultyId == %i", facultyId)
        let specialties = try? dataStack.context.fetch(request)
        return specialties ?? []
    }
    
    func getGroups(specialtyId: Int, course: Int) -> [GroupDB] {
        let request: NSFetchRequest<GroupDB> = GroupDB.fetchRequest()
//        let specialtyPredicate = NSPredicate(format: "specialtyId ==%i", specialtyId)
//        let coursePredicate = NSPredicate(format: "course ==%i", course)
//        let andPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [specialtyPredicate, coursePredicate])
//        request.predicate = andPredicate
        let groups = try! dataStack.context.fetch(request)
        return groups
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

