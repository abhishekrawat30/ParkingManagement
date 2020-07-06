//
//  SignInVM.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 02/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

class SignInVM {
    
    private var userRepo = AddUserRepo()
    
    func searchUserInDB(name:String, pwd: String) -> Bool {
        let user = userRepo.getUserListFromDB(name: name, pwd: pwd)
        if user.count > 0 {
            AppmodalClass.sharedInstance().setLoggedUser(user: user[0])
            return true
        }
        return false
    }
}
