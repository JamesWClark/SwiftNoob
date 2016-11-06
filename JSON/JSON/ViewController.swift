//
//  ViewController.swift
//  JSON
//
//  Created by J.W. Clark on 10/28/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var people: NSArray = []
    var peopleIndex = 0
    
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var email: UILabel!
    
    func getSheet(url: String) {
        let url = URL(string: url)
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error)
                return
            }
            
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json =
                try! JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyObject>
            
            //callback(json)
            self.people = json["feed"]!["entry"] as! NSArray
            self.uiPump()
        }
        
        task.resume()
    }
    
    func uiPump() {
        let person = people[peopleIndex] as! Dictionary<String, AnyObject>
        let fname = person["gsx$firstname"]!["$t"]!
        let lname = person["gsx$lastname"]!["$t"]!
        let email = person["gsx$email"]!["$t"]!
        
        // instantly update the UI
        DispatchQueue.main.async(execute: {
            self.firstname.text = fname  as? String
            self.lastname.text = lname as? String
            self.email.text = email as? String
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let sheet = "https://spreadsheets.google.com/feeds/list/1QaEp58fpTaxBkHT0BPlAOQ_HxL7K5epRo1Uv_ajIGDw/od6/public/values?alt=json"
        getSheet(url: sheet)
    }
    
    @IBAction func btnPrev(_ sender: UIButton) {
        if peopleIndex == 0 {
            peopleIndex = people.count - 1
        } else {
            peopleIndex -= 1
        }
        print(peopleIndex)
        uiPump()
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        if peopleIndex == people.count - 1 {
            peopleIndex = 0
        } else {
            peopleIndex += 1
        }
        print(peopleIndex)
        uiPump()
    }
    
    
}
