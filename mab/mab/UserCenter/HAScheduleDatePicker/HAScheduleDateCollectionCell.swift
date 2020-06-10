//
//  HAScheduleDateCollectionCell.swift
//  HealthHaiAn
//
//  Created by Leo on 2019/4/15.
//  Copyright © 2019 Jiangsu Sunny Health Network Technology Co.,Ltd. All rights reserved.
//

import UIKit

/// 排班日期选择 cell
class HAScheduleDateCollectionCell: UICollectionViewCell {

    var dateModel = PickerDateModel() {
        didSet {
            updateState()
        }
    }
    
    private var textColor = UIColor(hex: "#333333") {
        didSet {
            weekDayLabel.textColor = textColor
            dayLabel.textColor = textColor
        }
    }
    
    /// 星期
    @IBOutlet private var weekDayLabel: UILabel!
    /// 日期
    @IBOutlet private var dayLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor(hex: "#00AAFF") : UIColor.white
            textColor = isSelected ? UIColor.white : UIColor(hex: "#00AAFF")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    /// 更新数据
    private func updateState() {
        guard let tmpDate = dateModel.date else {
            return
        }
        weekDayLabel.text = tmpDate.weekDayEnglishName()
        dayLabel.text = tmpDate.isToday ? "Today" : "\(tmpDate.day)"
        if isSelected {
            textColor = UIColor.white
        }else {
            textColor = dateModel.isEnable ? UIColor(hex: "#00AAFF") : UIColor(hex: "#B3B3B3")
        }
    }
    
}
