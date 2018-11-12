//
//  ViewController.swift
//  Geode
//
//  Created by J.W. Clark on 9/14/18.
//  Copyright © 2018 J.W. Clark. All rights reserved.
//

import UIKit
import GoogleSignIn
import Alamofire

class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblGivenName: UILabel!
    @IBOutlet weak var lblFamilyName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnSignIn: GIDSignInButton!
    @IBOutlet weak var btnSignOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // [START_EXCLUDE]
        

        NotificationCenter.default.addObserver(self,
           selector: #selector(ViewController.receiveToggleAuthUINotification(_:)),
           name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
           object: nil)
        
        // [END_EXCLUDE]
        
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
        
    }
    
    func toggleAuthUI() {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            // Signed in
            lblUserId.isHidden = false
            lblFullName.isHidden = false
            lblGivenName.isHidden = false
            lblFamilyName.isHidden = false
            lblEmail.isHidden = false
            btnSignIn.isHidden = true
            btnSignOut.isHidden = false
        } else {
            // Signed out
            lblUserId.isHidden = true
            lblFullName.isHidden = true
            lblGivenName.isHidden = true
            lblFamilyName.isHidden = true
            lblEmail.isHidden = true
            btnSignIn.isHidden = false
            btnSignOut.isHidden = true
        }
    }
    
    @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
        if notification.name.rawValue == "ToggleAuthUINotification" {
            self.toggleAuthUI()
            if notification.userInfo != nil {
                guard let user = notification.object as? GIDGoogleUser else { return }
                guard let userInfo = notification.userInfo as? [String:String] else { return }
                
                lblFullName.text = user.profile.name
                lblGivenName.text = user.profile.givenName
                lblFamilyName.text = user.profile.familyName
                lblEmail.text = user.profile.email
            }
        }
    }

    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        self.toggleAuthUI();
    }
}
