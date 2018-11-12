-

# Create a Signin Splash Screen

Add an image file to **xcassets**

Add an **Image View** to the storyboard

Under the **Attributes Inspector**, set the image in the view, set **Content Mode** to **Aspect Fit**

Previously we added a **View** for the Google Signin button.

Center it below the **Image View**

![Imgur](https://i.imgur.com/P4kapSC.png)

Run the iOS Simulator. We should see a result like this

![Imgur](https://i.imgur.com/djaFP5i.png)

Add a **Button** to the storyboard.

Double click and change its text to **Sign Out**

In the **Attributes Inspector** find the **Drawing** section.

Check the box next to **Hidden**. We only want this option available while actually signed in.

Also add labels for

* userId
* fullName
* givenName
* familyName
* email

Hide these as well.

In fact, add a label and a placeholder for each, like this:

![Imgur](https://i.imgur.com/W8TebAj.png)

Create **Outlets** for the label placeholders, the empty ones, not the text filled ones

Create an **Outlet** for the logo image view.

![Imgur](https://i.imgur.com/Fj7yd2j.png)

Create an **Action** for the **Sign Out** button.

In the action, sign out the Google user

    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }

At this point, you should be able to sign in successfully.

After one successful sign in, you have to sign out before the sign in will work again.

## Modify AppDelegate.swift

Modify the disconnect handler

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
            withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "ToggleAuthUINotification"),
            object: nil,
            userInfo: ["statusText": "User has disconnected."])
    }

Modify the sign in handler

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            let imageUrl = user.profile.imageURL(withDimension: 64)
            
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"),
                object: user,
                userInfo: ["statusText": "Signed in user:\n\(fullName)"])
        }
    }

## Modify ViewController.swift

Create a function, **toggleAuthUi**

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

In the view controller, we listen for broadcast notifications from **AppDelegate**.

In the **viewDidLoad** method, add this observer

    NotificationCenter.default.addObserver(self,
        selector: #selector(ViewController.receiveToggleAuthUINotification(_:)),
        name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
        object: nil)

Finally, create the **receiveToggleAuthUINotification** function

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

Run the iOS Simulator and test that your login and logout work to update the UI

![Imgur](https://i.imgur.com/DvyoPec.png)