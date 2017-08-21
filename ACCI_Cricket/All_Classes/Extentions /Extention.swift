//
//  Extention.swift
//  BOT
//
//  Created by Ashish Vani on 05/07/17.
//  Copyright © 2017 WD. All rights reserved.
//

import UIKit

//MARK:- extension

// #define Constant
let kBGViewTag:Int = 1000



extension UIViewController {
    func addCommanBackgroundImageInView() {
        let bgImage = UIImageView(image: UIImage(named: "img_all_background"))
        bgImage.tag = kBGViewTag
        bgImage.frame = self.view.bounds
        self.view.addSubview(bgImage)
        self.view .sendSubview(toBack: bgImage)
    }
    
    func resetCommanBackgroundImageRect() {
        if let bgImage:UIImageView = self.view.viewWithTag(kBGViewTag) as? UIImageView {
            bgImage.frame = self.view.bounds
            self.view .sendSubview(toBack: bgImage)
        }
    }
}

extension String {
    func convertToJsonObject() -> Any? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

extension Date {
    static func offsetFrom(fromDate:Date, toDate:Date) -> Bool {
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.month,.hour, .year, .minute])
        let component = calendar.dateComponents(unitFlags, from: fromDate,to: toDate)
        
        var seconds:Int = 0
        var minutes:Int = 0

        if component.second != nil {
            seconds = component.second!
        }
        
        if component.minute != nil {
            minutes = component.minute!
        }

        if seconds > 0 && minutes > 0 &&  minutes < 10 {
            return true
        }
        
        return false
    }
}


// MARK: - UIView
extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    func dropShadow(cornerRadious:CGFloat) {
        self.layer.cornerRadius = cornerRadious
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor(red: 84/255.0, green: 134/255.0, blue: 212/255.0, alpha: 1.0).cgColor
    }
    
    func border(withWidth width:CGFloat, andColor color: UIColor, andRadius radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth  = width
        self.layer.borderColor  = color.cgColor
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
}


extension UserDefaults {
    subscript(key: String) -> Any? {
        get {
            return self[key]
        }
        
        set {
            if let v = newValue as? String {
                set(v, forKey: key)
            } else if let v = newValue as? Int {
                set(v, forKey: key)
            }
        }
    }
}

