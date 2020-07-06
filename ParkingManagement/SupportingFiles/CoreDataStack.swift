//
//  CoreDataStack.swift
//  ParkingManagement
//
//  Created by iOSDev on 01/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import CoreData

enum AppEntity:String {
    case mall = "Mall"
    case user = "User"
    case customer = "Customer"
}

let kSerialQueue = "com.parkApp.serialQueue"

class CoreDataStack {
    private init() {}
    static let shared = CoreDataStack()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ParkingManagement")
        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error = error as NSError? else { return }
            fatalError("Unresolved error: \(error), \(error.userInfo)")
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    public private(set) lazy var viewManagedObjectContext: NSManagedObjectContext = {
       let managedObjectContext = self.persistentContainer.viewContext
        return managedObjectContext
    }()
    
     public private(set) lazy var syncManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = self.persistentContainer.newBackgroundContext()
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        managedObjectContext.undoManager = nil
        return managedObjectContext
    }()
    
    func deleteAllData(_ entity:String) {
        let entities = self.persistentContainer.managedObjectModel.entities
        entities.compactMap({ $0.name }).forEach(clearDeepObjectEntity)
    }
    
    private func clearDeepObjectEntity(_ entity: String) {
        let context = self.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
}
