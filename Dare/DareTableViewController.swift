//
//  DareTableViewController.swift
//  Dare
//
//  Created by Louis Olivas on 3/24/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit


class DareTableViewCell: UITableViewCell {
    @IBOutlet weak var dareImage: UIImageView!
    @IBOutlet weak var dareTitleLabel: UILabel!
    @IBOutlet weak var dareLocationLabel: UILabel!
    @IBOutlet weak var dareUserLabel: UILabel!
    @IBOutlet weak var dareAttendeesLabel: UILabel!
    @IBOutlet weak var dareUpVotesLabel: UILabel!
    @IBOutlet weak var dareBountyLabel: UILabel!
    @IBOutlet weak var dareDateLabel: UILabel!
    @IBOutlet weak var dareShareButton: UIButton!
    @IBAction func didSelectShareButton(sender: AnyObject) {
 
    }
    func loadItem(#title: String, image: String, location: String, user: String, attendees: String, upVotes: String, bounty: String, date: String) {
        let font = UIFont(name: "BebasNeueRegular", size: 36)
        if let font = font {
            dareTitleLabel.font = font
        }
        let bebasBoldFont = UIFont(name: "BebasNeueBold", size: 26)
        if let bebasBoldFont = bebasBoldFont {
            dareLocationLabel.font = bebasBoldFont
            dareUserLabel.font = bebasBoldFont
            dareLocationLabel.textColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1)
            dareUserLabel.textColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1)
        }
        
        let helveticaFont = UIFont(name: "HelveticaNeue-Light", size: 20)
        if let helveticaFont = helveticaFont {
            dareDateLabel.font = helveticaFont
            dareAttendeesLabel.font = helveticaFont
            dareBountyLabel.font = helveticaFont
            dareUpVotesLabel.font = helveticaFont
            dareDateLabel.textColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            dareAttendeesLabel.textColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            dareBountyLabel.textColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            dareUpVotesLabel.textColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        }

        self.dareImage.image = UIImage(named: image)
        self.dareTitleLabel.text = title
        self.dareLocationLabel.text = location
        self.dareUserLabel.text = user
        self.dareAttendeesLabel.text = attendees
        self.dareUpVotesLabel.text = upVotes
        self.dareBountyLabel.text = bounty
        self.dareDateLabel.text = date;
        
        dareImage.contentMode = UIViewContentMode.ScaleAspectFill;
        dareImage.clipsToBounds = true;
    }

}




class DareTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    // temporary hardcoded array of images to set up table view
    var images: [String] = ["swift 1.jpg","swift 2.jpg","swift 3.jpg"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var nib = UINib(nibName: "DareTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "customCell")
        
        
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
/*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
*/
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return images.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: DareTableViewCell = tableView.dequeueReusableCellWithIdentifier("customCell") as DareTableViewCell
        
        cell.loadItem(title: "Horse Head", image: images[indexPath.row], location: "ECCR 200", user: "Rob_Davis", attendees: "100 People Attended", upVotes: "222", bounty: "320", date: formatDate(NSDate()))
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
