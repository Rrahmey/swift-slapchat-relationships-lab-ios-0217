//
//  ViewController.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddMessageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var addMessageTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    var recipient = Recipient()
    
    var store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func saveMessageButtonTapped(_ sender: AnyObject) {
        let store = DataStore.sharedInstance
        let context = store.persistentContainer.viewContext
        let newMessage = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        newMessage.content = addMessageTextField.text
        newMessage.createdAt = NSDate()
        store.addMessageToRecipient(recipient: recipient, message: newMessage)
        store.saveContext()
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return store.recipients.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let cell = store.recipients[row]
        return cell.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        recipient = store.recipients[row]
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}

