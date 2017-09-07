//
//  MatchResultViewController.swift
//  ACCI_Cricket
//
//  Created by Gaurav Govilkar on 8/20/17.
//  Copyright © 2017 webdunia. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
let identifier = "CellIdentifier"

class SuggestionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var post = [Posts]()
    var users = [Users]()
    var allUserIds = [String]()
    var lastTimestamp:String!
    var lastObjectKey:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        fetchPosts()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Fetch Posts from Firebase
    func fetchPosts(){
        showActivityView()
        let ref = Database.database().reference()
        
        if lastTimestamp == nil{
            ref.child("posts")
                .queryOrdered(byChild: "timestamp")
                .queryLimited(toLast: 2)
                .observeSingleEvent(of: .value, with: { snapshot in
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
                    self.lastObjectKey = postsnap.first?.key
                    self.lastTimestamp = self.post[0].timeStamp
                    hideActivityView()
                })
            ref.removeAllObservers()
            
        }else{
            
            ref.child("posts").queryOrdered(byChild: "timestamp")
                .queryEnding(atValue: self.lastTimestamp)
                .queryLimited(toLast: 2).observeSingleEvent(of: .value, with: { snapshot in
                    let postsnap = snapshot.value as! [String : AnyObject]
                    print(postsnap.first?.key as String!,self.lastObjectKey as String!)
                    for (key,postVal) in postsnap{
                        let lastkey = self.lastObjectKey as String!
                        let firstKey = key
                        if lastkey != firstKey {
                            let posst = Posts()
                            posst.author = postVal["author"] as? String
                            posst.likes = postVal["likes"] as? Int
                            posst.pathToImage = postVal["pathToImage"] as? String
                            posst.postID = postVal["postID"] as! String
                            posst.timeStamp =  postVal["timestamp"] as? String
                            self.post.append(posst)
                        }
                    }
                    self.post = self.post.sorted(by: { $0.timeStamp > $1.timeStamp })
                    self.lastObjectKey = self.post.last?.postID
                    self.lastTimestamp = self.post.last?.timeStamp
                    hideActivityView()
                })
            ref.removeAllObservers()
        }
    }
}

extension SuggestionViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let picDimension = self.view.frame.size.width
        return CGSize(width: picDimension, height: picDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightInset = self.view.frame.size.width / 14.0
        return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
    }
    
    
    private func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {

        let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:"header", for: indexPath as IndexPath) as! HeaderView
        
        return supplementaryView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    
    
}



