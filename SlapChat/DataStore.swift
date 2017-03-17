//
//  DataStore.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    var messages:[Message] = []
    var recipients:[Recipient] = []
    
    static let sharedInstance = DataStore()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SlapChat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data Fetching support
    
    
    
    func fetchData() {
        let context = persistentContainer.viewContext
        let messagesRequest: NSFetchRequest<Message> = Message.fetchRequest()
        
        do {
            messages = try context.fetch(messagesRequest)
            messages.sort(by: { (message1, message2) -> Bool in
                let date1 = message1.createdAt! as Date
                let date2 = message2.createdAt! as Date
                return date1 < date2
            })
        } catch let error {
            print("Error fetching data: \(error)")
            messages = []
        }
        
        if messages.count == 0 {
            generateTestData()
        }
    }
    
    
    func addMessage(messageString: String, recipientMain: Recipient ) {
        let context = persistentContainer.viewContext
        let message = Message(context: context)
        
        message.content = messageString
        message.recipient = recipientMain
        message.createdAt = NSDate()
        
        saveContext()
        fetchData()
    }
    // MARK: - Core Data generation of test data
    
    func generateTestData() {
        let context = persistentContainer.viewContext
        let recipientOne = addRecipient(nameString: "Raqrah", emailString: "rrahmey", phoneNumberString: "23456789", twitterHandleString: "rrahmey")
        
        let messageOne: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        
        messageOne.content = "Message 1"
        messageOne.createdAt = NSDate()
        messageOne.recipient = recipientOne
        
        
        let messageTwo: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        
        messageTwo.content = "Message 2"
        messageTwo.createdAt = NSDate()
        
        let messageThree: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        
        messageThree.content = "Message 3"
        messageThree.createdAt = NSDate()
        
        saveContext()
        fetchData()
        fetchRecipientData()
    }
    
    func addRecipient(nameString:String, emailString: String, phoneNumberString: String, twitterHandleString: String)-> Recipient {
        let context = persistentContainer.viewContext
        let recipient = Recipient(context: context)
        recipient.email = emailString
        recipient.twitterHandle = twitterHandleString
        recipient.name = nameString
        recipient.phoneNumber = phoneNumberString
        saveContext()
        fetchRecipientData()
        return recipient
        
    }
    
    func fetchRecipientData() {
        let context = persistentContainer.viewContext
        let recipientRequest: NSFetchRequest<Recipient> = Recipient.fetchRequest()
        do { try recipients = context.fetch(recipientRequest)
        }
        catch{
            
        }
    }
    
    func addMessageToRecipient( recipient: Recipient, message: Message) {
        recipient.addToMessage(message)
    }
    
    func getMessagesFor (recipient: Recipient) -> [Message]? {
        guard let message = recipient.message else { return nil }
        return message.allObjects as? [Message]
    }
    
}
