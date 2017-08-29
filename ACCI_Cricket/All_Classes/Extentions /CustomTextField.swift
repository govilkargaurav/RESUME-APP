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
        
        //showError()
    }
    
    public func showError(){
        
        guard !(self.text?.isEmpty)! else {
            
            self.rightViewMode = .always
            let emailImgContainer = UIView(frame: CGRect(x:(self.frame.origin.x+self.frame.width)-42, y: self.frame.origin.y, width: 32, height: 32))
            emailImgContainer.backgroundColor = .black
            let emailImView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
            emailImView.image = #imageLiteral(resourceName: "textFieldError")
            emailImView.center = emailImgContainer.center
            emailImgContainer.addSubview(emailImView)
            self.rightView = emailImgContainer
            return
        }
        
    }
    
    @IBInspectable var leftImage : UIImage? {
        didSet {
            if let image = leftImage{
                leftViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 20, height: 20))
                imageView.image = image
                imageView.tintColor = tintColor
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 25, height: 20))
                view.addSubview(imageView)
                leftView = view
            }else {
                leftViewMode = .never
            }
            
        }
    }
}



