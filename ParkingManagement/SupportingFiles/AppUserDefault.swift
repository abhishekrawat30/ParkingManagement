//
//  AppUserDefault.swift
//  ParkingManagement
//
//  Created by iOSDev on 02/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

class AppUserDefaults:NSObject {
    
    static let sharedUD = AppUserDefaults()
    let defaults = UserDefaults.standard
    
    func saveValue(key:String,value:String) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    func getValue(key:String) -> String? {
        return defaults.value(forKey: key) as? String
    }
    
    
    func saveAnyValue(key:String,value:Any) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    func getAnyValue(key:String) -> Any? {
        return defaults.value(forKey: key)
    }
    
    func saveCodable<T:Codable>(key:String,model:T) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            defaults.set(encoded, forKey: key)
        }
    }

//        Reading saved data back into a Person instance is a matter of converting from Data using a JSONDecoder, like this:
    func getCodable<name:Codable>(model:name.Type, for key:String) -> name?  {
        if let savedPerson = defaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(model.self, from: savedPerson) {
                return loadedPerson
            }
            return nil
        }
        return nil
    }
    
    func clearUD(_ keys:[String]) {
        for udKey in keys {
            defaults.removeObject(forKey: udKey)
            defaults.synchronize()
        }
    }
    
    func clearAllUD() {
        clearUD([])
    }
}
