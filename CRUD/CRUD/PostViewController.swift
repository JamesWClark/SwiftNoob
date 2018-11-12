//
//  PostViewController.swift
//  CRUD
//
//  Created by J.W. Clark on 11/6/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//

import Alamofire
import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var txtDescription: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnSend(_ sender: UIButton) {
        let url = "http://localhost:3000/task"

        let params: Parameters = [
            "subject" : txtSubject.text!,
            "description" : txtDescription.text!
        ]
        
        Alamofire.request(url , method: .post, parameters: params, encoding: JSONEncoding.default).responseString { response in
            if response.result.description == "FAILURE" {
                debugPrint("Failure")
            } else {
                self.txtSubject.text = ""
                self.txtDescription.text = ""
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
