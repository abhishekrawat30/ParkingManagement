//
//  CustomerRepo.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 03/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import CoreData

class CustomerRepo: BaseRepository  {
    
    override init() {
        super.init()
    }
    
    func addNewCustomer(lat: Double,long: Double,mallName: String,package: String,referNo: Int64,slotNo: Int16,transportation: Bool,valletParking: Bool,contactNo: String,mallAddress: String,price: Double, date: String) -> Bool {
        
        let taskContext = CoreDataStack.shared.syncManagedObjectContext
        var successfull = false
        taskContext.performAndWait {
            // Create new records.
            guard let customerData = NSEntityDescription.insertNewObject(forEntityName: AppEntity.customer.rawValue, into: taskContext) as? CustomerOffline else {
                print("Error: Failed to create a new FseOffline object!")
                return
            }
            
            customerData.updateCustomerDetails(customerId: getLastEnteredId()+1,
                                               lat: lat, long: long,
                                               mallName: mallName,
                                               orderNo: getLastEnteredId()+1,
                                               package: package,
                                               referNo: Int64(referNo),
                                               slotNo: slotNo,
                                               transportation: transportation,
                                               valletParking: valletParking,
                                               contactNo: contactNo, mallAddress: mallAddress,price: price, date: date)
            saveChanges()
            successfull = true
            print("SAVED NEW RECORD IS \(successfull) new record is \(customerData.customerId)")
        }
        return successfull
    }
    
    
    func getLastEnteredId() -> Int64 {
        let fetchRequest = NSFetchRequest<CustomerOffline>(entityName: AppEntity.customer.rawValue)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "orderNo", ascending: true)]
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
    
    
    func detailExists(id: Int64) -> CustomerOffline? {
        let fetchRequest = NSFetchRequest<CustomerOffline>(entityName: AppEntity.customer.rawValue)
        fetchRequest.predicate = NSPredicate(format: "customerId == %d", id)
        var customer:CustomerOffline? = nil
        let serialQueue = DispatchQueue(label: kSerialQueue)
        serialQueue.sync {
            do {
                
                let arr = try baseSyncManagedObjectContext.fetch(fetchRequest)
                if arr.count > 0 {
                    customer =  arr[0]
                }
            }
            catch {
                print("error executing fetch request: \(error)")
            }
        }
        return customer
    }
    
    
    /// Retrieve the all leads save inside the local database.
    func getCustomerListFromDB(number:String?) -> [CustomerOffline] {
        print("Method callign is ")
        var result:[CustomerOffline] = []
        let serialQueue = DispatchQueue(label: kSerialQueue)
        serialQueue.sync {
            let fetchRequest = NSFetchRequest<CustomerOffline>(entityName: AppEntity.customer.rawValue)
            if number != nil, !number!.isEmpty {
                fetchRequest.predicate = NSPredicate(format: "contactNo ==[c] %@", number!)
            }
            
            //        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "synchedDate", ascending:true)]
            do {
                result = try baseSyncManagedObjectContext.fetch(fetchRequest)
                
            }catch let err as NSError {
                print(err.debugDescription)
                
            }
        }
        return result
    }
}
