//
//  TabbarController.swift
//  ACCI_Cricket
//
//  Created by Gaurav Govilkar on 8/20/17.
//  Copyright © 2017 webdunia. All rights reserved.
//

import UIKit
import FirebaseAuth


struct GlobleObjects {
    static var currentUser = Auth.auth().currentUser
}

class TabbarController: UITabBarController {

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTabbar()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    func setupTabbar(){
        
        self.tabBar.isTranslucent = false
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = kColor.RGB(red: 175.0, green: 81.0, blue: 88.0).cgColor
        self.tabBar.layer.addSublayer(topBorder)
        self.tabBar.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
