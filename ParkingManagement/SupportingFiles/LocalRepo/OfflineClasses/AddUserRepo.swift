//
//  AddUserRepo.swift
//  ParkingManagement
//
//  Created by iOSDev on 02/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import CoreData

class AddUserRepo: BaseRepository  {
    
    override init() {
        super.init()
    }
    
    func addNewUser(name:String, pwd: String, contctNumber:String, carNo :String, carColor :String) -> Bool {
        
        let taskContext = CoreDataStack.shared.syncManagedObjectContext
        var successfull = false
        taskContext.performAndWait {
            //            let matchingEpisodeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: AppEntity.mall.rawValue)
            //            matchingEpisodeRequest.predicate = NSPredicate(format: "name == %d", name)
            
            //            if let offlineData = detailExists(id: name) {
            //                //Update previous record
            //                //                offlineData
            //            } else {
            // Create new records.
            guard let userData = NSEntityDescription.insertNewObject(forEntityName: AppEntity.user.rawValue, into: taskContext) as? User else {
                print("Error: Failed to create a new FseOffline object!")
                return
            }
            
            userData.updateUserDetails(userId: getLastEnteredId()+1, uName: name, contctNumber: contctNumber, pwd: pwd, carNo: carNo, carColor: carColor)
            //            }
            saveChanges()
            successfull = true
        }
        return successfull
    }
    
    
    func getLastEnteredId() -> Int64 {
        let fetchRequest = NSFetchRequest<User>(entityName: AppEntity.user.rawValue)
        let serialQueue = DispatchQueue(label: kSerialQueue)
        var uiniqId:Int64 = 0
        serialQueue.sync {
            do {
                let arr = try baseSyncManagedObjectContext.fetch(fetchRequest)
                uiniqId = Int64(arr.count)
            }
            catch {
                print("error executing fetch request: \(error)")
            }
        }
        return uiniqId
    }
    
    
    func detailExists(id: String) -> User? {
        let fetchRequest = NSFetchRequest<User>(entityName: AppEntity.user.rawValue)
        fetchRequest.predicate = NSPredicate(format: "name ==[c]", id)
        var user:User? = nil
        let serialQueue = DispatchQueue(label: kSerialQueue)
        serialQueue.sync {
            do {
                
                let arr = try baseSyncManagedObjectContext.fetch(fetchRequest)
                if arr.count > 0 {
                    user =  arr[0]
                }
            }
            catch {
                print("error executing fetch request: \(error)")
            }
        }
        return user
    }
    
    
    /// Retrieve the all leads save inside the local database.
    func getUserListFromDB(name:String?, pwd: String? = nil) -> [User] {
        print("Method callign is ")
        var result:[User] = []
        let serialQueue = DispatchQueue(label: kSerialQueue)
        serialQueue.sync {
            let fetchRequest = NSFetchRequest<User>(entityName: AppEntity.user.rawValue)
            if let pwd = pwd {
                if name != nil, !name!.isEmpty {
                    fetchRequest.predicate = NSPredicate(format: "userName ==[c] %@ AND password ==[c] %@",name!,pwd)
                }
            } else {
                if name != nil, !name!.isEmpty {
                    fetchRequest.predicate = NSPredicate(format: "userName CONTAINS[c] %@", name!)
                }
            }
            do {
                result = try baseSyncManagedObjectContext.fetch(fetchRequest)
                
            }catch let err as NSError {
                print(err.debugDescription)
                
            }
        }
        return result
    }
}
