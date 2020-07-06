//
//  SearchMallVM.swift
//  ParkingManagement
//
//  Created by iOSDev on 01/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation


class SearchMallVM {
    
    var reloadData:(()->Void)?
    private var addMallRepo = AddNewMallRepo()
    var mallList:[MallOffline] = []
    var isAddress = false
    
    func updateMallList(name:String)  {
        searchmallInDB(name: name)
    }
    
    private func searchmallInDB(name:String) {
        mallList = addMallRepo.getMallListFromDB(name: name, isAddress: isAddress)
        DispatchQueue.main.async {
            self.reloadData?()
        }
    }
}
