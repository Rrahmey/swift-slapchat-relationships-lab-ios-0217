//
//  RecipientTableViewController.swift
//  SlapChat
//
//  Created by Raquel Rahmey on 3/16/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class RecipientTableViewController: UITableViewController {
    
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.generateTestData()
        store.fetchRecipientData()
        tableView.reloadData()
        print(store.recipients.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return store.recipients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipientCell", for: indexPath)
        let cellRecipient = store.recipients[indexPath.row]
        
        cell.textLabel?.text = cellRecipient.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMessage" {
            let destination = segue.destination as! TableViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let recipient = store.recipients[indexPath.row]
                if let messageArray = store.getMessagesFor(recipient: recipient) {
                    destination.message = messageArray
                }
            }
        }
    }
    
    
}
