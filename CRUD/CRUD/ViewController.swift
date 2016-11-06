//
//  ViewController.swift
//  CRUD
//
//  Created by J.W. Clark on 11/5/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let posturl = "http://localhost:3000/task"
        let geturl = "http://localhost:3000/task/1"
        
        HTTP.post(url: posturl, body: "")
        HTTP.get(url: geturl)
        HTTP.put(url: geturl, body: "")
        HTTP.delete(url: geturl, body: "")
    }

}

