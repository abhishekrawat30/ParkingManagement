//
//  AdminSignInViewController.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 30/06/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class AdminSignInViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pswdTextField: UITextField!
    var adminModel = AdminSignInModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //to hide keyboard on tapping return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func signinButtonAction(_ sender: Any) {
        guard let name = self.nameTextField.text, !name.isEmpty else {
            showAlert("USERNAME_REQUIRED".localized, completion: nil)
            return
        }
        guard let pwd = self.pswdTextField.text, !pwd.isEmpty else {
            showAlert("PASSWORD_REQUIRED".localized, completion: nil)
            return
        }

        adminModel.userName = name
        adminModel.userPassword = pwd

        if adminModel.validAdminCredentials() {
            showLoader("Verifying your credential")
            performSegue(withIdentifier: "AdminOptionsVC", sender: self)
            hideLoader()
        } else {
            showAlert("INVALID_ADMIN".localized, completion: nil)
        }
    }
    
    @IBAction func isUserButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func unwindToSigninAdmin(_ unwindSegue: UIStoryboardSegue) {
        nameTextField.text = ""
        pswdTextField.text = ""
        nameTextField.becomeFirstResponder()
        // Use data from the view controller which initiated the unwind segue
    }
}
