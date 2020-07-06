//
//  PaymentDetailVC.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 03/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class PaymentDetailVC: BaseViewController {
    
    @IBOutlet weak var lblCustomerId:UILabel!
    @IBOutlet weak var lblOrderNo:UILabel!
    @IBOutlet weak var lblReferenceNo:UILabel!
    @IBOutlet weak var lblMallName:UILabel!
    @IBOutlet weak var lblSlotNo:UILabel!
    @IBOutlet weak var lblMallAddress:UILabel!
    @IBOutlet weak var lblvalletParking:UILabel!
    @IBOutlet weak var lblTransportation:UILabel!
    @IBOutlet weak var package: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    var paymentDetailVM = PaymentDetailVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoader("Generating Your Details")
        configureVM()
        paymentDetailVM.addPaymentDetails()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        if let nc = navigationController?.viewControllers {
            for controller in nc {
                if controller.isKind(of: SearchMallAddressVC.self) {
                    navigationController?.popToViewController(controller, animated: true)
                }
            }
        }
    }
    
    func configureVM() {
        paymentDetailVM.customerAdded = { [weak self] (data) in
            guard let weakSelf = self else { return }
            weakSelf.hideLoader()
            weakSelf.lblCustomerId.text = "\(data.customerId)"
            weakSelf.lblOrderNo.text = "ORDR\(data.orderNo)"
            weakSelf.lblReferenceNo.text = "\(data.referNo)"
            weakSelf.lblMallName.text = data.mallName
            weakSelf.lblSlotNo.text = "\(data.slotNo)"
            weakSelf.lblMallAddress.text = data.mallAddress
            weakSelf.lblvalletParking.text = data.valletParking ? "YES" : "NO"
            weakSelf.lblTransportation.text = data.transportation ? "YES" : "NO"
            weakSelf.package.text = data.package
            weakSelf.priceLbl.text = "\(data.price)AED"
            weakSelf.dateLbl.text = data.date
        }
    }

}
