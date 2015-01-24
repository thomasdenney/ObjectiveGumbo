//
//  ViewController.swift
//  iOS Demo
//
//  Created by Thomas Denney on 16/10/2014.
//  Copyright (c) 2014 Programming Thomas. All rights reserved.
//

import UIKit
import ObjectiveGumbo

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Download data from BBC News
        let urlSession = NSURLSession.sharedSession()
        let url = NSURL(string: "http://news.bbc.co.uk")
        let request = NSURLRequest(URL: url)
        let dataTask = urlSession.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            let document = ObjectiveGumbo.parseDocumentWithData(data, encoding: NSUTF8StringEncoding)
            println(document.html())
        })
        dataTask.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

