//
//  ScoreViewController.swift
//  ACCI_Cricket
//
//  Created by Gaurav Govilkar on 8/20/17.
//  Copyright © 2017 webdunia. All rights reserved.
//

import UIKit
import FirebaseDatabase


class TimesheetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard GlobleObjects.currentUser?.uid != nil else {
            return
        }
        let ref = Database.database().reference().child("user").child((GlobleObjects.currentUser?.uid)!)
        ref.setValue(["useremail" : (GlobleObjects.currentUser?.email)!])
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
