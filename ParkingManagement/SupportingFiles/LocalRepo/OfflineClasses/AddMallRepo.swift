//
//  AddMallRepo.swift
//  ParkingManagement
//
//  Created by iOSDev on 01/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import CoreData

class AddNewMallRepo: BaseRepository  {
    
    override init() {
        super.init()
    }
    
    func addNewOfflineMall(name:String,slots:Int16,add:String,lat:Double,longt:Double,availSlots: Int16, usedSlots: Int16) -> Bool {
        
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
                guard let mallOfflineData = NSEntityDescription.insertNewObject(forEntityName: AppEntity.mall.rawValue, into: taskContext) as? MallOffline else {
                    print("Error: Failed to create a new FseOffline object!")
                    return
                }
            mallOfflineData.updatemallDetails(mlName: name, slots: slots, address: add, lat: lat, longt: longt, uiniq: getLastEnteredId(), availSlots: availSlots, usedSlots: usedSlots)
//            }
            saveChanges()
            successfull = true
        }
        return successfull
    }
    
    
    func getLastEnteredId() -> Int64 {
        let fetchRequest = NSFetchRequest<MallOffline>(entityName: AppEntity.mall.rawValue)
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
    
    
    func detailExists(id: String) -> MallOffline? {
        let fetchRequest = NSFetchRequest<MallOffline>(entityName: AppEntity.mall.rawValue)
        fetchRequest.predicate = NSPredicate(format: "name ==[c]", id)
        var fseDtlOff:MallOffline? = nil
        let serialQueue = DispatchQueue(label: kSerialQueue)
        serialQueue.sync {
            do {
                
                let arr = try baseSyncManagedObjectContext.fetch(fetchRequest)
                if arr.count > 0 {
                    fseDtlOff =  arr[0]
                }
            }
            catch {
                print("error executing fetch request: \(error)")
            }
        }
        return fseDtlOff
    }
    
    
    /// Retrieve the all leads save inside the local database.
    func getMallListFromDB(name:String?, isAddress: Bool = false) -> [MallOffline] {
        var result:[MallOffline] = []
        let serialQueue = DispatchQueue(label: kSerialQueue)
        serialQueue.sync {
            let fetchRequest = NSFetchRequest<MallOffline>(entityName: AppEntity.mall.rawValue)
//            if isAddress {
//                if name != nil, !name!.isEmpty {
//                    fetchRequest.predicate = NSPredicate(format: "address CONTAINS[c] %@", name!)
//                    let sortDescriptor = NSSortDescriptor(key: #keyPath(MallOffline.address), ascending: true, selector: #selector(NSString.caseInsensitiveCompare))
//
//                    fetchRequest.sortDescriptors = [sortDescriptor]
//                }
//            } else {
//                if name != nil, !name!.isEmpty {
                    fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] %@ OR address CONTAINS[c] %@", name!, name!)
//            }
            
            //        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "synchedDate", ascending:true)]
            do {
                result = try baseSyncManagedObjectContext.fetch(fetchRequest)
                
            }catch let err as NSError {
                print(err.debugDescription)
                
            }
        }
        return result
    }
    
    func updateMallDetail(mallDetail: MallOffline) {
        let fetchRequest = NSFetchRequest<MallOffline>(entityName: AppEntity.mall.rawValue)
        fetchRequest.predicate = NSPredicate(format: "mallId == %d", mallDetail.mallId)
//        var mallDetail:MallOffline? = nil
        let serialQueue = DispatchQueue(label: kSerialQueue)
        serialQueue.sync {
            do {
                
                let arr = try baseSyncManagedObjectContext.fetch(fetchRequest)
                if arr.count > 0 {
                    let managedObject = arr[0]
                    managedObject.updatemallDetails(mlName: mallDetail.name,
                                                    slots: mallDetail.slots,
                                                    address: mallDetail.address,
                                                    lat: mallDetail.lat,
                                                    longt: mallDetail.longt,
                                                    uiniq: mallDetail.mallId,
                                                    availSlots: mallDetail.availSlots,
                                                    usedSlots: mallDetail.usedSlots)
                }
                saveChanges()
            }
            catch {
                print("error executing fetch request: \(error)")
            }
        }
    }
}
