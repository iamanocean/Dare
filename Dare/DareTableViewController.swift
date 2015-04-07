//
//  DareTableViewController.swift
//  Dare
//
//  Created by Louis Olivas on 3/24/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class DareTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    // temporary hardcoded array of images to set up table view
    var images: [String] = ["swift 1.jpg","swift 2.jpg","swift 3.jpg"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var completedDareNib: UINib = UINib(nibName: "CompletedDareTableViewCell", bundle: nil)
        var inProgressDareNib: UINib = UINib(nibName: "InProgressDareTableViewCell", bundle: nil)
        var challengedDareNib: UINib = UINib(nibName: "ChallengedDareTableViewCell", bundle: nil)
        
        tableView.registerNib(completedDareNib, forCellReuseIdentifier: "CompletedDare")
        tableView.registerNib(inProgressDareNib, forCellReuseIdentifier: "InProgressDare")
        tableView.registerNib(challengedDareNib, forCellReuseIdentifier: "ChallengedDare")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let font = UIFont(name: "BebasNeueRegular", size: 38)
        if let font = font {
            navigationController?.navigationBar.topItem?.title = "DARES"
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor()]
        }
        self.view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.956, alpha: 1)
    }

    /**
    :brief:     Helper function that returns a properly formatted date from an NSDate object
    :date:      The NSDate object to be formatted
    :return:    Returns the date in the format: Month Day, Year, Hour:Minute
    */
    func formatDate(date: NSDate) -> String {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMM dd YYYY HH:mm")
        let dateString: NSString = formatter.stringFromDate(date)
        return dateString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        
        
        /*
            This method needs to return the number of parse objects up in the cloud.
        */
        
        
        
        // Return the number of rows in the section.
        return images.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        var cell: CompletedDareTableViewCell = tableView.dequeueReusableCellWithIdentifier("CompletedDare") as CompletedDareTableViewCell
        
        cell.loadItem(title: "Horse Head", image: images[indexPath.row], location: "ECCR 200", user: "Rob_Davis", attendees: "100 People Attended", upVotes: "222", bounty: "320", date: formatDate(NSDate()))
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CompletedDareDetailViewController") as CompletedDareDetailViewController
        detailViewController.dare = Dare(title: "Hello", blankDescription: "Thing", date: NSDate(), elements: [["Hello"]])
        //detailViewController.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        //self.presentViewController(detailViewController, animated: true, completion: nil)
        self.performSegueWithIdentifier("showChallengedDetail", sender: nil)
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    //}


}
