//
//  MallDataCell.swift
//  ParkingManagement
//
//  Created by iOSDev on 01/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class MallDataCell: UITableViewCell {
    static let cellID = String(describing: MallDataCell.self)
    
    @IBOutlet weak var lblMallId:UILabel!
    @IBOutlet weak var lblMallName:UILabel!
    @IBOutlet weak var roundedView:UIView!
    
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
    func setData(data:MallOffline) {
        lblMallId.text = "Mall Id:  \(data.mallId) "
        lblMallName.text = "Mall Name:  \(data.name) "
//        lblMallSpecs.text = data.specs
    }
}
