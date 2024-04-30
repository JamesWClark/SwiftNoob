//
//  ThirdViewController.swift
//  DataOverSegues
//
//  Created by J.W. Clark on 10/24/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var msg: String?
    
    @IBOutlet weak var txtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtField.text = msg
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let first = segue.destination as! MainViewController
        first.msg = txtField.text
    }

}
