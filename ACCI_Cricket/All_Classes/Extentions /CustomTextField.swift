//
//  CustomTextField.swift
//  ACCI_Cricket
//
//  Created by Gaurav Govilkar on 8/27/17.
//  Copyright © 2017 webdunia. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable public class CustomTextField: UITextField {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
            let border = CALayer()
            let borderWidth = CGFloat(1.0)
            border.borderColor = UIColor.lightGray.cgColor
            border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
            border.borderWidth = borderWidth
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
    }
    
    
    @IBInspectable var rightImage : UIImage? {
        didSet {
            if let image = rightImage{
                rightViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                imageView.image = image
                imageView.tintColor = tintColor
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 25, height: 25))
                view.addSubview(imageView)
                rightView = view
            }else {
                rightViewMode = .never
            }
        }
    }
}



