//
//  MainViewController.swift
//  DataOverSegues
//
//  Created by J.W. Clark on 10/24/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var txtMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let second = segue.destination as! SecondViewController
        second.msg = txtMessage.text
    }

}
