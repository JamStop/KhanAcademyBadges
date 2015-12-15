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
    
    
    //        let actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0, 80, 80)) as UIActivityIndicatorView
    //        actInd.center = self.view.center
    //        actInd.hidesWhenStopped = true
    //        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
    //        self.view.addSubview(actInd)
    //        actInd.startAnimating()
    
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
                
                print(String(self.jsonData[0]["icon_src"]))
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            } catch _ {
                return
            }
        }
        
        task.resume()
        
        // Doesn't get the expected response haha
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
        print(jsonData.count)
        return (jsonData.count)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("badgeCell", forIndexPath: indexPath) as! BadgeTableViewCell
        
        print(indexPath.row)
        
        if jsonData != [] {
//            print(self.jsonData[0])
//            print(NSURL(fileURLWithPath: String(self.jsonData[indexPath.row]["icon_src"])))
//            cell.badgeImageView!.sd_setImageWithURL(NSURL(fileURLWithPath: String(self.jsonData[indexPath.row]["icon_src"])))
            
            cell.badgeImageView!.image = UIImage(named: "test")
            

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
    

}
