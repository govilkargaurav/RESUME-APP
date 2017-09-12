//
//  HeaderView.swift
//  ACCI_Cricket
//
//  Created by GV on 07/09/17.
//  Copyright © 2017 webdunia. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    @IBOutlet weak var imgUserProfile: RoundImage!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}

