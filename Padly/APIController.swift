//
//  APIController.swift
//  Padly
//
//  Created by Chew Lam on 7/13/14.
//  Copyright (c) 2014 null. All rights reserved.
//

import UIKit

protocol APIControllerProtocol {
    func handleAPIResults(results: NSArray)
}


class APIController: NSObject {
    var delegate: APIControllerProtocol?

    init(delegate: APIControllerProtocol?) {
        self.delegate = delegate
    }
    
    func searchItunesFor(searchTerm: String) {
        var urlPath = "\(Constants.url)api/monsters/"
        var url: NSURL = NSURL(string: urlPath)
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            println("Task completed")
            if(error) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray
            if(err?) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }

            self.delegate?.handleAPIResults(jsonResult)
        })
        task.resume()
    }
    
}
