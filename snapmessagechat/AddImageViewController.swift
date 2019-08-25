//
//  AddImageViewController.swift
//  snapmessagechat
//
//  Created by Matthew Manion on 8/23/19.
//  Copyright © 2019 Matthew Manion. All rights reserved.
//

import UIKit
import Firebase

class AddImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var imageName = "\(NSUUID().uuidString).jpeg"
    var imageURL = ""
    
    var imagePicker = UIImagePickerController()
    
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        
        let imageFolder = Storage.storage().reference().child("images")
        
        if let image = imageView.image {
            if let imageData = image.jpegData(compressionQuality: 0.75) {
                
                imageFolder.child(imageName).putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if let error = error {
                        print(error)
                    } else {
                        
                        if let imageURL = metadata?.downloadURL()?.absoluteString {
                            self.imageURL = imageURL
                            
                            self.performSegue(withIdentifier: "addImageToSelectUser", sender: nil)
                        }
                        
                        
                    }
                }
                )
            }

    }
    }
            
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectTVC = segue.destination as? SelectUserTableViewController {
            selectTVC.imageURL = imageURL
            selectTVC.imageName = imageName
            if let message = descriptionTextField.text {
            selectTVC.message = message
            }
        }
    }
    

}
