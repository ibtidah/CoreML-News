//
//  WebScrapper.swift
//  NewsML
//
//  Created by Tallal Javed on 11/6/18.
//  Copyright © 2018 Tallal Javed. All rights reserved.
//

import UIKit
import Alamofire

class WebScrapper: NSObject {
    
    public static var sharedInstance = WebScrapper()
    
    private override init() {
        super.init()
    }
    
    // Gets all the text present within a url and 
    func getTextFromURL(urlString: String, completionHandler: @escaping (_ text: String) -> Void) {
        Alamofire.request(urlString).responseString { response in
            if let html = response.result.value {
                completionHandler(html)
            }
        }
    }
}
