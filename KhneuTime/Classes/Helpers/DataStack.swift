//
//  DataStack.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 04.02.2021.
//

import CoreData

class DataStack {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ScheduleDB")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    lazy var privateContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
