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

    @IBOutlet weak var txtUserEmail: UITextField!
    @IBOutlet weak var txtUserPassword: UITextField!
    
    var handle : Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = true
        setupFirebaseDB()
    }
    
    func setupFirebaseDB() {
        self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            } as? Auth
    }
    
    @IBAction func userSignIn(_ sender: Any) {
    
        //Validate before sign-in or sign-up
       validateSignin()
        
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
                    self.navigationController?.pushViewController(loginVC, animated: true)
                }
            }else{
                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
                GlobleObjects.currentUser = user
                self.navigationController?.pushViewController(loginVC, animated: true)
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

    
    //MARK: Function Valdator, all at one function, to clean code

    func validateSignin(){
        guard self.txtUserEmail?.text != nil, self.txtUserPassword?.text != nil else {
            return
        }
        
        guard kValidator.isValidateEmail(string: txtUserEmail?.text) else {
            kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "Email is not valid", tag: 1000, cancelTitle: kAlerts.Cancel, presentInController: self)
            return
        }
        
        guard (txtUserPassword?.text?.count)! > 5 else {
            kAlerts.ShowAlertWithOkButton(title: kAlerts.Title, message: "Password must be 6 character long", tag: 1000, cancelTitle: kAlerts.Cancel, presentInController: self)
            return
        }
        
        guard kValidator.isNetworkAvailable() != true else {
            kAlerts.ShowAlertWithOkButton(title: kAppConstant.NetworkReachabilityTitle, message: kAppConstant.NetworkReachabilityAlert, tag: 1000, cancelTitle: kAlerts.Cancel, presentInController: self)
            return
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

