//
//  CustomerTableViewCell.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 05/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {
    
    static let identifier = "CustomerTVC"
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
    @IBOutlet weak var roundedView:UIView!
    var customer = CustomerOffline()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.roundedView.dropShadow(color: .lightGray,opacity: 0.5, offSet: CGSize(width: -1, height: 1),radius: 3,scale:true)
        }
        layoutIfNeeded()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell() {
        lblCustomerId.text = "\(customer.customerId)"
        lblOrderNo.text = "ORDR\(customer.orderNo)"
        lblReferenceNo.text = "ORDR\(customer.orderNo)"
        lblMallName.text = customer.mallName
        lblSlotNo.text = "\(customer.slotNo)"
        lblMallAddress.text = customer.mallAddress
        lblvalletParking.text = customer.valletParking ? "YES" : "NO"
        lblTransportation.text = customer.transportation ? "YES" : "NO"
        package.text = customer.package
        priceLbl.text = "\(customer.price)AED"
        dateLbl.text = customer.date
    }
}
