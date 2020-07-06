//
//  AppTF.swift
//  ParkingManagement
//
//  Created by iOSDev on 01/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class AppTF: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}


class AppButton: UIButton {
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5
    }
}
