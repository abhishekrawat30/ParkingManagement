//
//  MallOffline.swift
//  ParkingManagement
//
//  Created by iOSDev on 01/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import CoreData

class MallOffline: NSManagedObject {
    @NSManaged var mallId: Int64
    @NSManaged var name: String
    @NSManaged var slots: Int16
    @NSManaged var availSlots: Int16
    @NSManaged var usedSlots: Int16
    @NSManaged var address: String
    @NSManaged var lat: Double
    @NSManaged var longt: Double
    

    func updatemallDetails(mlName:String,slots:Int16,address:String,lat:Double,longt:Double,uiniq:Int64,availSlots:Int16,usedSlots:Int16) {
        print("UINIQUUE ID IS \(uiniq)")
        self.name = mlName
        self.address = address
        self.lat = lat
        self.longt = longt
        self.slots = slots
        self.mallId = uiniq
        self.availSlots = availSlots
        self.usedSlots = usedSlots
    }
}
