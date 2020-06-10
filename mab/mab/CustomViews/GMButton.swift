//
//  GMButton.swift
//  mab
//
//  Created by Shuo Wang on 4/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

//@IBDesignable
class GMButton: UIButton {

    /// sub attribute
    @IBInspectable var index: Int = 0
    
    /// radius
    @IBInspectable var radius: CGFloat = 0.0
    /// show border
    var borderEnabled: Bool = true {
        didSet {
            self.layer.borderWidth = borderEnabled ? borderWidth : 0.0
        }
    }
    /// width
    @IBInspectable var borderWidth: CGFloat = 0.0
    /// color
    @IBInspectable var borderColor: UIColor = .darkGray
    /// shadow color
    @IBInspectable var shadowColor: UIColor = UIColor.black
    /// shadow offset
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    /// shadow opaccity
    @IBInspectable var shadowOpacity: Float = 0
    /// shadow radius
    @IBInspectable var shadowRadius: CGFloat = 6
    
    /** --- background color gradient --- */
    /// gradient start
    @IBInspectable var gradientStartColor: UIColor?
    /// gradient end
    @IBInspectable var gradientEndColor: UIColor?
    /// background color gradient
    var gradientColors = Array<UIColor>()
    /* position explanation
     (0, 0)|--------|(1, 0)
           |        |
           |        |
     (0, 1)|--------|(1, 1)
     */
    /// start point
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.5, y: 0)
    /// end point
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.5, y: 1)
    
    /// gradient layer
    private var gradientLayer = CAGradientLayer()
    /** --- background gardient --- */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadiusAndBorder()
        setGradientLayer()
    }
    
    /// set gradient layer
    private func setGradientLayer() {
        guard gradientColors.count > 0 || (gradientStartColor != nil && gradientEndColor != nil) else {
            return
        }
        
        gradientLayer.removeFromSuperlayer()
        layer.insertSublayer(gradientLayer, at: 0)
        
        if gradientColors.count > 0 {
            gradientLayer.colors = gradientColors.map({ return $0.cgColor })
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
        }else {
            if let startColor = gradientStartColor?.cgColor, let endColor = gradientEndColor?.cgColor {
                gradientLayer.colors = [startColor, endColor]
                gradientLayer.startPoint = startPoint
                gradientLayer.endPoint = endPoint
            }
        }
        
        gradientLayer.cornerRadius = layer.cornerRadius
        gradientLayer.frame = bounds
    }
    
    /// set corner radius border
    fileprivate func setCornerRadiusAndBorder() {
        
        if radius > 0 {
            layer.cornerRadius = radius
        }
        
        if borderWidth > 0 && borderEnabled {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = borderWidth
        }else {
            layer.borderWidth = 0.0
        }
        
        if shadowRadius > 0 && shadowOpacity > 0 {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
        }
        
    }

}
