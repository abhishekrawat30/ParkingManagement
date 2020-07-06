//
//  SearchMallVC.swift
//  ParkingManagement
//
//  
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class SearchMallVC: BaseViewController {
    
    @IBOutlet weak var mallListTV:UITableView!
    
    @IBOutlet weak var searchTF:AppTF!
    
    private var searchMallVM = SearchMallVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVM()
        mallListTV.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let name = searchTF.text, !name.isEmpty {
            searchMallVM.updateMallList(name: name)
        }
    }
    
    func configureVM() {
        searchMallVM.reloadData = { [weak self] in
            guard let weakSelf = self else { return }
            if weakSelf.searchMallVM.mallList.count > 0 {
                weakSelf.mallListTV.reloadData()
            } else {
                weakSelf.showAlert("No_Data".localized, completion: nil)
            }
        }
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        guard let name = searchTF.text, !name.isEmpty else {
            showAlert("Enter_Search_Text".localized, completion: {
                self.searchMallVM.mallList.removeAll()
                self.mallListTV.reloadData()
            })
            return
        }
        searchMallVM.updateMallList(name: name)
    }
}

extension SearchMallVC:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMallVM.mallList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mallCell = tableView.dequeueReusableCell(withIdentifier: MallDataCell.cellID) as! MallDataCell
        mallCell.setData(data: searchMallVM.mallList[indexPath.row])
        return mallCell
    }
}

extension SearchMallVC:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: String(describing: MallDetailViewController.self)) as! MallDetailViewController
        vc.mapVM.mallData = searchMallVM.mallList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

