//
//  MBHospitalListController.swift
//  mab
//
//  Created by Shuo Wang on 10/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

class MBHospitalListController: MBBaseController {

    /// list
    @IBOutlet weak var listView: UITableView!
    
    private var hospitals = Array<Hospital>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        listView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        listView.dataSource = self
        listView.delegate = self
        
        getHospitals()
    }
    
    private func getHospitals() {
        showLoading()
        HospitalTable.getHospitals { [weak self] (results) in
            self?.hideLoading()
            self?.hospitals = results
            self?.listView.reloadData()
        }
    }
    
}

extension MBHospitalListController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let data = hospitals[indexPath.row]
        cell?.textLabel?.text = data.hosName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = hospitals[indexPath.row]
        let pushVC = MBCategoryController.instanceFromStoryboard(named: MBStoryboard.home)
        pushVC.hos = data
        push(pushVC)
    }
    
}


