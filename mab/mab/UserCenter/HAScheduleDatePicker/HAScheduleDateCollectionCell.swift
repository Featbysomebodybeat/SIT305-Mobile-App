//
//  HAScheduleDateCollectionCell.swift
//  mab
//
//  Created by Shuo Wang on 4/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

/// schdule date collection cell
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
    
    /// week
    @IBOutlet private var weekDayLabel: UILabel!
    /// date
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
    
    /// update data
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
