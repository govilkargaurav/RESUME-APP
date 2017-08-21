//
//  roundedBorderView.swift
//  BOT
//
//  Created by WebDunia on 20/07/17.
//  Copyright © 2017 WD. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable public class roundedBorderView: UIView {
    
    override public func layoutSubviews() {
         super.layoutSubviews()
        let color = kColor.RGB(red: 175.0, green: 81.0, blue: 88.0).cgColor
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        self.layer.addSublayer(shapeLayer)
    }
}


