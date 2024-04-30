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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let third = segue.destination as! ThirdViewController
        third.msg = msg
    }
}
