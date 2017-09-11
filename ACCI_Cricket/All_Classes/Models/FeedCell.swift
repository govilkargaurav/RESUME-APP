//
//  FeedCell.swift
//  ACCI_Cricket
//
//  Created by Gaurav Govilkar on 9/7/17.
//  Copyright © 2017 webdunia. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    @IBOutlet weak var imgViewSqure: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}
