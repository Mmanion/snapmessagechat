//
//  SnapsTableViewController.swift
//  snapmessagechat
//
//  Created by Matthew Manion on 8/23/19.
//  Copyright © 2019 Matthew Manion. All rights reserved.

//  <div>Icons made by <a href="https://www.flaticon.com/authors/smashicons" title="Smashicons">Smashicons</a> from <a href="https://www.flaticon.com/"             title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/"             title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>

import UIKit
import Firebase 

class SnapsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    
    
    
    

}
