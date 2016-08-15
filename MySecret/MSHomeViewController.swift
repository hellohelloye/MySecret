//
//  ViewController.swift
//  MySecret
//
//  Created by Yukui Ye on 7/22/16.
//  Copyright © 2016 Yukui Ye. All rights reserved.
//

import UIKit

class MSHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var msTableView: UITableView!
    var items: [String] = ["ACCESS PHONE CONTACTS","DISPLAY NEARBY BLUETOOTH", "Google SignIn", "Twitter SignIn"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("msHomeTVC")! as UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.row) {
        case 0:
            let contactsBookVC = self.storyboard!.instantiateViewControllerWithIdentifier("msPhoneContactsVC")
            self.navigationController!.pushViewController(contactsBookVC, animated: true)
            
            break
        case 1:
            let bluetoothVC = self.storyboard!.instantiateViewControllerWithIdentifier("msBluetoothVC")
            self.navigationController!.pushViewController(bluetoothVC, animated: true)
            
            break
        case 2:
            let googleVC = self.storyboard!.instantiateViewControllerWithIdentifier("msGoogleVC")
            self.navigationController!.pushViewController(googleVC, animated: true)
            
            break
        case 3:
            let twitterVC = self.storyboard!.instantiateViewControllerWithIdentifier("msTwitterVC")
            self.navigationController!.pushViewController(twitterVC, animated: true)
            
            break
        default:
            break
        }
    }
}

