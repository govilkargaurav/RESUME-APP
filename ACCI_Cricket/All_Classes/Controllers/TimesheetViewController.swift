//
//  ScoreViewController.swift
//  ACCI_Cricket
//
//  Created by Gaurav Govilkar on 8/20/17.
//  Copyright © 2017 webdunia. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class TimesheetViewController: UIViewController {
    
    var post = [Posts]()
    var users = [Users]()
    var allUserIds = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPosts()
        // Do any additional setup after loading the view.
    }
    
    func fetchPosts(){
        
        let ref = Database.database().reference()
        
        ref.child("posts").queryOrderedByKey().queryLimited(toFirst: 2).observeSingleEvent(of: .value, with: { snapshot in
             let postsnap = snapshot.value as! [String : AnyObject]
            
            for (_,postVal) in postsnap{

                let posst = Posts()
                
                    posst.author = postVal["author"] as? String
                    posst.likes = postVal["likes"] as? Int
                    posst.pathToImage = postVal["pathToImage"] as? String
                    posst.postID = postVal["postID"] as! String
                    posst.timeStamp =  postVal["timestamp"] as? String
                    self.post.append(posst)
            }
            
            print(self.post[1])
            self.getNextElements(lastelement: self.post[1].postID)
        })
        ref.removeAllObservers()
    }
    
    func getNextElements(lastelement : String) {
        let ref = Database.database().reference()
        
        let query =    ref.child("posts").queryEnding(atValue: lastelement, childKey: "postID")
        query.queryLimited(toLast: 1).observeSingleEvent(of: .value, with: { snapshot in
            let posts = snapshot.value as! [String : AnyObject]
            print(posts)
            // Do stuff with this page of elements
            //...

        })
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
