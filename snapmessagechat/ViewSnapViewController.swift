//
//  ViewSnapViewController.swift
//  snapmessagechat
//
//  Created by Matthew Manion on 8/25/19.
//  Copyright © 2019 Matthew Manion. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage
import FirebaseAuth
import FirebaseStorage

class ViewSnapViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var snapshot : DataSnapshot?
    
    var imageName = ""
    var snapID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let snapshot = snapshot {
        if let snapDictionary = snapshot.value as? NSDictionary {
                if let imageName = snapDictionary["imageName"] as? String {
                    if let imageURL = snapDictionary["imageURL"] as? String {
                        if let message = snapDictionary["message"] as? String {
                            messageLabel.text = message
                            if let url = URL(string: imageURL) {
                                imageView.sd_setImage(with: url)
                            }
                            self.imageName = imageName
                            
                            snapID = snapshot.key
                        }
                    }
                }
            }
        }
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        if let uid = Auth.auth().currentUser?.uid {
            Database.database().reference().child("users").child(uid).child("snaps").child(snapID).removeValue()
            
            Storage.storage().reference().child("images").child(imageName).delete(completion: nil)
        }
    }

}
