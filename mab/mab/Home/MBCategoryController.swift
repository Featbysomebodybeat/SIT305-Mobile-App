//
//  MBCategoryController.swift
//  mab
//
//  Created by Shuo Wang on 10/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

class MBCategoryController: MBBaseController {

    var hos = Hospital()
    
    /// list
    @IBOutlet weak var listView: UITableView!
    
    private var categories = ["Category 1", "Category2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        listView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        listView.dataSource = self
        listView.delegate = self
    }

}

extension MBCategoryController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let data = categories[indexPath.row]
        cell?.textLabel?.text = data
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushVC = MBSchedulesController.instanceFromStoryboard(named: MBStoryboard.home)
        pushVC.hos = hos
        pushVC.categoty = categories[indexPath.row]
        push(pushVC)
    }
    
}
