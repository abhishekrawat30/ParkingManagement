//
//  NumberParkingDetailVM.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 04/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

class NumberParkingDetailVM {
    
    var searchText = ""
    var customer:[CustomerOffline] = []
    private var customerRepo = CustomerRepo()
    var customerDetail:(()->Void)?
    
    func  getCustomerRecord() {
        customer =  customerRepo.getCustomerListFromDB(number: searchText)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.customerDetail?()
        }
    }
}
