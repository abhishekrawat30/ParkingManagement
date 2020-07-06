//
//  UserMallDetailTableViewCell.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 30/06/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class UserMallDetailTableViewCell: UITableViewCell {

    static let identifier = "UserMallDetailTVC"
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
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
    
    func updateCell(user: User) {
        idLabel.text = "User Id:  \(user.userId) "
        nameLabel.text = "User Name:  \(user.userName) "
    }

}
