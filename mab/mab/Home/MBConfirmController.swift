//
//  MBConfirmController.swift
//  mab
//
//  Created by Shuo Wang on 10/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

class MBConfirmController: MBBaseController {
    
    var schedule = Schedule()
    var hos = Hospital()
    var category = ""
    
    /// listView
    @IBOutlet private var listView: UITableView!
    
    /// confirm
    @IBAction private func clickedConfirmButton(_ sender: Any) {
        var register = Register()
        register.userName = MBUserCenter.shared.userName
        register.userPhone = MBUserCenter.shared.userPhone
        register.hosName = hos.hosName
        register.hosCode = hos.hosCode
        register.category = category
        register.docName = schedule.docName
        register.date = schedule.date
        
        showLoading()
        RegisterTable.insert(register) { [weak self] (success) in
            self?.hideLoading()
            self?.showResult(success)
        }
        
    }
    
    private let sectionTitles = ["UserInfo", "OrderInfo"]
    
    private var userInfos = Array<String>()
    private var orderInfos = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func setup() {
        super.setup()
        
        userInfos = [MBUserCenter.shared.userName, MBUserCenter.shared.userPhone]
        orderInfos = [hos.hosName, category, schedule.docName, schedule.date]
        
        listView.reloadData()
    }
    
    private func showResult(_ flag: Bool) {
        let pushVC = MBOrderResultController.instanceFromStoryboard(named: MBStoryboard.home)
        
        push(pushVC, animated: false)
    }

}

extension MBConfirmController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return userInfos.count
        case 1:
            return orderInfos.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if indexPath.section == 0 {
            cell?.textLabel?.text = userInfos[indexPath.row]
        }else {
            cell?.textLabel?.text = orderInfos[indexPath.row]
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
}
