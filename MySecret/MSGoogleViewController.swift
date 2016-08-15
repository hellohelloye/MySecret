//
//  MSGoogleViewController.swift
//  MySecret
//
//  Created by Yukui Ye on 8/15/16.
//  Copyright © 2016 Yukui Ye. All rights reserved.
//

import UIKit

@objc(MSGoogleViewController)
class MSGoogleViewController : UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet var gDisconnect: UIButton!
    @IBOutlet var gSignIn: GIDSignInButton!
    @IBOutlet var gSignOut: UIButton!
    @IBOutlet var gStatusText: UILabel!
    
    
    // [START viewdidload]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // [START_EXCLUDE]
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(receiveToggleAuthUINotification(_:)),
                                                         name: "ToggleAuthUINotification",
                                                         object: nil)
        
        gStatusText.text = "Initialized Swift app..."
        toggleAuthUI()
        // [END_EXCLUDE]
    }
    
    // [END viewdidload]
    
    // [START signout_tapped]
    @IBAction func didTapSignOut(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        // [START_EXCLUDE silent]
        gStatusText.text = "Signed out."
        toggleAuthUI()
        // [END_EXCLUDE]
    }
    // [END signout_tapped]
    
    // [START disconnect_tapped]
    @IBAction func didTapDisconnect(sender: AnyObject) {
        GIDSignIn.sharedInstance().disconnect()
        // [START_EXCLUDE silent]
        gStatusText.text = "Disconnecting."
        // [END_EXCLUDE]
    }
    // [END disconnect_tapped]
    
    // [START toggle_auth]
    func toggleAuthUI() {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
            // Signed in
            gSignIn.hidden = true
            gSignOut.hidden = false
            //  gDisconnect.hidden = false
            
            
            GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.login")
            GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.me")
            
            //https://www.googleapis.com/plus/v1/people/me/people/visible?access_token=%@
            //https://developers.google.com/+/web/api/rest/latest/people/list
            //105779931779249054517
            //ya29.Ci86A9FspxhOCVwDHIRIgtYWbzC7Nf5nh9nT3PSFdo4LjUWsOTAkBhjubW0kmSjhQA
            
            
        } else {
            gSignIn.hidden = false
            gSignOut.hidden = true
            //  gDisconnect.hidden = true
            gStatusText.text = "Google Sign in\niOS Demo"
        }
    }
    // [END toggle_auth]
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: "ToggleAuthUINotification",
                                                            object: nil)
    }
    
    @objc func receiveToggleAuthUINotification(notification: NSNotification) {
        if (notification.name == "ToggleAuthUINotification") {
            self.toggleAuthUI()
            if notification.userInfo != nil {
                let userInfo:Dictionary<String,String!> =
                    notification.userInfo as! Dictionary<String,String!>
                self.gStatusText.text = userInfo["statusText"]
            }
        }
    }
}