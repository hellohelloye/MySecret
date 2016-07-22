//
//  MSPhoneContactsViewController.swift
//  MySecret
//
//  Created by Yukui Ye on 7/22/16.
//  Copyright © 2016 Yukui Ye. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class MSPhoneContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var contactsTableView: UITableView!
    var contacts = [CNContact]()
    var selectedItem: CNContact =  CNContact()
    
    
    func findContacts() -> [CNContact] {
        let store = CNContactStore()
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactImageDataKey, CNContactPhoneNumbersKey]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        var contacts = [CNContact]()
        
        do {
            try store.enumerateContactsWithFetchRequest(fetchRequest, usingBlock: { (let contact, let stop) -> Void in
                contacts.append(contact)
            })
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return contacts
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            self.contacts = self.findContacts()
            
            dispatch_async(dispatch_get_main_queue()) {
                self.contactsTableView!.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    // MARK: TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contactsTVC", forIndexPath:  indexPath)
        let contact = contacts[indexPath.row] as CNContact
        
        cell.textLabel?.text = "\(contact.givenName) \(contact.familyName)"
        cell.detailTextLabel?.text = "\(contact.phoneNumbers)"
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == "showContactDetailInfo" {
            let destination = segue.destinationViewController as? MSContactsDetailInfoViewController
            destination?.contact = self.contacts[(self.contactsTableView.indexPathForSelectedRow?.row)!]
        }
    }
}