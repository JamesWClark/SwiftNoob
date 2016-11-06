//
//  File.swift
//  CRUD
//
//  Created by J.W. Clark on 11/6/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//

import Foundation

class HTTP {
    
    private static func http(method: String, url: String, body: String) {
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
    
    static func put(url: String, body: String) {
        http(method: "PUT", url: url, body: body)
    }
    
    static func delete(url: String, body: String) {
        http(method: "DELETE", url: url, body: body)
    }
    
    static func post(url: String, body: String) {
        http(method: "POST", url: url, body: body)
    }
    
    static func get(url: String) {
        http(method: "GET", url: url, body: "")
    }
}
