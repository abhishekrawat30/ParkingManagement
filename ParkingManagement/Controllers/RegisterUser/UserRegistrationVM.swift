//
//  UserRegistrationVM.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 02/07/20.
//  Copyright © 2020 Test. All rights reserved.
//


import Foundation
import CoreLocation


class UserRegistrationVM {
    
    var invalidData:((_ message:String)->Void)?
    var userRegister:(()->Void)?
    var startAdding:(()->Void)?
    private var addUserRepo = AddUserRepo()
    
    
    func canRegisterUser(name: String? = "", pwd: String? = "", number: String? = "", carNumber: String? = "", carColor: String? = "") {
        if (name ?? "").isEmpty || (pwd ?? "").isEmpty || (number ?? "").isEmpty || (carNumber ?? "").isEmpty || (carColor ?? "").isEmpty {
            invalidData?("Please fill all the details")
            return
        }
        startAdding?()
        self.saveToCoreData(name: name!,
                            pwd: pwd!,
                            number: number!,
                            carNumber: carNumber!,
                            carColor: carColor!)
    }
    
    private func saveToCoreData(name: String, pwd: String, number: String, carNumber: String, carColor: String) {
        _ = addUserRepo.addNewUser(name: name, pwd: pwd, contctNumber: number, carNo: carNumber, carColor: carColor)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.userRegister?()
        }
    }
    
}
