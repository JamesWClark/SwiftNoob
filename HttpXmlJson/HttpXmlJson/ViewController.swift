//
//  ViewController.swift
//  HttpXmlJson
//
//  Created by J.W. Clark on 10/25/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//
// possible source: http://www.theappguruz.com/blog/xml-parsing-using-nsxmlparse-swift
// actual source: http://ashishkakkad.com/2014/10/xml-parsing-in-swift-language-ios-9-nsxmlparser/

import UIKit

class ViewController: UIViewController {
    
    
    func doPost(url: String) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        //let postString = "id=13&name=Jack"
        //request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
    @IBOutlet weak var xmlLabel: UILabel!
    
    func someXmlFunction() {
        // https://mockoon.com/playground/
        let url:String = "https://mocktarget.apigee.net/xml"
        let urlToSend: URL = URL(string: url)!
        let parser = ApogeeXmlParser(url: urlToSend)
        xmlLabel.text = "City: \(parser.getCity()), First Name: \(parser.getFirstName()), Last Name: \(parser.getLastName()), State: \(parser.getState())"
    }
    
    @IBOutlet weak var ssLabel: UILabel!
    
    
    func sheetFunction() {
        let url = URL(string: "https://spreadsheets.google.com/feeds/list/1HiBELND_o4BxWCX249UFTJxQ17Vte56e2I7sf84mKjU/od6/public/values?alt=json")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyObject>
            
            let xmlns = json["feed"]!["xmlns"]!
            
            DispatchQueue.main.async(execute: {
                self.ssLabel.text = xmlns  as? String
            })
        }
        
        task.resume()
    }
    
    
    
    
    @IBOutlet weak var myLabel: UILabel!
    
    func someJsonFunction() {
        
        let url = URL(string: "https://httpbin.org/ip")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyObject>
            print(json["origin"]!)
            
            
            DispatchQueue.main.async(execute: {
                self.myLabel.text = "\(json["origin"]!)"
            })
        }
        
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        someXmlFunction()
        // someJsonFunction()
        // sheetFunction()
        // doPost(url: "http://posttestserver.com/post.php");
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
