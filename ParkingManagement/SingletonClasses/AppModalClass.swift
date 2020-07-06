//
//  AppModalClass.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 04/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

class AppmodalClass {
    var user: User? = nil
    var accessToken: String? = nil
    static var AccessTokenObject: AppmodalClass!
    
    class func sharedInstance() -> AppmodalClass {
        self.AccessTokenObject = self.AccessTokenObject ?? AppmodalClass()
        return self.AccessTokenObject
    }
    
    func setAccessToken(token: String) {
        self.accessToken = token
        
    }
    
    func getAccessToken() -> String? {
        return accessToken
    }
    
    func setLoggedUser(user: User) {
        self.user = user
    }
    
    func getLoggedUser() -> User? {
        return user
    }
}
