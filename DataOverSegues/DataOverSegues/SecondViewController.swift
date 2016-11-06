//
//  SecondViewController.swift
//  DataOverSegues
//
//  Created by J.W. Clark on 10/24/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var msg: String?

    @IBOutlet weak var lblMessage: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        lblMessage.text = msg
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
