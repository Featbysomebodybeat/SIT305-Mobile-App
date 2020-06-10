//
//  MBUserCenterController.swift
//  mab
//
//  Created by Shuo Wang on 4/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

class MBUserCenterController: MBBaseController {

    /// tableview
    @IBOutlet weak var tableview: UITableView!
    
    private let userInfoCell = "MBUcUserInfoCell"
    private let titleArrowCell = "MBTitleArrowCell"
    
    private let titles = ["My Orders", "Security"]
    
    /// logout
    @IBAction private func logout(_ sender: Any) {
        MBUserCenter.shared.logout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setup() {
        super.setup()
        tableview.tableFooterView = UIView()
        tableview.register(UINib(nibName: userInfoCell, bundle: nil), forCellReuseIdentifier: userInfoCell)
        tableview.register(UINib(nibName: titleArrowCell, bundle: nil), forCellReuseIdentifier: titleArrowCell)
    }
    
}

extension MBUserCenterController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: userInfoCell) as! MBUcUserInfoCell
            cell.nameLabel.text = MBUserCenter.shared.userName
            cell.phoneLabel.text = MBUserCenter.shared.userPhone
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: titleArrowCell) as! MBTitleArrowCell
            cell.titleLabel.text = titles[indexPath.row-1]
            return cell
        }
    }
    
    
}
