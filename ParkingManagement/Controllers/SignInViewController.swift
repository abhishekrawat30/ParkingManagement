//
//  SignInViewController.swift
//  ParkingManagement
//
//  Created by abhishekrawat on 30/06/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pswdTextField: UITextField!
    var signInModel = SignInVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        if signInModel.searchUserInDB(name: name, pwd: pwd) {
//            showAlert("Successs", completion: nil)
            performSegue(withIdentifier: "UserLogged", sender: self)
        } else {
            showAlert("Failure".localized, completion: nil)
        }
   }

    @IBAction func unwindToSignin(_ unwindSegue: UIStoryboardSegue) {
        nameTextField.text = ""
        pswdTextField.text = ""
        nameTextField.becomeFirstResponder()
        // Use data from the view controller which initiated the unwind segue
    }
}
