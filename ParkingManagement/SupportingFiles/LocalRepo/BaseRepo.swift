//
//  BaseRepo.swift
//  ParkingManagement
//
//  Created by iOSDev on 01/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import CoreData

class BaseRepository: NSObject {
    
    var baseSyncManagedObjectContext:NSManagedObjectContext!
    override init() {
        baseSyncManagedObjectContext = CoreDataStack.shared.syncManagedObjectContext
    }
    func deleteAllBatch(_ batchDeleteRequest:NSPersistentStoreRequest){
        // Execute the request to de batch delete and merge the changes to viewContext, which triggers the UI update
        do {
            let batchDeleteResult = try baseSyncManagedObjectContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
            if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedObjectIDs],into: [baseSyncManagedObjectContext])
            }
        } catch {
            print("Error: \(error)\nCould not batch delete existing records.")
            return
        }
    }
    
    public func saveChanges() {
        // Save all the changes just made and reset the taskContext to free the cache.
        if baseSyncManagedObjectContext.hasChanges {
            do {
                try baseSyncManagedObjectContext.save()
            } catch {
                print("ErrorData: \(error)\nCould not save Core Data context.")
            }
            baseSyncManagedObjectContext.reset() // Reset the context to clean up the cache and low the memory footprint.
        }
    }
    
    func delete(_ object:NSManagedObject) {
        baseSyncManagedObjectContext.delete(object)
        saveChanges()
    }
}
