//
//  MallDetailViewController.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 30/06/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class MallDetailViewController: BaseViewController {
    
    static let restorationId = "MallDetailVC"
    @IBOutlet weak var mallID: UILabel!
    @IBOutlet weak var mallName: UILabel!
    @IBOutlet weak var totalSlots: UILabel!
    @IBOutlet weak var availableSlots: UILabel!
    @IBOutlet weak var usedSlot: UILabel!
    @IBOutlet weak var changedSlot: UILabel!
    var  mapVM = MallMapVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        if let data = mapVM.mallData {
            mallID.text = data.name
            mallName.text = data.address
            totalSlots.text = "\(data.slots)"
            availableSlots.text = "\(data.availSlots)"
            usedSlot.text = "\(data.usedSlots)"
            changedSlot.text = "\(data.slots)"
        }
    }
    
}
