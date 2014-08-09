//
//  SearchResultsViewController.swift
//  Padly
//
//  Created by Chew Lam on 7/12/14.
//  Copyright (c) 2014 null. All rights reserved.
//
//  http://jamesonquave.com/blog/developing-ios-8-apps-using-swift-interaction-with-multiple-views/
//


import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {

    @IBOutlet var appsTableView: UITableView
    var monsterCache: [Monster] = []
    @lazy var api: APIController = APIController(delegate: self)
    var imageCache = NSMutableDictionary()
    
    let kCellIdentifier: String = "SearchResultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        api.searchItunesFor("JQ Software")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return monsterCache.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
        
        let monster = self.monsterCache[indexPath.row]
        
        cell.textLabel.text = monster.name
        cell.imageView.image = UIImage(named: "Blank52")
        var urlString: NSString = monster.img40!
/*
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            var image: UIImage? = self.imageCache[urlString] as? UIImage
            if (!image) {
                var imgURL: NSURL = NSURL(string: urlString)

                // Download an NSData representation of the image at the URL
                let request: NSURLRequest = NSURLRequest(URL: imgURL)
                let urlConnection: NSURLConnection = NSURLConnection(request: request, delegate: self)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                    if !error? {
                        //var imgData: NSData = NSData(contentsOfURL: imgURL)
                        image = UIImage(data: data)
                        
                        // Store the image in to our cache
                        self.imageCache.setValue(image, forKey: urlString)
                        cell.imageView.image = image
                    }
                    else {
                        println("Error: \(error.localizedDescription)")
                    }
                })
            }
            else {
                cell.imageView.image = image
            }
        })
*/
        
        var detail = "HP \(monster.hp_max), ATK \(monster.atk_max), RCV \(monster.rcv_max), Cost \(monster.cost), \(monster.showFormattedRarity())"
        cell.detailTextLabel.text = detail
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        // Get the row data for the selected row
        var monster = monsterCache[indexPath.row]
        
        
/*
        var alert: UIAlertView = UIAlertView()
        alert.title = monster.name
        alert.message = monster.name
        alert.addButtonWithTitle("Ok")
        alert.show()
*/
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject) {
        var detailsViewController: DetailsViewController = segue.destinationViewController as DetailsViewController
        var index = appsTableView.indexPathForSelectedRow().row
        var monster = self.monsterCache[index]
        detailsViewController.monster = monster
    }

    func handleAPIResults(results: NSArray) {
        if results.count>0 {
            for result in results {
                var r = result as NSDictionary
                var newMonster = Monster()
                newMonster.load(r)
                monsterCache.append(newMonster)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.appsTableView.reloadData()
            })
        }
    }
    

}

