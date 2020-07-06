//
//  CustomerOffline.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 03/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import CoreData

class CustomerOffline: NSManagedObject {
    
    @NSManaged var customerId: Int64
    @NSManaged var lat: Double
    @NSManaged var long: Double
    @NSManaged var mallName: String
    @NSManaged var orderNo: Int64
    @NSManaged var package: String
    @NSManaged var referNo: Int64
    @NSManaged var slotNo: Int16
    @NSManaged var transportation: Bool
    @NSManaged var valletParking: Bool
    @NSManaged var contactNo: String
    @NSManaged var mallAddress: String
    @NSManaged var price: Double
    @NSManaged var date: String
    
    func updateCustomerDetails(customerId: Int64,lat: Double,long: Double,mallName: String,orderNo: Int64,package: String,referNo: Int64,slotNo: Int16,transportation: Bool,valletParking: Bool,contactNo: String,mallAddress: String,price: Double,date: String) {
        print("UNIQUUE customerId IS \(customerId)")
        self.customerId = customerId
        self.lat = lat
        self.long = long
        self.mallName = mallName
        self.orderNo = orderNo
        self.package = package
        self.referNo = referNo
        self.slotNo = slotNo
        self.transportation = transportation
        self.valletParking = valletParking
        self.contactNo = contactNo
        self.mallAddress = mallAddress
        self.price = price
        self.date = date
    }
}
