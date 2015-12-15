//
//  BadgesTableViewController.swift
//  KhanAcademyBadges
//
//  Created by Jimmy Yue on 12/14/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage

class BadgesTableViewController: UITableViewController {
    
    typealias badgeResponses = [NSDictionary]
    
    private let database = KhanDatabase()
    
    var disposeBag = DisposeBag()
    
    let url = "http://www.khanacademy.org/api/v1/badges/categories/"
    var jsonData: badgeResponses = []

    override func viewDidLoad() {
        
        // Unfortunate workaround
        let jsonUrl = "http://www.khanacademy.org/api/v1/badges/categories"
        
        let session = NSURLSession.sharedSession()
        let shotsUrl = NSURL(string: jsonUrl)
        
        let task = session.dataTaskWithURL(shotsUrl!) {
            (data, response, error) -> Void in
            
            do {
                let jsonArray = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSArray
                for item in jsonArray {
                    self.jsonData.append(item as! NSDictionary)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            } catch _ {
                return
            }
        }
        
        task.resume()
        
        // Doesn't get the expected response
//        database.rx_getBadgeCategories()
//            .subscribe(
//                onNext: { (jsonResp) -> Void in
//                    print(jsonResp)
//                },
//                onError: { (error) -> Void in
//                    print("Error: \(error)")
//                },
//                onCompleted: { () -> Void in
//                    print("Completed")
//                },
//                onDisposed: { () -> Void in
//                    
//            })
//            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (jsonData.count)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("badgeCell", forIndexPath: indexPath) as! BadgeTableViewCell
        // Check for data
        if jsonData != [] {
            let url = NSURL(string: String(self.jsonData[indexPath.row]["icon_src"]!))
            let badgeName = String(self.jsonData[indexPath.row]["type_label"]!)
            cell.badgeImageView!.sd_setImageWithURL(url)
            cell.badgeNameLabel.text = badgeName

        }

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.view.frame.height/6
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.reloadData()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    

}
