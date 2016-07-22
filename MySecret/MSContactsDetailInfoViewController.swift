//
//  MSContactsDetailInfoViewController.swift
//  MySecret
//
//  Created by Yukui Ye on 7/22/16.
//  Copyright © 2016 Yukui Ye. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class MSContactsDetailInfoViewController: UIViewController {
    var contact: CNContact = CNContact()
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       textView.text = "\(contact)"
    }
}