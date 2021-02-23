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
                if let relationshipArray = dictionary[key] as? [Dictionary<String, Any>] {
                    let entity = NSEntityDescription.entity(forEntityName: entity.entityName, in: dataStack.context)
                    guard let relationship = entity?.relationshipsByName.first(where: { $0.key == key}), let destinationEntityName = relationship.value.destinationEntity?.name else { continue }
                    var set = Set<NSManagedObject>()
                    for relationshipObject in relationshipArray {
                        let childObject = NSEntityDescription.insertNewObject(forEntityName: destinationEntityName, into: dataStack.context)
                        for key in Array(relationshipObject.keys) {
                            childObject.setValue(relationshipObject[key], forKey: key)
                        }
                        set.insert(childObject)
                    }
                    object.setValue(set, forKey: key)
                    saveContext()
                } else {
                    object.setValue(dictionary[key], forKey: key)
                }
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
        let specialtyPredicate = NSPredicate(format: "specialtyId == %i", specialtyId)
        let coursePredicate = NSPredicate(format: "course == %i", course)
        let andPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [specialtyPredicate, coursePredicate])
        request.predicate = andPredicate
        let groups = try! dataStack.context.fetch(request)
        return groups
    }
    
    func getGroups(by ids: [Int]) -> NSFetchedResultsController<GroupDB> {
        let request: NSFetchRequest<GroupDB> = GroupDB.fetchRequest()
        request.predicate = NSPredicate(format: "id IN %@", ids)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchController
    }
    
    func getSchedule(groupId: Int) {
        
    }
    
    func saveContext() {
        if dataStack.context.hasChanges {
            do {
                try dataStack.context.save()
            } catch {
                print(error)
            }
        }
    }
}

