//
//  TableViewController.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//



import UIKit

class TableViewController: UITableViewController {
    
    var store = DataStore.sharedInstance
    var message = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        store.fetchData()
        tableView.reloadData()
    }
    

    @IBAction func doneWithScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return message.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)

        let eachMessage = message[indexPath.row]
        
        cell.textLabel?.text = eachMessage.content

        return cell
    }
    
}
