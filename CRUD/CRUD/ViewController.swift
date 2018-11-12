//
//  ViewController.swift
//  CRUD
//
//  Created by J.W. Clark on 11/5/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//

import Alamofire
import UIKit

class ViewController: UIViewController {
    
    let posturl = "http://localhost:3000/task"
    let geturl = "http://localhost:3000/task/1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func barGet(_ sender: UIBarButtonItem) {
        Alamofire.request(geturl , method: .get, encoding: JSONEncoding(options: [])).responseJSON { response in
            debugPrint(response)
        }
    }
    @IBAction func btnGet(_ sender: UIButton) {

    }
    
    @IBAction func btnPost(_ sender: UIButton) {
        let parameters: Parameters = [
            "foo": [1,2,3],
            "bar": [
                "baz": "qux"
            ]
        ]
        
        Alamofire.request(posturl , method: .post, parameters: parameters, encoding: JSONEncoding(options: [])).responseJSON { response in
            debugPrint(response)
        }

    }
    
    @IBAction func btnPut(_ sender: UIButton) {
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
    }
    
    
}

