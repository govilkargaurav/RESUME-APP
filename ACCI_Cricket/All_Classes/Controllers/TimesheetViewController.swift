//
//  ScoreViewController.swift
//  ACCI_Cricket
//
//  Created by Gaurav Govilkar on 8/20/17.
//  Copyright © 2017 webdunia. All rights reserved.
//

import UIKit
import FirebaseAuth


class TimesheetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let loguterror {
            print(loguterror)
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initViewController: UIViewController = storyBoard.instantiateViewController(withIdentifier: "NavController") as! NavViewController
        
        UIView.transition(from: (kObjects.acci_cricket_delegate.window?.rootViewController!.view)!, to: initViewController.view, duration: 0.5, options: [.transitionFlipFromRight], completion: {
            _ in
            kObjects.acci_cricket_delegate.window?.rootViewController? = initViewController
        })
        
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
