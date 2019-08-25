//
//  AuthViewController.swift
//  snapmessagechat
//
//  Created by Matthew Manion on 8/23/19.
//  Copyright © 2019 Matthew Manion. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var loginMode = true
    
    @IBAction func topButtonTapped(_ sender: Any) {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                if loginMode {
                    // Login
                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                        if let error = error {
                            print(error)
                        } else {
                            self.performSegue(withIdentifier: "authToSnaps", sender: nil)
                        }
                    })
                } else {
                    // Sign Up
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if let error = error {
                            print(error)
                        } else {
                            if let user = user { Database.database().reference().child("users").child(user.uid).child("email").setValue(email)
                                self.performSegue(withIdentifier: "authToSnaps", sender: nil)
                            }
                        }
                    })
                }
            }
        }
    }
    
    
    @IBAction func bottomButtonTapped(_ sender: Any) {
        if loginMode {
            // Switch to Sign Up
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Login", for: .normal)
            loginMode = false
        } else {
            // Switch to Login
            topButton.setTitle("Login", for: .normal)
            bottomButton.setTitle("Create Account", for: .normal)
            loginMode = true
        }
    }
    
    
    
    
    
    
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Enter your Email Address", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your email here..."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let email = alert.textFields?.first?.text {
                Auth.auth().sendPasswordReset(withEmail: email) { (error) in }
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    
    
    
    // Dismissing Keyboard on tapped
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Dismissing Keyboard when return button pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    

}
