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
                
                imageFolder.child("myPic.jpeg").putData(imageData, metadata: nil) { (metadata, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("Upload Complete")
                        self.performSegue(withIdentifier: "addImageToSelectUser", sender: nil)
                    }
                }
                
            }
            
            
        }
        
    }
    

}
