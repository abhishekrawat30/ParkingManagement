//
//  AdminSignInModel.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 30/06/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

class AdminSignInModel {
    
    var userName:String = ""
    var userPassword:String = ""
    
    func validAdminCredentials() -> Bool {
        if userName.capitalized == "Ashifa" && userPassword == "123456" {
            return true
        }
        return false
    }
}
