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
        self.layer.cornerRadius = 70.0
        self.clipsToBounds = true
    }
}
