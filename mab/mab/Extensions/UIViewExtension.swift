//
//  UIViewExtension.swift
//  EHealthHanAn
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

/// load view from xib
protocol MBViewXibabale {}
extension MBViewXibabale {
    
    /// load view from xib
    static func instanceFromXib(_ name: String = "", No: Int = 0) -> Self {
        let xib = name.isEmpty ? "\(self)" : name
        return Bundle.main.loadNibNamed(xib, owner: nil, options: nil)?[No] as! Self
    }
    
}
