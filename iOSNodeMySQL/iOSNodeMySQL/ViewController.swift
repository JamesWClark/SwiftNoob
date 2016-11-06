//
//  ViewController.swift
//  iOSNodeMySQL
//
//  Created by J.W. Clark on 10/23/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    

    func getPlainText() {
        
        let url = URL(string: "http://localhost:3000")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            guard let response = response else {
                print("Response is empty")
                return
            }
            
            print(data)
            print(response)
            
            let responseString = String(data: data, encoding: String.Encoding.utf8)
            
            DispatchQueue.main.async(execute: {
                self.lblMessage.text = responseString
            })
        }
        
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getPlainText()
    }
    
    func doPost(url: String, body: String) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        //let postString = "id=13&name=Jack"
        request.httpBody = body.data(using: .utf8)
        print(body.data(using: .utf8))
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    @IBAction func doSaveData(_ sender: UIButton) {
        let subject = "data=\(txtSubject.text!)"
        print("attempting to send \(subject)")
        //let description = tvDescription.text
        //let start = dpStartDate.date
        //let end = dpEndDate.date
        doPost(url: "http://localhost:3000/task", body: subject)
    }
    

}

