//
//  RegUser.swift
//  ParkingManagement
//
//  Created by iOSDev on 02/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {
    
    @NSManaged var userId: Int64
    @NSManaged var userName: String
    @NSManaged var userContactNumber: String
    @NSManaged var carNumber: String
    @NSManaged var carColor: String
    @NSManaged var password: String
    
    func updateUserDetails(userId:Int64,uName:String,contctNumber:String, pwd: String, carNo: String, carColor: String) {
        print("UINIQUUE ID IS \(userId)")
        self.userId = userId
        self.userName = uName
        self.userContactNumber = contctNumber
        self.password = pwd
        self.carNumber = carNo
        self.carColor = carColor
    }
}
