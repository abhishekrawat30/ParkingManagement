//
//  SearchViewController.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 30/06/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UITextFieldDelegate {

    static let restorationId = "SearchVC"
    @IBOutlet weak var searchField: AppTF!
    @IBOutlet weak var tableview: UITableView!
    var userSearchVM = UserSearchVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVM()
        tableview.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        guard let name = searchField.text, !name.isEmpty else {
            showAlert("Enter_Search_Text".localized, completion: {
                self.userSearchVM.userList.removeAll()
                self.tableview.reloadData()
            })
            return
        }
        userSearchVM.updateUserList(name: name)
    }
    
    //to hide keyboard on tapping return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
        
    func configureVM() {
        userSearchVM.reloadData = { [weak self] in
            guard let weakSelf = self else { return }
            if weakSelf.userSearchVM.userList.count > 0 {
                weakSelf.tableview.reloadData()
            } else {
                weakSelf.showAlert("No_Data".localized, completion: nil)
            }
        }
    }
        
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSearchVM.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserMallDetailTableViewCell.identifier, for: indexPath) as! UserMallDetailTableViewCell
        cell.updateCell(user: userSearchVM.userList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDetailVC = storyboard?.instantiateViewController(identifier: UserDetailViewController.restorationId) as! UserDetailViewController
        userDetailVC.userDetailVM.userData = userSearchVM.userList[indexPath.row]
        navigationController?.pushViewController(userDetailVC, animated: true)
    }
}
