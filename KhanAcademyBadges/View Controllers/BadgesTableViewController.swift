//
//  BadgesTableViewController.swift
//  KhanAcademyBadges
//
//  Created by Jimmy Yue on 12/14/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import UIKit

class BadgesTableViewController: UITableViewController {

    override func viewDidLoad() {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)


        return cell
    }
    
    // MARK: - Table view delegate
    
//    override func table

}
