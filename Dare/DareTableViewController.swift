//
//  DareTableViewController.swift
//  Dare
//
//  Created by Louis Olivas on 3/24/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit


class DareElem
{
    var name:String             = ""
    var dareText:String         = ""
    var bounty:Int              = 0
    var date:String             = ""
    var location:String         = ""
    var locationGps:String      = ""
    var userId:String           = ""
    var attendees:Int           = 0
    var upVotes:Int             = 0
    var dareType:Int            = 0
    var proof:PFFile            = PFFile()
    
    init(name:String,
        dareText:String,
        bounty:Int,
        date:String,
        location:String,
        locationGps:String,
        userId:String,
        attendees:Int,
        upVotes:Int,
        proof:PFFile,
        dareType:Int)
    {
        self.name = name
        self.dareText = dareText
        self.date = date
        self.location = location
        self.locationGps = locationGps
        self.userId = userId
        self.attendees = attendees
        self.upVotes = upVotes
        self.dareType = dareType
        self.proof = proof
    }
}

let INCOMPLETE_TYPE:Int = 0
let INPROGRESS_TYPE:Int = 1
let FINISHED_TYPE:Int   = 2

class DareTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    // temporary hardcoded array of images to set up table view
    var images: [String] = ["swift 1.jpg","swift 2.jpg","swift 3.jpg"]
    
    var daresArr: [DareElem]! = []
        //stores all of the dares to be rendered by the list view
    
    
    override func viewDidLoad() {

        super.viewDidLoad()

        var completedDareNib:  UINib = UINib(nibName: "CompletedDareTableViewCell", bundle: nil)
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
        
        self.loadDares()
            //aquire dares to render from the server

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

    func loadDares()
    {
        var daresIncompleate = PFQuery(className:"CompleatedTemplateDares")
        
        daresIncompleate.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil
            {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject]
                {
                    for object in objects
                    {
                        self.daresArr.append(DareElem(
                            name: object["Name"] as String ,
                            dareText: object["DareText"] as String,
                            bounty: object["Bounty"] as Int,
                            date: object["Date"] as String,
                            location: object["Location"] as String,
                            locationGps: object["LocationGPS"] as String,
                            userId: "",
                            attendees: 0,
                            upVotes: 0,
                            proof: PFFile(),
                            dareType: INCOMPLETE_TYPE
                            )
                        )
                    }
                    self.tableView.reloadData()
                }
            }
            else
            {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }//end error check
        }//end find
        
        var daresInprogress = PFQuery(className: "InprogressDares")
        
            daresInprogress.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil
            {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject]
                {
                    for object in objects
                    {
                        self.daresArr.append(DareElem(
                            name: object["Name"] as String ,
                            dareText: object["DareText"] as String,
                            bounty: object["Bounty"] as Int,
                            date: object["Date"] as String,
                            location: object["Location"] as String,
                            locationGps: object["LocationGPS"] as String,
                            userId: object["UserAttempting"] as String,
                            attendees: object["Attendees"] as Int,
                            upVotes: object["UpVotes"] as Int,
                            proof: PFFile(),
                            dareType: INPROGRESS_TYPE
                            )
                        )
                    }
                    self.tableView.reloadData()
                }
            }
            else
            {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }//end error check
        }//end find
        
        var daresCompleate = PFQuery(className: "CompleatedDares")
        
            //TODO add proof photo upload
            daresCompleate.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil
            {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject]
                {
                    for object in objects
                    {
                        
                        self.daresArr.append(DareElem(
                            name: object["Name"] as String ,
                            dareText: object["DareText"] as String,
                            bounty: object["Bounty"] as Int,
                            date: object["Date"] as String,
                            location: object["Location"] as String,
                            locationGps: object["LocationGPS"] as String,
                            userId: object["User"] as String,
                            attendees: object["Attendees"] as Int,
                            upVotes: object["UpVotes"] as Int,
                            proof:  object["Proof"] as PFFile,
                            dareType: FINISHED_TYPE
                            )
                        )
                    }
                    self.tableView.reloadData()
                }
            }
            else
            {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }//end error check
        }//end find
        
    }//end load dares
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daresArr.count
            // Return the number of rows in the section.
    }//end tableView

    //Now were using stragity
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = UITableViewCell()
        
        switch daresArr[indexPath.row].dareType
        {
            case INCOMPLETE_TYPE:
               cell = getIncompleateCell(daresArr[indexPath.row])
            case INPROGRESS_TYPE:
               cell = getInprogressCell(daresArr[indexPath.row])
            case FINISHED_TYPE:
               cell = getFinishedCell(daresArr[indexPath.row])
            default:
                println("Error in table view cell creation")
        }
        
        return cell
    }//end table view
    
    func getIncompleateCell(dare:DareElem) -> UITableViewCell
    {
        var incompleateCell:ChallengedDareTableViewCell
        incompleateCell = tableView.dequeueReusableCellWithIdentifier("ChallengedDare") as ChallengedDareTableViewCell
        incompleateCell.loadItem(
            title: dare.name,
            location: dare.location,
            date: dare.date,
            bounty: String(dare.bounty)
        )
        
        return incompleateCell
    }
    
    func getInprogressCell(dare:DareElem) -> UITableViewCell
    {
        var inProgressCell:InProgressDareTableViewCell
        inProgressCell = tableView.dequeueReusableCellWithIdentifier("InProgressDare") as InProgressDareTableViewCell
        inProgressCell.loadItem(
            title: dare.name,
            location: dare.location,
            date: dare.date,
            bounty: String(dare.bounty)
        )
        return inProgressCell
    }
    
    func getFinishedCell(dare:DareElem) -> UITableViewCell
    {
        var finishedCell:CompletedDareTableViewCell
        finishedCell = tableView.dequeueReusableCellWithIdentifier("CompletedDare") as CompletedDareTableViewCell
        finishedCell.loadItem(
            title: dare.name,
            image: dare.proof,
            location: dare.location,
            user: dare.userId,
            attendees: String(dare.attendees),
            upVotes: String(dare.upVotes),
            bounty:String(dare.bounty),
            date: dare.date
        )
        
        return finishedCell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("InProgressDareDetailViewController") as InProgressDareDetailViewController
        //detailViewController.dare = Dare(title: "Hello", blankDescription: "Thing", date: NSDate(), elements: [["Hello"]])
        //detailViewController.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        //self.presentViewController(detailViewController, animated: true, completion: nil)
        self.performSegueWithIdentifier("showCompleatedDareDetail", sender: nil)
    }//end tableview

}//end class
