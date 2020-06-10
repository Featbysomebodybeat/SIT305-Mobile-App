//
//  UINavigationBarEx.swift
//  mab
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit


extension UINavigationBar {
    
    private struct AssociatedKey {
        static var identifier: String = "navLayer"
    }
    
    public var navLayer: CALayer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.identifier) as? CALayer
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKey.identifier, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setBackgroudColor(with color: UIColor?,image: UIImage?) {
        navBarToBeSystem()
        //navigation bar remove bot line
        
        setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        shadowImage = UIImage()
        self.navLayer?.removeFromSuperlayer()
        //get height
        let statusHeight = UIApplication.shared.statusBarFrame.size.height
        //get navigation bar height
        let navHeight = self.bounds.size.height
        
        var barBounds = self.bounds
        barBounds.size.height = statusHeight + navHeight
        
        navLayer = CALayer()
        navLayer?.frame = barBounds
        if let navColor = color {
            navLayer?.backgroundColor = navColor.cgColor
        }
        
        if let backgroudImage = image {
            navLayer?.contents = backgroudImage.cgImage
        }
        if let backgroudView =  value(forKey: "backgroundView") as? UIView {
            backgroudView.layer.addSublayer(self.navLayer!)
        }
    }
    
    func navBarToBeSystem(){
        self.navLayer?.removeFromSuperlayer()
        setBackgroundImage(nil, for: .default)
        shadowImage = nil
        barStyle = .default
    }
    
    func navBarToBeSystemColor()  {
        self.navLayer?.removeFromSuperlayer()
        barStyle = .default
    }
    
}

