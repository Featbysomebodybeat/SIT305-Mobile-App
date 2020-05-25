//
//  ColorExtension.swift
//  JKWYHosNYSKQ
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// random color
    static var randomColor: UIColor {
        let redValue = CGFloat(arc4random_uniform(100)) / 100.0
        let greenValue = CGFloat(arc4random_uniform(100)) / 100.0
        let blueValue = CGFloat(arc4random_uniform(100)) / 100.0
        let color = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1)
        return color
    }
    
    /// hex color
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy:1)
            cString = String(cString[index...])
        }
        
        if (cString.hasPrefix("0x")) {
            let index = cString.index(cString.startIndex, offsetBy:2)
            cString = String(cString[index...])
        }
        
        if (cString.count != 6) {
            self.init(red: 1, green: 0, blue: 0, alpha: alpha)
        }
        else {
            let rIndex = cString.index(cString.startIndex, offsetBy: 2)
            let rString = String(cString[..<rIndex])
            let otherString = String(cString[rIndex...])
            let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
            let gString = String(otherString[..<gIndex])
            let bIndex = cString.index(cString.endIndex, offsetBy: -2)
            let bString = String(cString[bIndex...])
            
            var intr: UInt32 = 0, intg: UInt32 = 0, intb: UInt32 = 0;
            Scanner(string: rString).scanHexInt32(&intr)
            Scanner(string: gString).scanHexInt32(&intg)
            Scanner(string: bString).scanHexInt32(&intb)
            
            self.init(red: CGFloat(intr)/255.0, green: CGFloat(intg)/255.0, blue: CGFloat(intb)/255.0, alpha: alpha)
        }
    }
    
}
