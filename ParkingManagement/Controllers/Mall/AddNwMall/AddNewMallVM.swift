//
//  AddNewMallVM.swift
//  ParkingManagement
//
//  Created by iOSDev on 01/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import CoreLocation


class AddNewMallVM {
    
    var invalidData:((_ message:String)->Void)?
    var mallAdded:(()->Void)?
    var startAdding:(()->Void)?
    private var addMallRepo = AddNewMallRepo()
    
    
    func cannAddNewMall(name:String? = "",slots:String? = "",address:String? = "") {
        if (name ?? "").isEmpty || (slots ?? "").isEmpty || (address ?? "").isEmpty {
            if Int16(slots!) == 0 {
                invalidData?("Minimum slot should be 1")
                return
            }
            invalidData?("Please fill all the details")
            return
        }
        startAdding?()
        getLatLongt(address: address!) { (lat, longt) in
            self.saveToCoreData(name: name!, slots: Int16(slots!)!, add: address!, lat: lat, longt: longt,availSlots: Int16(slots!)!,usedSlots:0 )
        }
    }
    
    private func saveToCoreData(name:String,slots:Int16,add:String,lat:Double,longt:Double,availSlots: Int16,usedSlots: Int16) {
        _ = addMallRepo.addNewOfflineMall(name: name, slots: slots, add: add, lat: lat, longt: longt,availSlots: availSlots,usedSlots: usedSlots)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.mallAdded?()
        }
    }
    
    /// Function to get address lat and longt
    /// - Parameters:
    ///   - address: address string
    ///   - callback: callBack
    private func getLatLongt(address:String,callback:@escaping ((_ lat:Double,_ longt:Double)->Void)) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,let location = placemarks.first?.location
                else {
                    callback(0.0,0.0)
                    return
            }
            print("LOACTION LAT LONGT IS \(address)  is \(location.coordinate.latitude) and \(location.coordinate.longitude)")
            callback(location.coordinate.latitude,location.coordinate.longitude)
        }
    }
}
