//
//  PaymentDetailVM.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 03/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import Braintree
import BraintreeDropIn

class PaymentDetailVM {
    
    var invalidData:((_ message:String)->Void)?
    var mallData:MallOffline? = nil
    var customerAdded:((_ addedCust:CustomerOffline)->Void)?
    var startAdding:(()->Void)?
    var paymentData:BTDropInResult? = nil
    var transportation = false
    var valletParking = false
    var selectedPackageType: Int = 0
    var price : Double = 0.0
    private var customerRepo = CustomerRepo()
    private var lastAddedRecord: CustomerOffline? = nil
    private var addMallRepo = AddNewMallRepo()
    var packageType = ["Daily", "Monthly", "Hourly"]
    var packagePrice = [50, 100, 15]
    var count = 1
    
    func addPaymentDetails() {
        let user = AppmodalClass.sharedInstance().getLoggedUser()
        var number = user?.userContactNumber
        if user?.userContactNumber == "" {
            number = "0000000000"
        }
        price = Double(count*packagePrice[selectedPackageType])
        if transportation {
            price = price + 5
        }
        if valletParking {
            price = price + 4
        }
        
        if let mall = self.mallData {
            let avaiSlots = mall.availSlots
            mall.availSlots = mall.slots - mall.usedSlots - 1
            mall.usedSlots = mall.slots - avaiSlots + 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                _ = self.customerRepo.addNewCustomer(lat: mall.lat,
                                                     long: mall.longt,
                                                     mallName: (mall.name),
                                                     package: self.packageType[self.selectedPackageType],
                                                     referNo: 5555,
                                                     slotNo: mall.usedSlots,
                                                     transportation: self.transportation,
                                                     valletParking: self.valletParking,
                                                     contactNo: number! ,
                                                     mallAddress: mall.address,
                                                     price:self.price,
                                                     date: self.getTodayString())

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.geLastAddedRecord()
                }
            }

        }
    }
    
    func  geLastAddedRecord() {
        lastAddedRecord =  customerRepo.detailExists(id: customerRepo.getLastEnteredId()+1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.customerAdded?(self.lastAddedRecord!)
        }
    }
    
    func getTodayString() -> String {

            let date = Date()
            let calender = Calendar.current
            let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
            let year = components.year
            let month = components.month
            let day = components.day
            let hour = components.hour
            let minute = components.minute
            let second = components.second

            let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)

            return today_string
        }

}
