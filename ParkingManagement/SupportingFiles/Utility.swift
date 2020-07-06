//
//  Utility.swift
//  ParkingManagement
//
//  Created by iOSDev on 01/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import ProgressHUD
import Toaster


protocol Utility {
    func classNameAsString(_ obj: Any) -> String
}
extension Utility {
    func classNameAsString(_ obj: Any) -> String {
        //prints more readable results for dictionaries, arrays, Int, etc
        return String(describing: type(of: obj))
    }
    
    /// Show loader
    /// - Parameter message: message to display
    func showLoader(_ message:String) {
        ProgressHUD.show(message, icon: .succeed, interaction: false)
    }
    
    /// Hide Loader
    func hideLoader() {
        ProgressHUD.dismiss()
    }
    
    /// Show Toast
    /// - Parameter msg: message to show
    func showToast(_ msg:String) {
        Toast(text: msg,duration: Delay.short).show()
    }
}
