//
//  MBSchedulesController.swift
//  mab
//
//  Created by Shuo Wang on 10/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

class MBSchedulesController: MBBaseController {

    var hos = Hospital()
    var categoty = ""
    
    /// data picker
    @IBOutlet private var datePicker: HAScheduleDatePicker!
    /// listView
    @IBOutlet private var listView: UITableView!
        
    private var displaySchedules = Array<Schedule>()
        
    /// current selected date
    private var selectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getSchedules()
    }
    
    override func setup() {
        super.setup()
//        listView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        datePicker.dateDidChanged = { [unowned self] (date) in
            DPrint("select\(date)")
            self.displaySchedules.removeAll()
            var dateStr = ""
            if date != nil {
                dateStr = date?.toString("dd-MM-yyyy") ?? ""
            }
            self.getSchedules(dateStr)
        }
        
    }
    
    private func getSchedules(_ date: String = "") {
        showLoading()
        SchedulesTable.getSchedules(hosCode: hos.hosCode, date: date) { [weak self] (schedules) in
            self?.hideLoading()
            self?.displaySchedules = schedules
            self?.listView.reloadData()
        }
    }

}

extension MBSchedulesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displaySchedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schedule = displaySchedules[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = schedule.docName
            cell.detailTextLabel?.text = schedule.date
            return cell
        }else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = schedule.docName
            cell.detailTextLabel?.text = schedule.date
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushVC = MBConfirmController.instanceFromStoryboard(named: MBStoryboard.home)
        pushVC.hos = hos
        pushVC.category = categoty
        pushVC.schedule = displaySchedules[indexPath.row]
        push(pushVC)
    }
    
}
