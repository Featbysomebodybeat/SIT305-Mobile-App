//
//  HAScheduleDatePicker.swift
//  mab
//
//  Created by Shuo Wang on 4/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit
import SwiftDate

/// schedule data pciker
class HAScheduleDatePicker: UIView {
    
    /// date changed
    var dateDidChanged: ((_ date: Date?)->Void)?
    
    /// max date
    @IBInspectable var maxCount: Int = 15
    
    @IBOutlet weak var dateCollection: UICollectionView!
    @IBOutlet weak var allButton: UIButton!
    
    private let k_dateCell = "HAScheduleDateCollectionCell"
    
    /// current index
    private var selectedIndex: IndexPath? {
        didSet {
//            DPrint("currentIndex == \(selectedIndex)")
            
            if selectedIndex == nil {
                allButton.isSelected = true
                allButton.backgroundColor = UIColor(hex: "#00AAFF")
                dateCollection.selectItem(at: nil, animated: false, scrollPosition: .left)
            }else {
                allButton.isSelected = false
                allButton.backgroundColor = UIColor.white
            }
        }
    }
    
    /// recieve xib view
    private lazy var xibView: UIView! = {
        return Bundle.main.loadNibNamed("HAScheduleDatePicker", owner: self, options: nil)?.first as! UIView
    }()
    
    /// enable dates
    var enableDates = Array<String>() {
        didSet {
            createDates()
        }
    }
    
    /// all date data
    private var allDates = Array<PickerDateModel>() {
        didSet {
            dateCollection.reloadData()
        }
    }
    
    /// click all buttons
    @IBAction private func clickAllButton(_ sender: Any) {
        selectedIndex = nil
        dateDidChanged?(nil)
    }
    
    var shouldHighlight = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        xibView.frame = bounds
        
    }
    
    
}

// MARK: - Functions
extension HAScheduleDatePicker {
    
    /// inital
    private func setup() {
        
        addSubview(xibView)
        dateCollection.register(UINib(nibName: k_dateCell, bundle: nil), forCellWithReuseIdentifier: k_dateCell)
        
        createDates()
    }
    
    /// create date data
    private func createDates() {
        allDates = MBDateManager.getDatesAfterToday(for: maxCount).map({ (date) -> PickerDateModel in
            return PickerDateModel(date: date, isEnable: true)
//            return PickerDateModel(date: date, isEnable: enableDates.contains(date.toString("yyyy-MM-dd")))
        })
    }
    
}

// MARK: - collection
extension HAScheduleDatePicker: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: data
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allDates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: k_dateCell, for: indexPath) as! HAScheduleDateCollectionCell
        cell.dateModel = allDates[indexPath.item]
        return cell
    }
    
    // MARK: proxy
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        DPrint("1. \(indexPath) == shouldHighlightItem")
        let model = allDates[indexPath.item]
        shouldHighlight = model.isEnable
        return model.isEnable
    }
    
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        DPrint("2. \(indexPath) == didHighlightItem")
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        DPrint("3. \(indexPath) == didUnhighlightItem")
//    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        DPrint("4. \(indexPath) == shouldSelectItem")
        let model = allDates[indexPath.item]
        return model.isEnable
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
//        DPrint("\(indexPath) == shouldDeselectItem")
        let model = allDates[indexPath.item]
        return model.isEnable
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        DPrint("5. \(indexPath) == didDeselectItem")
        if !shouldHighlight {
            collectionView.selectItem(at: selectedIndex!, animated: false, scrollPosition: .bottom)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        DPrint("6. \(indexPath) == didSelectItem")
        let dateModel = allDates[indexPath.item]
        guard dateModel.isEnable == true else {
            return
        }
        
        guard selectedIndex != indexPath else {
            return
        }
        
        selectedIndex = indexPath
        
        dateDidChanged?(dateModel.date)
        
    }
    
    
}

struct PickerDateModel {
    var date: Date?
    var isEnable: Bool

    init() {
        self.date = nil
        self.isEnable = false
    }
    
    init(date: Date?, isEnable: Bool) {
        self.date = date
        self.isEnable = isEnable
    }
    
}
