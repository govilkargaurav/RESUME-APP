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
    var lastTimestamp:String!
    var lastObjectKey:String!
    let posst = Posts()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPosts()
        // Do any additional setup after loading the view.
    }
    
    func fetchPosts(){
        
        let ref = Database.database().reference()
        if lastTimestamp == nil{
            ref.child("posts").queryOrdered(byChild: "timestamp").queryLimited(toLast: 2).observeSingleEvent(of: .value, with: { snapshot in
                let postsnap = snapshot.value as! [String : AnyObject]
                
                for (_,postVal) in postsnap{

                    self.posst.author = postVal["author"] as? String
                    self.posst.likes = postVal["likes"] as? Int
                    self.posst.pathToImage = postVal["pathToImage"] as? String
                    self.posst.postID = postVal["postID"] as! String
                    self.posst.timeStamp =  postVal["timestamp"] as? String
                    self.post.append(self.posst)
                }
                self.lastObjectKey = postsnap.first?.key
                self.lastTimestamp = self.post[0].timeStamp
                print(self.post.count)
                self.fetchPosts()
            })
            ref.removeAllObservers()
            
        }else{
            print(self.post.count)
            ref.child("posts").queryOrdered(byChild: "timestamp")
                .queryEnding(atValue: self.lastTimestamp)
                .queryLimited(toLast: 2).observeSingleEvent(of: .value, with: { snapshot in
                    let postsnap = snapshot.value as! [String : AnyObject]
                    for (_,postVal) in postsnap{
                        if postsnap.first?.key != self.lastObjectKey{
                            posst.author = postVal["author"] as? String
                            posst.likes = postVal["likes"] as? Int
                            posst.pathToImage = postVal["pathToImage"] as? String
                            posst.postID = postVal["postID"] as! String
                            posst.timeStamp =  postVal["timestamp"] as? String
                            self.post.append(posst)
                        }
                    }
                    let sortedArray = self.post.sorted(by: { $0.timeStamp > $1.timeStamp })
                    for originalPost in sortedArray{
                        print(originalPost.timeStamp, originalPost.userID)
                    }
                    
                    self.lastObjectKey = postsnap.first?.key
                    self.lastTimestamp = self.post[0].timeStamp
                    self.fetchPosts()
                })
            ref.removeAllObservers()
        }
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
