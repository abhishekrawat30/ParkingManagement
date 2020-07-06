//
//  NumberParkingDetailVC.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 04/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class NumberParkingDetailVC: BaseViewController {

    
    @IBOutlet weak var searchTF:AppTF!
    @IBOutlet weak var customerListTV:UITableView!
    
    var customerData = NumberParkingDetailVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVM()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        guard let name = searchTF.text, !name.isEmpty else {
            showAlert("Enter_VALID_NO".localized, completion: nil)
            return
        }
        customerData.searchText = searchTF.text!
        showLoader("Fetching Your Details")
        customerData.getCustomerRecord()
    }
    
    func configureVM() {
        customerData.customerDetail = { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.hideLoader()
            weakSelf.customerListTV.reloadData()
        }
    }
}

extension NumberParkingDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        customerData.customer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customerCell = tableView.dequeueReusableCell(withIdentifier: CustomerTableViewCell.identifier) as! CustomerTableViewCell
        customerCell.customer = customerData.customer[indexPath.row]
        customerCell.configureCell()
        return customerCell
    }
    
}
