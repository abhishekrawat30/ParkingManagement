//
//  PriceDistVC.swift
//  ParkingManagement
//
//  
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import Braintree
import BraintreeDropIn

class PriceDistVC: BaseViewController {
    var priceDistVM = PriceDistVM()
    @IBOutlet weak var dailyButton: UIButton!
    @IBOutlet weak var monthlyButton: UIButton!
    @IBOutlet weak var hourlyButton: UIButton!
    @IBOutlet weak var countField: AppTF!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyButton.isSelected = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func packageButtonAction(_ sender: UIButton) {
        updatePlcaeHolder(index: sender.tag)
        updateButtons()
        sender.isSelected = true
        priceDistVM.selectedPackageType = sender.tag
    }
    
    
    @IBAction func payClicked(_ sender:Any) {
        if countField.text == "" {
            showAlert("Enter detail ", completion: nil)
            return
        }
        if countField.text == "0" {
            showAlert("Number should greater than 0", completion: nil)
            return
        }
        showDropIn(clientTokenOrTokenizationKey: PaypalPayment.sharedPayment.token)
    }
    
    @IBAction func transportClicked(_ sender:UIButton) {
        sender.isSelected = !sender.isSelected
        priceDistVM.isTransportation = sender.isSelected
    }
    
    @IBAction func valetClicked(_ sender:UIButton) {
        sender.isSelected = !sender.isSelected
        priceDistVM.isValletParking = sender.isSelected
    }
    
    func updatePlcaeHolder(index: Int) {
        if index == 0 {
            countField.placeholder = "ENTER_DAYS".localized
        } else if index == 1 {
            countField.placeholder = "ENTER_MONTHS".localized
        } else {
            countField.placeholder = "ENTER_HOURS".localized
        }
    }
    
    func updateButtons() {
        dailyButton.isSelected = false
        monthlyButton.isSelected = false
        hourlyButton.isSelected = false
    }
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                controller.dismiss(animated: true) {
                    self.showAlert(error?.localizedDescription, completion: nil)
                }
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                print("PAYMENT SUCCESS DONE \(result.paymentOptionType)")
                print("PAYMENT SUCCESS DONE \(String(describing: result.paymentMethod?.nonce)) with description \(String(describing: result.paymentMethod?.description))")
                print("PAYMENT SUCCESS DONE \(result.paymentIcon)")
                print("PAYMENT SUCCESS DONE \(result.paymentDescription)")
                controller.dismiss(animated: true) {
                    self.performSegue(withIdentifier: "paymentDetails", sender: result)
                }
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
}


extension PriceDistVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "paymentDetails" {
            let destin = segue.destination as! PaymentDetailVC
            destin.paymentDetailVM.mallData = priceDistVM.mallData
            destin.paymentDetailVM.paymentData = sender as? BTDropInResult
            destin.paymentDetailVM.transportation = priceDistVM.isTransportation
            destin.paymentDetailVM.valletParking = priceDistVM.isValletParking
            destin.paymentDetailVM.selectedPackageType = priceDistVM.selectedPackageType
            destin.paymentDetailVM.count = Int(countField.text ?? "1")!
        }
    }
    
}
