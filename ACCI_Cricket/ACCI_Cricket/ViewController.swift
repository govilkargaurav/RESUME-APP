//
//  ViewController.swift
//  ACCI_Cricket
//
//  Created by GV on 18/08/17.
//  Copyright © 2017 webdunia. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class ViewController: UIViewController {

    
    weak var secureTextAlertAction: DOAlertAction?
    var customAlertController: DOAlertController!
    weak var textField1: UITextField?
    weak var textField2: UITextField?
    weak var customAlertAction: DOAlertAction?
    
    
    @IBOutlet weak var btnProfileImage: UIButton!
    @IBOutlet weak var lblDyanamic: UILabel!
    @IBOutlet weak var txtUserEmail: UITextField!
    @IBOutlet weak var txtUserPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    
    var imgProfile : UIImage?
    
    @IBOutlet weak var bottomContraintsFromView: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var handle : Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = false
        setupFirebaseDB()
    }
    
    
    func setupFirebaseDB() {
        self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            } as? Auth
    }
    
    
    @IBAction func presentPickerController(){
        let pickerController = UIImagePickerController()
        present(pickerController, animated: true, completion: nil)
        pickerController.delegate = self
    }
    
    
    @IBAction func userSignIn(_ sender: Any) {
        
        showCustomAlert()
        return
        
//        showActivityView()
//        
//        //Validate before sign-in or sign-up
//        guard validateSignin() else {
//            hideActivityView()
//            return
//        }
//        // Firebase authentication, If user email is not registered with app already, SIGN-UP. Otherwise SIGN-IN.
//        Auth.auth().signIn(withEmail: (self.txtUserEmail?.text)!, password: (self.txtUserPassword?.text)!) { (user, error) in
//            if (error != nil) {
//                Auth.auth().createUser(withEmail: self.txtUserEmail.text!, password: self.txtUserPassword.text!) { (user, error) in
//                    if (error != nil) {
//                        print(error ?? "")
//                        hideActivityView()
//                          kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "Check your credentials once again", tag: 1000, cancelTitle: kAlerts.Cancel, presentInController: self)
//                    }
//
//                    let storageRef =  Storage.storage().reference(forURL: "gs://hrms-2d575.appspot.com").child("profile_Photos").child((user?.uid)!)
//                    
//                    if let imgProfileTemp = self.imgProfile, let imageData = UIImageJPEGRepresentation(imgProfileTemp, 0.1){
//                        storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
//                            
//                            if error  != nil {
//                                hideActivityView()
//                                return
//                            }
//                           let profileImageURL = metadata?.downloadURL()?.absoluteString
//
//                            hideActivityView()
//                            
//                            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
//                            GlobleObjects.currentUser = user
//                            GlobleObjects.userNameWD = self.txtUserName.text as NSString?
//                            GlobleObjects.profilePictureURL = profileImageURL as NSString?
//                            
//                            guard GlobleObjects.currentUser?.uid != nil else {
//                                return
//                            }
//                            
//                            let ref = Database.database().reference().child("user").child((GlobleObjects.currentUser?.uid)!)
//                            ref.setValue(["useremail" : (GlobleObjects.currentUser?.email)!,"username" : GlobleObjects.userNameWD!, "userProfileImageURL" : GlobleObjects.profilePictureURL!])
//                            
//                            UIView.transition(from: (kObjects.acci_cricket_delegate.window?.rootViewController!.view)!, to: loginVC.view, duration: 0.4, options: [.transitionFlipFromRight], completion: {
//                                _ in
//                                kObjects.acci_cricket_delegate.window?.rootViewController = loginVC
//                            })
//                            
//                        })
//                        
//                    }
//                }
//            }
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard self.handle != nil else {
            return
        }
        Auth.auth().removeStateDidChangeListener(self.handle!)
    }

    
    //MARK: Function Validator, all at one function, to clean code
    func validateSignin() -> Bool{
        guard self.txtUserEmail?.text != "", self.txtUserPassword?.text != "", self.txtUserName?.text != "" else {
            kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "All fields are mendetory", tag: 1000, cancelTitle: kAlerts.Cancel, presentInController: self)
            return false
        }
        
        guard kValidator.isValidateEmail(string: txtUserEmail?.text) else {
            kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "Email is not valid", tag: 1000, cancelTitle: kAlerts.Cancel, presentInController: self)
            return false
        }
        
        guard (txtUserPassword?.text?.count)! > 5 else {
            kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "Password must be 6 character long", tag: 1000, cancelTitle: kAlerts.Cancel, presentInController: self)
            return false
        }
        
        guard kValidator.isNetworkAvailable() != true else {
            kAlerts.ShowAlertWithOkButton(title: kAppConstant.NetworkReachabilityTitle, message: kAppConstant.NetworkReachabilityAlert, tag: 1000, cancelTitle: kAlerts.Cancel, presentInController: self)
            return false
        }
        
        guard (txtUserPassword?.text?.count)! > 5 else {
            kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "Username must have 5 characters", tag: 1000, cancelTitle: kAlerts.Cancel, presentInController: self)
            return false
        }
        
        return true
        
    }
    
    func showCustomAlert() {
        let title = "LOGIN"
        let message = "Input your Email and Password"
        let cancelButtonTitle = "Cancel"
        let otherButtonTitle = "Login"
        
        customAlertController = DOAlertController(title: title, message: message, preferredStyle: .alert)
        
        // OverlayView
        customAlertController.overlayColor = UIColor(red:235/255, green:245/255, blue:255/255, alpha:0.7)
        // AlertView
        customAlertController.alertViewBgColor = UIColor(red:44/255, green:62/255, blue:80/255, alpha:1)
        // Title
        customAlertController.titleFont = UIFont(name: "Futura-Medium", size: 18.0)
        customAlertController.titleTextColor = UIColor(red:241/255, green:196/255, blue:15/255, alpha:1)
        // Message
        customAlertController.messageFont = UIFont(name: "Futura-Medium", size: 15.0)
        customAlertController.messageTextColor = UIColor.white
        // Cancel Button
        customAlertController.buttonFont[.cancel] = UIFont(name: "Futura-Medium", size: 16.0)
        // Default Button
        customAlertController.buttonFont[.default] = UIFont(name: "Futura-Medium", size: 16.0)
        customAlertController.buttonTextColor[.default] = UIColor.white
        customAlertController.buttonBgColor[.default] = UIColor(red: 18/255, green:135/255, blue:112/255, alpha:1)
        customAlertController.buttonBgColorHighlighted[.default] = UIColor(red:64/255, green:212/255, blue:126/255, alpha:1)
        
        
        customAlertController.addTextFieldWithConfigurationHandler { textField in
            self.textField1 = textField
            textField?.placeholder = "Email"
            textField?.frame.size = CGSize(width: 240.0, height: 30.0)
            textField?.font = UIFont(name: "Futura-Medium", size: 15.0)
            textField?.keyboardAppearance = UIKeyboardAppearance.dark
            textField?.returnKeyType = UIReturnKeyType.next
            
//            let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
//            label.text = "EMAIL"
//            label.font = UIFont(name: "Futura-Medium", size: 15.0)
//            textField?.leftView = label
//            textField?.leftViewMode = UITextFieldViewMode.always
            
            textField?.delegate = self
        }
        
        customAlertController.addTextFieldWithConfigurationHandler { textField in
            self.textField2 = textField
            textField?.isSecureTextEntry = true
            textField?.placeholder = "Password"
            textField?.frame.size = CGSize(width: 240.0, height: 30.0)
            textField?.font = UIFont(name: "Futura-Medium", size: 15.0)
            textField?.keyboardAppearance = UIKeyboardAppearance.dark
            textField?.returnKeyType = UIReturnKeyType.send
            
//            let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
//            label.text = "PASSWORD"
//            label.font = UIFont(name: "Futura-Medium", size: 15.0)
//            textField?.leftView = label
//            textField?.leftViewMode = UITextFieldViewMode.always
            
            textField?.delegate = self
        }
        
        // Create the actions.
        let cancelAction = DOAlertAction(title: cancelButtonTitle, style: .cancel) { action in
            NSLog("The \"Custom\" alert's cancel action occured.")
        }
        
        let otherAction = DOAlertAction(title: otherButtonTitle, style: .default) { action in
            NSLog("The \"Custom\" alert's other action occured.")
            
            let textFields = self.customAlertController.textFields as? Array<UITextField>
            if textFields != nil {
                for textField: UITextField in textFields! {
                    NSLog("  \(textField.placeholder!): \(String(describing: textField.text))")
                }
            }
        }
        customAlertAction = otherAction
        
        // Add the actions.
        customAlertController.addAction(cancelAction)
        customAlertController.addAction(otherAction)
        
        present(customAlertController, animated: true, completion: nil)
    }
    
}


 //MARK: UITextFieldDelegate Implementation
extension ViewController : UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField === textField1) {
            self.textField2?.becomeFirstResponder()
        } else if (textField === textField2) {
            customAlertAction!.handler(customAlertAction)
            self.textField2?.resignFirstResponder()
            self.customAlertController.dismiss(animated: true, completion: nil)
        }
        
        let textFieldLocal  = textField as! CustomTextField
        textFieldLocal.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        if textField.isKind(of: CustomTextField.self) {
            let textFieldLocal  = textField as! CustomTextField
            guard (textFieldLocal.text?.count)! > 0 else {
                textFieldLocal.rightImage = #imageLiteral(resourceName: "textFieldError")
                return
            }
            textFieldLocal.rightImage = nil
            textFieldLocal.resignFirstResponder()
        }
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imgProfile = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            btnProfileImage.setImage(imgProfile, for: .normal)
            self.imgProfile  = imgProfile
            dismiss(animated: true, completion: nil)
        }
    }

}










