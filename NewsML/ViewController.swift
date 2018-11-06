//
//  ViewController.swift
//  NewsML
//
//  Created by Tallal Javed on 11/6/18.
//  Copyright © 2018 Tallal Javed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var urlDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func didTapOnAnalyzeButton(sender: UIButton){
        guard urlTextField.text != "" else{
            print("Enter url")
            return
        }
        
        guard UIApplication.shared.canOpenURL(URL(string: urlTextField.text!)!) else {
            print("invalid url")
            return
        }
        
        WebScrapper.sharedInstance.getTextFromURL(urlString: urlTextField.text!) { (text) in
            //print("category clsasfiied for url")
            let outputArray = MLManager.sharedInstance.classifyText(input: text)
            self.urlDescription.text = "URL Category: " + outputArray.0
            print(outputArray.1)
            
        }
    }
}
