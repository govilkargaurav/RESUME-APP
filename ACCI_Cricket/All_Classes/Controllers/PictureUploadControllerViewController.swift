//
//  PictureUploadControllerViewController.swift
//  ACCI_Cricket
//
//  Created by GV on 31/08/17.
//  Copyright © 2017 webdunia. All rights reserved.
//

import UIKit
import Firebase

class PictureUploadControllerViewController: UIViewController {

    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var textViewPost: TxtViewExtn!
    var imgProfile : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Show a dialog with two custom buttons.
   @IBAction func openCameraActivity() {
        let title = "CAMEARA"
        let message = "Choose your option to pick photo "
        let destructiveButtonTitle = "Device Camera"
        let otherButtonTitle = "Picture Gallery"
        
        let alertController = DOAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        // Create the actions.
        let destructiveAction = DOAlertAction(title: destructiveButtonTitle, style: .destructive) { action in
            NSLog("The \"Other\" alert action sheet's destructive action occured.")
        }
        
        let otherAction = DOAlertAction(title: otherButtonTitle, style: .default) { action in
            alertController.dismiss(animated: true, completion: {
                let pickerController = UIImagePickerController()
                self.present(pickerController, animated: true, completion: nil)
                pickerController.delegate = self
            })
       
        }
        
        // Add the actions.
        alertController.addAction(destructiveAction)
        alertController.addAction(otherAction)
        
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func postPressed(_ sender: Any) {
        do {
            try pictureUploadTask()
        } catch Errorbase.ConnectionFaild {
            print("Invalid Selection.")
            return
        }catch{
            print("Something is wrong")
        }
      }
    
    
    func pictureUploadTask() throws {
        
        showActivityView()
        
        guard kValidator.isNetworkAvailable() else{
            throw Errorbase.ConnectionFaild
        }
        
        //Get the Autentic Current User & get storage Database referance.
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference()
        let storage = Storage.storage().reference(forURL: kAppConstant.FirebaseDBURL)
        
        //Create New Post Node on Firebase with Unique key init.
        let key = ref.child("posts").childByAutoId().key
        let imageRef = storage.child("posts").child(uid).child("\(key).jpg")
        
        //Convert Image into NSData
        let data = UIImageJPEGRepresentation(self.imgProfile!, 0.6)
        
        
        //Start Uploading Image & create feed in Firebase
        let uploadTask = imageRef.putData(data!, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error!.localizedDescription)
                hideActivityView()
                return
            }
            imageRef.downloadURL(completion: { (url, error) in
                if let url = url {
                    let feed = ["userID" : uid,
                                "pathToImage" : url.absoluteString,
                                "likes" : 0,
                                "author" : Auth.auth().currentUser!.displayName!,
                                "postID" : key,
                                "postText" : self.textViewPost.text,
                                "timestamp" : Date().toMillis()] as [String : Any]
                    
                    let postFeed = ["\(key)" : feed]
                    
                    ref.child("posts").updateChildValues(postFeed)
                    hideActivityView()
                }
            })
        }
        uploadTask.resume()
    }
    }

//MARK : UITextViewDelegate
extension PictureUploadControllerViewController : UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        self.view.layoutIfNeeded()
    }
}

//MARK : UIImagePickerControllerDelegate
extension PictureUploadControllerViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imgProfile = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            //imgPost.setImage(imgProfile, for: .normal)
            imgPost.image = imgProfile
            self.imgProfile  = imgProfile
            dismiss(animated: true, completion: nil)
        }
    }
}

