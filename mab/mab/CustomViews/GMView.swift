//
//  GMView.swift
//  mab
//
//  Created by Shuo Wang on 4/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

//@IBDesignable
class GMView: UIView {

    /// corner radius
    @IBInspectable var cornerRadius: CGFloat = 0.0
    /// border width
    @IBInspectable var borderWidth: CGFloat = 0.0
    /// border color
    @IBInspectable var borderColor: UIColor = .darkGray
    
    /// shadow color
    @IBInspectable var shadowColor: UIColor = UIColor.black
    /// shadow offset
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    /// shadow opacity
    @IBInspectable var shadowOpacity: Float = 0
    /// shadow radius
    @IBInspectable var shadowRadius: CGFloat = 6
    
    /** --- background color gradient  --- */
    /// gradient start color
    @IBInspectable var gradientStartColor: UIColor?
    /// gradient end color
    @IBInspectable var gradientEndColor: UIColor?
    /// gradient color
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
    /** --- background color gradient  --- */
    
    
    
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
    private func setCornerRadiusAndBorder() {
        
        if cornerRadius > 0 {
            layer.cornerRadius = cornerRadius
        }
        
        if borderWidth > 0 {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.cgColor
        }

        if shadowRadius > 0 && shadowOpacity > 0 {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
        }
        
    }

}
