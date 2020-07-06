//
//  UserDetailViewController.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 30/06/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class UserDetailViewController: BaseViewController {

    static let restorationId = "UserDetailVC"
    var userDetailVM = UserDetailVM()
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userNAME: UILabel!
    @IBOutlet weak var carNumber: UILabel!
    @IBOutlet var carColor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        if let data = userDetailVM.userData {
            userId.text = "\(data.userId)"
            userNAME.text = data.userName
            carNumber.text = data.carNumber
            carColor.text = data.carColor
        }
    }
    
}
