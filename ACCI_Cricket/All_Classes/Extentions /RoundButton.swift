//
//  buttonExtension.swift
//  BOT
//
//  Created by Gaurav Govilkar on 21/06/17.
//  Copyright © 2017 WD. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class RoundButton: UIButton {
    
    @IBInspectable public var setBackgroundColor: UIColor = UIColor.red {
        didSet {
            self.backgroundColor = setBackgroundColor
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = kColor.APPCOLOR.cgColor
        self.clipsToBounds = true
    }
    
    @IBInspectable public var cornerRadius : CGFloat = 0{
         didSet {
        self.layer.cornerRadius = cornerRadius
        }
    }
}
