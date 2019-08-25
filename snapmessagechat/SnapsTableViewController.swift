//
//  SnapsTableViewController.swift
//  snapmessagechat
//
//  Created by Matthew Manion on 8/23/19.
//  Copyright © 2019 Matthew Manion. All rights reserved.

//  <div>Icons made by <a href="https://www.flaticon.com/authors/smashicons" title="Smashicons">Smashicons</a> from <a href="https://www.flaticon.com/"             title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/"             title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>

import UIKit
import Firebase
import FirebaseDatabase

class SnapsTableViewController: UITableViewController {
    
    var snaps : [DataSnapshot] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let uid = Auth.auth().currentUser?.uid {

        Database.database().reference().child("users").child(uid).child("snaps").observe(.childAdded) { (snapshot) in
            
                
                self.snaps.append(snapshot)
                self.tableView.reloadData()
                
            
             if let snapDictionary = snapshot.value as? NSDictionary {
                if let from = snapDictionary["from"] as? String {
                    if let imageName = snapDictionary["imageName"] as? String {
                        if let imageURL = snapDictionary["imageURL"] as? String {
                            if let message = snapDictionary["message"] as? String {
                                
                            }
                        }
                    }
                }
             }
            
            }
        
        }
        
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return snaps.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "snapsToView", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier2", for: indexPath)
        
        let snap = snaps[indexPath.row]
        
        if let snapDictionary = snap.value as? NSDictionary {
            if let from = snapDictionary["from"] as? String {
                cell.textLabel?.text = from
            }
        }
        
        return cell
    }

    
    
    
    
    

}
