//
//  ViewControllerExtension.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 30/06/20.
//  Copyright © 2020 Test. All rights reserved.
//com.park.app.payments://test

import UIKit

extension UIViewController {
    
    //function to show custom alert on any screen in the application
    func showAlert(_ withTitle: String? , completion : (()->Void)?) {
        let alert = UIAlertController(title: "", message: withTitle, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK".localized, style: .default,handler : {(action) in
            completion?()
        })
        alert.addAction(okAction)
        self.present(alert,animated: true,completion: nil)
    }
    
    //function to pop to base view controller from any controller
    func popToRootController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //function to pop to previous controller from any controller
    func popController() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var lowerCaseLocalized: String {
        return NSLocalizedString(self, comment: "").lowercased()
    }
    
    var upperCaseLocalized: String {
        return NSLocalizedString(self, comment: "").uppercased()
    }
    
    var capitalLocalized: String {
        return NSLocalizedString(self, comment: "").capitalized
    }
}


extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 1.0, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
