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

    @IBOutlet weak var btnProfileImage: UIButton!
    @IBOutlet weak var lblDyanamic: UILabel!
    @IBOutlet weak var txtUserEmail: UITextField!
    @IBOutlet weak var txtUserPassword: UITextField!
    @IBOutlet weak var txtUserName:
        UITextField!
    
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
        
        //Validate before sign-in or sign-up
        guard validateSignin() else {
            return
        }
        
        // Firebase authentication, If user email is not registered with app already, SIGN-UP. Otherwise SIGN-IN.
        Auth.auth().signIn(withEmail: (self.txtUserEmail?.text)!, password: (self.txtUserPassword?.text)!) { (user, error) in
            if (error != nil) {
                Auth.auth().createUser(withEmail: self.txtUserEmail.text!, password: self.txtUserPassword.text!) { (user, error) in
                    if (error != nil) {
                        print(error ?? "")
                          kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "Check your credentials once again", tag: 1000, cancelTitle: kAlerts.Cancel, presentInController: self)
                    }
                    let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
                    GlobleObjects.currentUser = user
                    GlobleObjects.userNameWD = self.txtUserName.text! as NSString
                    self.navigationController?.pushViewController(loginVC, animated: true)
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
    
}


 //MARK: UITextFieldDelegate Implementation
extension ViewController : UITextFieldDelegate{
    
    public func textFieldShouldReturn( _ textField: UITextField) -> Bool {
        let textFieldLocal  = textField as! CustomTextField
        textFieldLocal.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        _ = textField as! CustomTextField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        let textFieldLocal  = textField as! CustomTextField
        guard (textFieldLocal.text?.count)! > 0 else {
            textFieldLocal.rightImage = #imageLiteral(resourceName: "textFieldError")
            return
        }
        textFieldLocal.rightImage = nil
        textFieldLocal.resignFirstResponder()
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imageProfile = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            btnProfileImage.setImage(imageProfile, for: .normal)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
    
}






