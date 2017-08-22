//
//  TextViewExt.swift
//  ACCI_Cricket
//
//  Created by Gaurav Govilkar on 8/22/17.
//  Copyright © 2017 webdunia. All rights reserved.
//

import UIKit

@IBDesignable public class TxtViewExtn: UITextView {
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}

