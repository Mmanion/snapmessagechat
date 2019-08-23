//
//  SelectUserTableViewController.swift
//  snapmessagechat
//
//  Created by Matthew Manion on 8/23/19.
//  Copyright © 2019 Matthew Manion. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SelectUserTableViewController: UITableViewController {
    
    var emails : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            if let userDictionary = snapshot.value as? NSDictionary {
                if let email = userDictionary["email"] as? String {
                    self.emails.append(email)
                    self.tableView.reloadData()
                }
            }
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = emails[indexPath.row]
        
        return cell
    }

    

}
