//
//  CoreDataManager.swift
//  MainScreen
//
//  Created by Asqarov Diyorjon on 01/03/25.
//


import Foundation
import CoreData

public class CoreDataManager {
    private let modelName: String = "Model"
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.module.url(forResource: modelName, withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to load Core Data model")
        }
        return model
    }()
    
    internal lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName, managedObjectModel: managedObjectModel)
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    internal var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    public init() {} // Singleton pattern to avoid multiple instances
    
    internal func clearEntities<T: NSManagedObject>(entityType: T.Type) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entityType))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("❌ Failed to clear \(String(describing: entityType)): \(error.localizedDescription)")
        }
    }

    
    internal func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("❌ Failed to save context: \(error.localizedDescription)")
            }
        }
    }
}
