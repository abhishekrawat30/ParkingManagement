//
//  UserRegistrationVC.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 02/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class UserRegistrationVC: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameTF:AppTF!
    @IBOutlet weak var passwordTF:AppTF!
    @IBOutlet weak var contactNoTxtV:AppTF!
    @IBOutlet weak var carNoTxtV:AppTF!
    @IBOutlet weak var carColorTxtV:AppTF!
    
    static let restorationId = "UserRegistrationVC"
    
    var userRegistrationVM = UserRegistrationVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVM()
        // Do any additional setup after loading the view.
    }
    
    //to hide keyboard on tapping return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    /// ConfigureViewModel
    func configureVM() {
        userRegistrationVM.userRegister = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.hideLoader()
            weakSelf.showToast("User Registration successful!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                weakSelf.popController()
            }
            
        }
        
        userRegistrationVM.invalidData = { [weak self]  (message) in
            guard let weakSelf = self else {
                return
            }
            weakSelf.showAlert(message, completion: nil)
        }
        
        userRegistrationVM.startAdding = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.showLoader("Registering a new user")
        }
    }
    
    
    @IBAction func registerUser(_ sender:Any) {
        
        userRegistrationVM.canRegisterUser(name: userNameTF.text,
                                           pwd: passwordTF.text,
                                           number: contactNoTxtV.text,
                                           carNumber: carNoTxtV.text,
                                           carColor: carColorTxtV.text)
    }
    
}
