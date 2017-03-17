//
//  AddRecipientViewController.swift
//  SlapChat
//
//  Created by Raquel Rahmey on 3/17/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class AddRecipientViewController: UIViewController {

    @IBOutlet weak var nameBox: UITextField!
    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var phoneBox: UITextField!
    @IBOutlet weak var twitterBox: UITextField!
    
    var store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func enterButton(_ sender: Any) {
        guard let name = nameBox.text else {return}
        guard let email = emailBox.text else {return}
        guard let phone = phoneBox.text else {return}
        guard let twitter = twitterBox.text else {return}
        store.addRecipient(nameString: name, emailString: email, phoneNumberString: phone, twitterHandleString: twitter)
        dismiss(animated: true, completion: nil)

    }

    

}
