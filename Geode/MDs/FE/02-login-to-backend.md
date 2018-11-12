Previously we wrote this code to gather information about logged in users.

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
                userInfo: ["statusText": "Signed in user:\n\(fullName)"]
            )
        }
    }

Modify it so that we send a record of the login to our back end through the web server.

Of course, for this to work, you'll have to import Alamofire. This goes at the top of your code along with the other imports.

    import Alamofire

Next, in terminal, get the IP address of your computer.

    ifconfig

You should see a result that looks something like this:

    lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 16384
        options=1203<RXCSUM,TXCSUM,TXSTATUS,SW_TIMESTAMP>
        inet 127.0.0.1 netmask 0xff000000 
        inet6 ::1 prefixlen 128 
        inet6 fe80::1%lo0 prefixlen 64 scopeid 0x1 
        nd6 options=201<PERFORMNUD,DAD>
    gif0: flags=8010<POINTOPOINT,MULTICAST> mtu 1280
    stf0: flags=0<> mtu 1280
    XHC20: flags=0<> mtu 0
    en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
        ether f4:5c:89:b5:7d:15 
        inet6 fe80::c1:71d5:c1a8:6bd0%en0 prefixlen 64 secured scopeid 0x5 
        inet6 2605:a601:2064:b700:cf3:6733:3a49:39f7 prefixlen 64 autoconf secured 
        inet6 2605:a601:2064:b700:c8aa:bdb3:9bae:ffe9 prefixlen 64 autoconf temporary 
        inet 192.168.1.146 netmask 0xffffff00 broadcast 192.168.1.255
        nd6 options=201<PERFORMNUD,DAD>
        media: autoselect
        status: active

The part we're interested in is under `en0:` by `inet`. It should be an ipv4 address of the form 10.10.X.X where the X's are part of your IP number.

In fact, you need to send this login to your backend, so actually you will need their IP address. That, or you need their code from GitHub and your IP address.

Either way, wherever you plan to send it, that address needs to be specified in code and targeted with Alamofire as such:

    let parameters: Parameters = [
        "userId" : user!.userID!,
        "idToken" : user!.authentication.idToken!,
        "fullName" : user!.profile.name!,
        "givenName" :user!.profile.givenName!,
        "familyName" :user!.profile.familyName!,
        "email" : user!.profile.email!,
        "imageUrl" : user!.profile.imageURL(withDimension: 64)!
    ]
            
    Alamofire.request("http://10.10.X.X:3000/user", method: .post, parameters: parameters)

The idea is to create a key value pair map of the Google login information, then send that to a web server using HTTP Post method.

To test this, your back end guy needs to have finished his task, and the database guy needs to have created the table.