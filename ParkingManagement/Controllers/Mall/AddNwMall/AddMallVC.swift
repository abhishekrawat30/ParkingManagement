//
//  AddMallVC.swift
//  ParkingManagement
//
//  
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import GooglePlaces

class AddMallVC: BaseViewController {
    
    @IBOutlet weak var mallNameTF:AppTF!
    @IBOutlet weak var mallSpacesTF:AppTF!
    @IBOutlet weak var addressTxtV:AppTF!
    
    var addNewMallVM = AddNewMallVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVM()
        // Do any additional setup after loading the view.
    }
    
    /// ConfigureViewModel
    func configureVM() {
        addNewMallVM.mallAdded = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.hideLoader()
            weakSelf.showToast("Mall details added")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                weakSelf.popController()
            }
            
        }
        
        addNewMallVM.invalidData = { [weak self]  (message) in
            guard let weakSelf = self else {
                return
            }
            weakSelf.showAlert(message, completion: nil)
        }
        
        addNewMallVM.startAdding = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.showLoader("Adding a new mail")
        }
    }
    
    
    @IBAction func getMallAddress(_ sender:Any) {
        showAddressSearch()
    }
    
    
    @IBAction func addNewMall(_ sender:Any) {
        
        addNewMallVM.cannAddNewMall(name: mallNameTF.text,slots: mallSpacesTF.text,address: addressTxtV.text)
    }
}



extension AddMallVC:GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        viewController.dismiss(animated: true) {
            self.addressTxtV.text = place.name
//            self.lat = place.coordinate.latitude
//            self.longt = place.coordinate.longitude
//            self.loadRestData()
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("PLACE ==\(error)= \(error.localizedDescription)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("wasCancelled === ")
        viewController.dismiss(animated: true, completion: nil)
    }
    
    
    func showAddressSearch() {
        // Display the autocomplete view controller.
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        // Specify the place data types to return.
        //        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
        //          UInt(GMSPlaceField.placeID.rawValue))!
        //        autocompleteController.placeFields = fields
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        autocompleteController.modalPresentationStyle = .fullScreen
        present(autocompleteController, animated: true, completion: nil)
    }
}
