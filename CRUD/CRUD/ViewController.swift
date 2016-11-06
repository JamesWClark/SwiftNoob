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
        
        post(url: posturl, body: "")
        get(url: geturl)
        put(url: geturl, body: "")
        delete(url: geturl, body: "")
    }
    
    func http(method: String, url: String, body: String) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method
        request.httpBody = body.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("response = \(responseString)")
        }
        task.resume()
    }
    
    func put(url: String, body: String) {
        http(method: "PUT", url: url, body: body)
    }

    func delete(url: String, body: String) {
        http(method: "DELETE", url: url, body: body)
    }
    
    func post(url: String, body: String) {
        http(method: "POST", url: url, body: body)
    }
    
    func get(url: String) {
        let url = URL(string: url)
        
        let task = URLSession.shared.dataTask(with: url!) {
            data, response, error in
            
            guard error == nil else {
                print(error)
                return
            }
            
            guard let data = data else {
                print("data is empty")
                return
            }
            
            print(data)
            print(response)
            
            let responseString = String(data: data, encoding: String.Encoding.utf8)
            print("get = \(responseString)")
        }
        task.resume()
    }
}

