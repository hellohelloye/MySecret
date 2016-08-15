//
//  MSTwitterViewController.swift
//  MySecret
//
//  Created by Yukui Ye on 8/15/16.
//  Copyright © 2016 Yukui Ye. All rights reserved.
//

import UIKit
import OAuthSwift

class MSTwitterViewController: UIViewController {
    
    @IBOutlet var twitterTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TwitterAPIsConnection()
    }
    
    final func TwitterAPIsConnection() {
        let oauthswift = OAuth1Swift(
            consumerKey:    "aPcxoI9yxE8vCxl2U05Oz5a0K",
            consumerSecret: "XMgTn4PYxj1imDzMopI7dYTza0pkaFr0HBUxtLBctaAD4CzUmj",
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
        )
        oauthswift.authorizeWithCallbackURL(
            NSURL(string: "oauth-swift://oauth-callback/twitter")!,
            success: { credential, response, parameters in
                print("_______Twitter credential.oauth_token: /(credential.oauth_token)")
                print("_______Twitter credential.oauth_token_secret: /credential.oauth_token_secret)")
                print(parameters["user_id"]!)
                
                self.twitterTextView.text = "Twitter Account: \(credential), \(parameters)"
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
    }
    
    final func afterSendingData(success:Bool) -> Void {
        if success {
            print("Data sent")
        }
        else {
            print("Data not sent")
        }
    }
}
