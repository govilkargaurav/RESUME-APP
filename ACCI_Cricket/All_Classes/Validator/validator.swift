//
//  validator.swift
//  ACCI_Cricket
//
//  Created by GV on 18/08/17.
//  Copyright © 2017 webdunia. All rights reserved.
//

import Foundation
import SVProgressHUD
import ReachabilitySwift
import UIKit



protocol alertControllerdelegate {
    func okBtnClicked(dictPara : [ String : String])
}

struct kDelegate {
    public var delegate : alertControllerdelegate?
}

func showActivityView(){
    SVProgressHUD.show()
}

func hideActivityView(){
    SVProgressHUD.dismiss()
}

func estimatedHeightOfLabel(text: String, inWhichView currentView : UIView) -> CGFloat {
    
    let size = CGSize(width: currentView.frame.width - 16, height: 1000)
    
    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    
    let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10)]
    
    let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
    
    return rectangleHeight
}


//MARK: Color
struct kColor {
    static let NavBarBackground = UIColor(red: 0.0/255.0, green: 176.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let APPCOLOR = UIColor(red: 18.0/255.0, green: 135.0/255.0, blue: 112.0/255.0, alpha: 1.0)
    
    static let LableTitle = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    static let SeperatorColor = UIColor(red: 178.0/255.0, green: 178.0/255.0, blue: 178.0/255.0, alpha: 1.0)
    
    static func RGB(red r:CGFloat, green g:CGFloat, blue b:CGFloat)->UIColor{
        return UIColor(red: CGFloat(r)/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    
    static func RGBA(red r:CGFloat, green g:CGFloat, blue b:CGFloat, andAlpha a:CGFloat)->UIColor{
        return UIColor(red: CGFloat(r)/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
}



struct kAlerts {
    static let Messages = "APPLICATION DEVELOPMENT COMPANY ACCI"
    static let Title = "HRMS"
    static let AppName = "ACCI CRICKET"
    static let Error : String = "Error"
    static let Success : String = "Error"
    static let Ok = "OK"
    static let Cancel = "CANCEL"
    static let Delete = "DELETE"
    static let Yes = "YES"
    static let No = "NO"
    static let Confirm = "CONFIRM"
    
    static func ShowAlertWithCancelButton(title strTitle:String, message strMessage:String, tag intTag: NSInteger, cancelTitle strCancelTitle:String, presentInController preserntIn: UIViewController) -> Void {
        //        if kValidator.isSystemVersionGreaterThanOrEqualTo(compareVersion: "9.0"){
        let alertController :UIAlertController = UIAlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
        alertController.view.tag = intTag
        let cancelAction = UIAlertAction(title:strCancelTitle , style: .default, handler:{ (action:UIAlertAction!) -> Void in
        })
        alertController.addAction(cancelAction)
        preserntIn.present(alertController, animated: true, completion: nil)
        //        }
    }
    
    static func ShowAlertWithOkButtonandTextField(title strTitle:String, message strMessage:String, tag intTag: NSInteger, cancelTitle strCancelTitle:String,okbtnTitle strOkbtnTitle:String, presentInController preserntIn: UIViewController) -> Void {
        hideActivityView()
        let alertController = UIAlertController(title: strTitle, message:strMessage, preferredStyle: .alert)
     
        let saveAction = UIAlertAction(title: strOkbtnTitle, style: .default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            print("firstName \(String(describing: firstTextField.text)), secondName \(String(describing: secondTextField.text))")

            //kDelegate?.delegate.okBtnClicked(dictPara: ["first" : firstTextField.text!, "second" : secondTextField.text!])
            
            
        })
        let cancelAction = UIAlertAction(title: strCancelTitle, style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Email"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Password"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        preserntIn.present(alertController, animated: true, completion: nil)
    }
    
    
    static func ShowAlertWithOkButton(title strTitle:String, message strMessage:String, tag intTag: NSInteger, cancelTitle strCancelTitle:String, presentInController preserntIn: UIViewController) -> Void {
        hideActivityView()
        //        if kValidator.isSystemVersionGreaterThanOrEqualTo(compareVersion: "9.0"){
        let alertController :UIAlertController = UIAlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
        alertController.view.tag = intTag
        let cancelAction = UIAlertAction(title:strCancelTitle , style: .default, handler:{ (action:UIAlertAction!) -> Void in
        })
        alertController.addAction(cancelAction)
        preserntIn.present(alertController, animated: true, completion: nil)
        //        }
    }
    
    static func ShowAlertWithCancelAndOkButton(title strTitle:String, message strMessage:String, tag intTag: NSInteger, cancelTitle strCancelTitle:String, presentInController preserntIn: UIViewController) -> Void {
        //        if kValidator.isSystemVersionGreaterThanOrEqualTo(compareVersion: "9.0"){
        let alertController :UIAlertController = UIAlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
        alertController.view.tag = intTag
        let okAction = UIAlertAction(title:strCancelTitle , style: .default, handler:{ (action:UIAlertAction!) -> Void in
        })
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title:strCancelTitle , style: .default, handler:{ (action:UIAlertAction!) -> Void in
        })
        alertController.addAction(cancelAction)
        preserntIn.present(alertController, animated: true, completion: nil)
        //        }
    }
}

struct kAppConstant {
    static let CalenderDateFormat:String = "dd/MM/yyyy"
    static let Platform:String = "IOS"
    static let ImageNameServicePlaceHolder : String = "img_placeholder"
    static let ImageNamePlaceHolder : String = "placeholderimage.png"
    static let ImageNameBackIndicator : String = "btn_back_indicator"
    static let NetworkReachabilityTitle : String = "No network connection"
    static let NetworkReachabilityAlert : String = "Sorry, we can't currently refresh the app. Please check your internet connection."
    static let ActivityLoaderSize :CGSize = CGSize(width:40 ,height:40)
    static let ScreenBounds:CGRect = UIScreen.main.bounds
}

struct kObjects {
    static let acci_cricket_delegate :AppDelegate = UIApplication.shared.delegate as! AppDelegate
    static let ImagePlaceHolder :UIImage = UIImage(named:kAppConstant.ImageNamePlaceHolder)!
    static let ImageServicePlaceHolder :UIImage = UIImage(named:kAppConstant.ImageNameServicePlaceHolder)!
    static let ImageBackButtonIndicator :UIImage = UIImage(named:kAppConstant.ImageNameBackIndicator)!
    static func className(object obj:AnyObject)-> String {
        return String(describing: (obj))
    }
}

struct kValidator {
    static func isNetworkAvailable()->Bool{
        guard kObjects.acci_cricket_delegate.reachability != nil else {
            print("NO REACHABILITY OBJECT AVAILABLE")
            return false
        }
        let reachability:Reachability = kObjects.acci_cricket_delegate.reachability!
        let remoteHostStatus:Reachability.NetworkStatus = reachability.currentReachabilityStatus
        var isNetworkAvailable:Bool = true
        
        if remoteHostStatus == Reachability.NetworkStatus.notReachable {
            isNetworkAvailable = false
        }
        return isNetworkAvailable;
    }
    
    static func isValidString(value:AnyObject?)-> Bool
    {
        if(value == nil || value!.isKind(of: NSNull.self) == true || value!.isKind(of:NSString.self) == false || (value!.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) as NSString).length<1)
        {
            return false
        }
        return true
    }
    
    static func isArrayWithItems(value: AnyObject?) ->Bool {
        do {
            let isValid:Bool = (value == nil || value!.isKind(of: NSNull.self) == true || value!.isKind(of: NSArray.self) == false || value!.isKind(of: NSMutableArray.self) == false) ? value!.count > 0 : false
            return isValid
        }catch _ {
            return false
        }
    }
    
    static func isDictionaryWithItems(value: AnyObject?)->Bool {
        do {
            let isValid:Bool = (value == nil || value!.isKind(of: NSNull.self) == true || value!.isKind(of: NSDictionary.self) == false || value!.isKind(of: NSMutableDictionary.self) == false) ? value!.count > 0 : false
            return isValid
        }catch _ {
            return false
        }
    }
    
    static func isValueExistInDictionaryWithItems(value: AnyObject?)->Bool {
        return (value != nil) ? true : false
    }
    
    static func isValidNumber(value: AnyObject?)->Bool {
        if (value == nil || value!.isKind(of: NSNumber.self) == false || value!.isEqual(NSNull())){
            return false
        }
        return true
    }
    
    static func isSystemVersionGreaterThanOrEqualTo(compareVersion: String) -> Bool {
        if UIDevice.current.systemVersion.compare(compareVersion, options: NSString.CompareOptions.numeric) != ComparisonResult.orderedAscending {
            return true
        }
        return false
    }
    
    static func isPasswordContainsSpace(password strPassword:String) -> Bool{
        if strPassword .components(separatedBy: " ").count>1 {
            return true
        }
        return false
    }
    
    static func isValidateUsername(username strUsername:String) -> Bool {
        do{
            let regex = try NSRegularExpression(pattern: "^[0-9a-zA-Z\\_.]{0,18}$", options: .caseInsensitive)
            if regex.matches(in: strUsername, options: [], range: NSMakeRange(0, strUsername.characters.count)).count > 0 {return true}
        }
        catch {}
        return false
    }
    static func isIphone5()->Bool {
        if UIScreen.main.scale>0  {
            if (UIScreen.main.bounds.size.height * UIScreen.main.scale) >= 1136 {
                return true
            }
        }
        return false
    }
    
    static func isRetinaDevice()->Bool {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
        {
            let scale : CGFloat = UIScreen.main.scale
            
            if (scale > 1.0)
            {
                //iPad retina screen
                return true
            }
            else
            {
                //iPad screen
                return false
            }
        }
        else
        {
            if (UIScreen.instancesRespond(to: #selector(NSDecimalNumberBehaviors.scale)))
            {
                let scale : CGFloat = UIScreen.main.scale
                
                if (scale > 1.0)
                {
                    return true
                }
                else
                {
                    //iphone screen
                    return false
                }
            }
        }
        return false
    }
    
    static func isNumeric(inputString strInput:NSString)->Bool{
        var isValid:Bool = false
        let alphaNumbersSet:NSCharacterSet = NSCharacterSet.decimalDigits as NSCharacterSet
        let stringSet:NSCharacterSet = NSCharacterSet.init(charactersIn: strInput as String)
        isValid = alphaNumbersSet.isSuperset(of: stringSet as CharacterSet)
        return isValid
    }
    
    static func isValidURL(string: String?) -> Bool {
        guard let urlString = string else {return false}
        guard let url = NSURL(string: urlString) else {return false}
        if !UIApplication.shared.canOpenURL(url as URL) {return false}
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
    static func isValidateEmail(string: String?) -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
    static func isValidateName(string: String?) -> Bool {
        let regEx = "^([A-Za-z]\" \"(\\.)?+(\\s)?[A-Za-z|\\'|\\.]*){1,400}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
    static func isValidatePhoneNumber(string: String?) -> Bool {
        let regEx = "^((\\+)|(00))[0-9]{6,14}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    static func isValidatePhoneNumberWithoutCountry(string: String?) -> Bool {
        let regEx = "^[0-9]{10,10}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    static func isValidateMobileNumber(string: String?) -> Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: string!, options: [], range: NSMakeRange(0, (string?.characters.count)!))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == string!.characters.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    static func isValidateLandlineNumber(string: String?) -> Bool {
        let regEx = ""
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    static func isValidateNumber(string: String?) -> Bool {
        let regEx = "^[0-9]*$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
    static func isValidatePassword(string: String?) -> Bool {
        let regEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{6,14}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        print("\(String(describing: string)) isValidatePassword \(predicate.evaluate(with: string))")
        return predicate.evaluate(with: string)
    }
    
    static func isValidateAlphaNumeric(string:String) -> Bool {
        let character:CharacterSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ").inverted
        let strFiltered:String = string.components(separatedBy: character).joined(separator: "")
        return (string == strFiltered)
    }
    
    static func isValidateNumeric(string:String) -> Bool {
        let character:CharacterSet = CharacterSet(charactersIn: "0123456789").inverted
        let strFiltered:String = string.components(separatedBy: character).joined(separator: "")
        return (string == strFiltered)
    }
    
    static func isValidateAlpha(string:String) -> Bool {
        let character:CharacterSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ").inverted
        let strFiltered:String = string.components(separatedBy: character).joined(separator: "")
        return (string == strFiltered)
    }
    
    static func  isContainsAlpha(string:String ) -> Bool {
        let regEx = ".*[a-zA-Z]+.*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
    static func isContainsNumber(string:String) -> Bool  {
        let regEx = ".*\\d+.*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
    static func isValidateURL(string: String?) -> Bool {
        let regEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
    static func isValidateURLWithNSURL(string: String?) -> Bool {
        if let _:NSURL = NSURL(string: string!) {
            return true
        }
        return false
    }
    static func isDeviceInterfaceIdiom(withIdiom idiom:UIUserInterfaceIdiom) -> Bool {
        var isDeviceIdiom:Bool = false
        if UIDevice.current.userInterfaceIdiom == idiom {
            isDeviceIdiom = true
        }
        return isDeviceIdiom
    }
}

