//
//  Button.swift
//  QuanZai
//
//  Created by i-chou on 6/29/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

@IBDesignable

class Button: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor() {
        didSet {
            self.layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
}
