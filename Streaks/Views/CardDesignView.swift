//
//  CardDesignView.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/31/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CardDesignView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var shadowColor: UIColor? = UIColor.stkBlack

    
    @IBInspectable let shadowOffSetWidth: Int = 0
    @IBInspectable let shadowOffSetHeight: Int = 1

    @IBInspectable let shadowOpacity: Float = 0.2
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.shadowPath = shadowPath.cgPath
        
        layer.shadowOpacity = shadowOpacity
        
    }

    
    
}
