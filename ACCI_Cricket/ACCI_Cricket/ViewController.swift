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
    
    
    @IBOutlet weak var loginLabel: UILabel!
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
        // Initiate FirebaseDB
        setupFirebaseDB()
        
        //Dyanamic Height of scroll View in Lower resolution devices
        bottomContraintsFromView.constant =  (loginLabel.frame.origin.y + loginLabel.frame.height + 10) - (self.view.frame.height - 64)

        //Tap on Login lable of Existing users
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        loginLabel.isUserInteractionEnabled = true
        loginLabel.addGestureRecognizer(tapgesture)
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        showCustomAlert()
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
        showActivityView()
        
        //Validate before sign-in or sign-up
        guard validateSignin() else {
            hideActivityView()
            return
        }
        
        // Firebase authentication, If user email is not registered with app already, SIGN-UP. Otherwise SIGN-IN.
        Auth.auth().signIn(withEmail: (self.txtUserEmail?.text)!, password: (self.txtUserPassword?.text)!) { (user, error) in
            if (error != nil) {
                Auth.auth().createUser(withEmail: self.txtUserEmail.text!, password: self.txtUserPassword.text!) { (user, error) in
                    if (error != nil) {
                        print(error ?? "")
                        hideActivityView()
                          kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "Check your credentials once again", tag: 1000, cancelTitle: kAlerts.Ok, presentInController: self)
                    }

                    let storageRef =  Storage.storage().reference(forURL: kAppConstant.FirebaseDBURL).child("profile_Photos").child((user?.uid)!)
                    if let imgProfileTemp = self.imgProfile, let imageData = UIImageJPEGRepresentation(imgProfileTemp, 0.1){
                        storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in

                            if error  != nil {
                                hideActivityView()
                                return
                            }
                           let profileImageURL = metadata?.downloadURL()?.absoluteString

                            hideActivityView()

                            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
                            GlobleObjects.currentUser = user
                            GlobleObjects.userNameWD = self.txtUserName.text as NSString?
                            GlobleObjects.profilePictureURL = profileImageURL as NSString?

                            guard GlobleObjects.currentUser?.uid != nil else {
                                return
                            }

                            let ref = Database.database().reference().child("user").child((GlobleObjects.currentUser?.uid)!)
                            ref.setValue(["useremail" : (GlobleObjects.currentUser?.email)!,
                                               "username" : GlobleObjects.userNameWD!,
                                               "userProfileImageURL" : GlobleObjects.profilePictureURL!,
                                               "uid" : (GlobleObjects.currentUser?.uid)!])
                            
                            let changeRequest  = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.displayName = GlobleObjects.userNameWD! as String
                            changeRequest?.commitChanges(completion: nil)

                            UIView.transition(from: (kObjects.acci_cricket_delegate.window?.rootViewController!.view)!, to: loginVC.view, duration: 0.4, options: [.transitionFlipFromRight], completion: {
                                _ in
                                kObjects.acci_cricket_delegate.window?.rootViewController = loginVC
                            })

                        })

                    }
                }
            }
        }
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
        
        guard self.imgProfile != nil else {
            kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "You look good! Don't hesitate to share your picture with us", tag: 1000, cancelTitle: kAlerts.Cancel, presentInController: self)
            return false
        }
        
        guard self.txtUserEmail?.text != "", self.txtUserPassword?.text != "", self.txtUserName?.text != "" else {
            kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "Don't be shy, fill out all the fields", tag: 1000, cancelTitle: kAlerts.Ok, presentInController: self)
            return false
        }
        
        guard kValidator.isValidateEmail(string: txtUserEmail?.text) else {
            kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "oops! Have you entered correct email address? Please check once", tag: 1000, cancelTitle: kAlerts.Ok, presentInController: self)
            return false
        }
        
        guard (txtUserPassword?.text?.count)! > 5 else {
            kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "We insist to keep your password atleast 6 characters long! Let's give hackers a hard time", tag: 1000, cancelTitle: kAlerts.Ok, presentInController: self)
            return false
        }
        
        guard kValidator.isNetworkAvailable() != true else {
            kAlerts.ShowAlertWithOkButton(title: kAppConstant.NetworkReachabilityTitle, message: kAppConstant.NetworkReachabilityAlert, tag: 1000, cancelTitle: kAlerts.Ok, presentInController: self)
            return false
        }
        
        guard (txtUserPassword?.text?.count)! > 5 else {
            kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "Username must have 5 characters", tag: 1000, cancelTitle: kAlerts.Ok, presentInController: self)
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
            textField?.delegate = self
        }
        
        // Create the actions.
        let cancelAction = DOAlertAction(title: cancelButtonTitle, style: .cancel) { action in
            NSLog("The \"Custom\" alert's cancel action occured.")
        }
        
        let otherAction = DOAlertAction(title: otherButtonTitle, style: .default) { action in
            NSLog("The \"Custom\" alert's other action occured.")
            showActivityView()
            let textFields = self.customAlertController.textFields as? Array<UITextField>
            if textFields != nil {
                let textFieldEmail = textFields?[0] as UITextField?
                let textFieldPassword = textFields?[1] as UITextField?
                
                guard kValidator.isValidateEmail(string: textFieldEmail?.text) else{
                    self.customAlertController.dismiss(animated: true, completion: nil)
                    hideActivityView()
                    kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "oops! Have you entered correct email address? Please check once", tag: 1000, cancelTitle: kAlerts.Cancel, presentInController: self)
                    return
                }
                
                Auth.auth().signIn(withEmail: (textFieldEmail?.text)!, password: (textFieldPassword?.text)!, completion: { (user, error) in
                    guard (error == nil) else {
                        self.customAlertController.dismiss(animated: true, completion: nil)
                        hideActivityView()
                        kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "oops! Something is wrong with your credentials", tag: 1000, cancelTitle: kAlerts.Cancel, presentInController: self)
                        return
                    }
                    
                        hideActivityView()
                       let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
                        UIView.transition(from: (kObjects.acci_cricket_delegate.window?.rootViewController!.view)!, to: loginVC.view, duration: 0.4, options: [.transitionFlipFromRight], completion: { _ in                                kObjects.acci_cricket_delegate.window?.rootViewController = loginVC
                    })
                })
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


//MARK : UIPickerViewDelegate Implementation
extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imgProfile = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            btnProfileImage.setImage(imgProfile, for: .normal)
            self.imgProfile  = imgProfile
            dismiss(animated: true, completion: nil)
        }
    }
}

