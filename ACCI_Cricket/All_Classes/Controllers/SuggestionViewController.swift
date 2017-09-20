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
import AlamofireImage
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
                .queryLimited(toLast: 10)
                .observeSingleEvent(of: .value, with: { snapshot in
                    let postsnap = snapshot.value as! [String : AnyObject]

                    for (_,postVal) in postsnap{
                        let posst = Posts()
                        posst.author = postVal["author"] as? String
                        posst.likes = postVal["likes"] as? Int
                        posst.pathToImage = postVal["pathToImage"] as? String
                        posst.postID = postVal["postID"] as! String
                        posst.timeStamp =  postVal["timestamp"] as? String
                        posst.userIDPost = postVal["userID"] as? String
                        posst.textPosted = postVal["postText"] as? String
                        print(posst.postID as String)
                        ref.child("user").queryOrdered(byChild: "uid")
                            .queryEqual(toValue: posst.userIDPost)
                            .observeSingleEvent(of: .value, with: { snapshot in
                                print(snapshot.value!)
                                let postsnap = snapshot.value as! [String : AnyObject]
                                if postsnap.count<2 {
                                    for (_,postVal) in postsnap{
                                        let userPost = Users()
                                        userPost.fullName = postVal["username"] as? String
                                        userPost.imagePath = postVal["userProfileImageURL"] as? String
                                        posst.user = userPost
                                        self.post.append(posst)
                                    }
                                }
                                self.lastObjectKey = postsnap.first?.key
                                self.lastTimestamp = self.post[0].timeStamp
                                self.post = self.post.sorted(by: { $0.timeStamp > $1.timeStamp })
                                hideActivityView()
                                self.collectionView.isHidden = false
                                self.collectionView.reloadData()
                            })
                    }
                    
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
                            posst.textPosted = postVal["postText"] as? String
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


// MARK : UICollectionView & Flowlayout

extension SuggestionViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let picDimension = self.view.frame.size.width
      
        return CGSize(width: picDimension, height: picDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightInset = self.view.frame.size.width / 14.0
        return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? FeedCell
        cell?.imgViewSqure.af_setImage(
            withURL: URL(string: self.post[indexPath.row].pathToImage)!,
            placeholderImage: #imageLiteral(resourceName: "pictureOverlay"),
            filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: (cell?.imgViewSqure.frame.size)!, radius: 0.0),
            imageTransition: .crossDissolve(0.2)
        )
        
        cell?.imgUserProfile.af_setImage(
            withURL: URL(string: self.post[indexPath.row].user.imagePath)!,
            placeholderImage: #imageLiteral(resourceName: "userdummy"),
            filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: (cell?.imgViewSqure.frame.size)!, radius: 0.0),
            imageTransition: .crossDissolve(0.2)
        )
        
        cell?.lblUserProfileName.text = self.post[indexPath.row].user.fullName
        cell?.lblPostDateTime.text = self.post[indexPath.row].timeStamp
        cell?.lblDescriptionPost.text = self.post[indexPath.row].textPosted
        return cell!
    }
    
    
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.post.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}



