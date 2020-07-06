//
//  BaseViewController.swift
//  ParkingManagement
//
//  
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,Utility {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.popController()
    }

}
