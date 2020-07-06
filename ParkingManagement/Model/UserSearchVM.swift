//
//  UserSearchVM.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 30/06/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

class UserSearchVM {
    
    var reloadData:(()->Void)?
    private var userRepo = AddUserRepo()
    var userList:[User] = []
    
    func updateUserList(name:String)  {
        searchUserInDB(name: name)
    }
    
    private func searchUserInDB(name:String) {
        userList = userRepo.getUserListFromDB(name: name)
        DispatchQueue.main.async {
            self.reloadData?()
        }
    }
}
