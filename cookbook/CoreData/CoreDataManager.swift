//
//  CoreDataManager.swift
//  cookbook
//
//  Created by tanmaydeep on 02/02/26.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    private init(
        inMemory: Bool = false
    ) {
        // Create Core Data container using the Recipe data model
        container = NSPersistentContainer(name: "Recipe")
        
        
        // Use an in-memory store for previews and unit tests
        if inMemory {
            container.persistentStoreDescriptions.first?.url =
            URL(fileURLWithPath: "/dev/null")
        }
        
        // Load persistent stores (creates or opens the SQLite database)
        container.loadPersistentStores { _, error in
                    if let error = error as NSError? {
                        fatalError("Core Data load error: \(error)")
                    }
                }
        
        // setting merge policy to avoid conflicts
        container.viewContext.mergePolicy =
                    NSMergeByPropertyObjectTrumpMergePolicy
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
    }

    
}
