//
//  UIImageViewExtension.swift
//  mab
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    
    /// set image
    func sh_setImage(image: String, placeHolder: String? = nil) {
        guard image.isNotEmpty else {
            if let holder = placeHolder {
                self.image = UIImage(named: holder)
            }
            return
        }
        if (image.hasPrefix("http")||image.hasPrefix("HTTP")), let url = URL(string: image) {
            var holderImage: UIImage?
            if let holder = placeHolder {
                holderImage = UIImage(named: holder)
            }
            af.setImage(withURL: url, placeholderImage: holderImage)
        }else {
            self.image = UIImage(named: image)
        }
    }
    
}

