//
//  UserTableViewController.swift
//  Dare
//
//  Created by Matthias Sainz on 3/28/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController
{
    var test = ["Foo","Bar","Baz"]
    override func viewDidLoad() {
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.test.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        var t = test[indexPath.row]
        
        cell.textLabel?.text = t
        
        return cell
    }
}