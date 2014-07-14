//
//  SearchResultsViewController.swift
//  Padly
//
//  Created by Chew Lam on 7/12/14.
//  Copyright (c) 2014 null. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var appsTableView: UITableView
    var tableData: NSArray = []
    let baseUrl = "https://www.padherder.com/";

    let _hp_max = "hp_max"
    let _atk_max = "atk_max"
    let _rcv_max = "rcv_max"
    let _cost = "team_cost"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchItunesFor("JQ Software")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")

        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
/*

        cell.textLabel.text = rowData["trackName"] as String
        
        // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
        var urlString: NSString = rowData["artworkUrl60"] as NSString
        
        // Get the formatted price string for display in the subtitle
        var formattedPrice: NSString = rowData["formattedPrice"] as NSString
        
        cell.detailTextLabel.text = formattedPrice
*/
        cell.textLabel.text = rowData["name"] as String
        var urlString: NSString = baseUrl + (rowData["image40_href"] as NSString)

        var imgURL: NSURL = NSURL(string: urlString)
        // Download an NSData representation of the image at the URL
        var imgData: NSData = NSData(contentsOfURL: imgURL)
        cell.imageView.image = UIImage(data: imgData)
        
        let rarity = String(count: (rowData["rarity"] as NSInteger), repeatedValue: Character("*"))
        
        var detail = "HP \(rowData[_hp_max]), ATK \(rowData[_atk_max]), RCV \(rowData[_rcv_max]), Cost \(rowData[_cost])"
        
        cell.detailTextLabel.text = detail
        
        return cell
    }

    func searchItunesFor(searchTerm: String) {
        
        // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
        var itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Now escape anything else that isn't URL-friendly
        var escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"

        urlPath = "\(baseUrl)api/monsters/"
        println(urlPath)
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
            var results = jsonResult
//            var results: NSArray = jsonResult["results"] as NSArray
            dispatch_async(dispatch_get_main_queue(), {
                self.tableData = results
                self.appsTableView.reloadData()
                })
            })
        task.resume()
    }
}

