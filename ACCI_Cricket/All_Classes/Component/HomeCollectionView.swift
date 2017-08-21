////
////  HomeCollectionView.swift
////  ACCI_Cricket
////
////  Created by Gaurav Govilkar on 8/20/17.
////  Copyright © 2017 webdunia. All rights reserved.
////
//
//import UIKit
//
//class HomeCollectionView: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegate {
//
//
//
//
//
//    private func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        var returnValue = Int()
//
//        if section == 0 {
//            returnValue = 1
//
//        } else if section == 1 {
//            returnValue = self.section1DataSource.count
//
//        }
//
//        return returnValue
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        var cell = UICollectionViewCell()
//
//        let cellA:GroupPhoto = collectionView.dequeueReusableCell(withReuseIdentifier: "groupPhotoCard", for: indexPath) as! GroupPhoto
//        let cellB:AddFriendCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addFriendCard", for: indexPath) as! AddFriendCell
//
//        let section = indexPath.section
//
//        if section == 0 {
//
//            cell = cellA
//
//            //end of section 0
//        } else if section == 1 {
//            cell = cellB
//        }
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        var returnValue = CGSize()
//
//        if indexPath.section == 0 {
//
//            returnValue = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height / 3.0 - 8)
//
//        } else if indexPath.section == 1 {
//            returnValue = CGSize(width: collectionView.frame.size.width / 2.9 - 8, height: collectionView.frame.size.height / 2.9 - 8)
//        }
//
//        return returnValue
//    }
//
//}

