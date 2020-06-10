//
//  MBHomeController.swift
//  mab
//
//  Created by zhengheng on 2020/6/4.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

class MBHomeController: MBBaseController {

    @IBOutlet weak var newsList: UITableView!
    
    private var news = Array<News>()
    
    /// book
    @IBAction private func clickedBookButton(_ sender: Any) {
        let pushVC = MBHospitalListController.instanceFromStoryboard(named: MBStoryboard.home)
        pushVC.hidesBottomBarWhenPushed = true
        push(pushVC)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newsList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        newsList.dataSource = self
        newsList.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNews()
    }
    
    private func getNews() {
        showLoading()
        NewsTable.getNews { [weak self] (news) in
            self?.hideLoading()
            self?.news = news
            self?.newsList.reloadData()
        }
    }

}

extension MBHomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let data = news[indexPath.row]
        cell?.textLabel?.text = data.title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = news[indexPath.row]
        
        if let path = Bundle.main.path(forResource: data.newsId, ofType: "html") {
            let pushVC = MBBaseWebController()
            pushVC.hidesBottomBarWhenPushed = true
            pushVC.path = path
            push(pushVC)
        }
    }
}
