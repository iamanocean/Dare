//
//  InprogressWorldViewController.swift
//  Dare
//
//  Created by Matthias Sainz on 4/18/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//


import UIKit

class InprogressWorldViewController: UIViewController {

    @IBOutlet weak var dareText: UILabel!
    @IBOutlet weak var dateAndLoc: UILabel!
    @IBOutlet weak var bountyPrefix: UILabel!
    @IBOutlet weak var attendingPrefix: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    @IBOutlet weak var attendingLabel: UILabel!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
   
    var dareId:String = ""
    var toProve:Bool = false
    
    override func viewDidLoad() {
        self.title = "In Progress"
        let font = UIFont(name: "BebasNeueBold", size: 38)
        if let font = font {
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor()]
        }
        
       
        loadData()
        
    }
        func loadData()
    {
        var q = PFQuery(className:"InprogressDares")
        q.getObjectInBackgroundWithId(self.dareId, block: {
            (object:PFObject!, error:NSError!) -> Void in
            if error == nil
            {
                self.toProve = object["attempterHasProof"] as Bool
                
                let descriptionFont = UIFont(name: "BebasNeueBook", size: 34)
                if let descriptionFont = descriptionFont {
                    self.dareText.text = object["DareText"] as? String
                    self.dareText.font = descriptionFont
                    self.dareText.textColor = UIColor(red: 0.325, green: 0.325, blue: 0.325, alpha: 1)
                }
                
                let dateFont = UIFont(name: "BebasNeueBold", size: 22)
                if let dateFont = dateFont {
                    self.dateAndLoc.text = (object["Date"] as String) + " @ " + (object["Location"] as String)
                    self.dateAndLoc.font = dateFont
                    self.dateAndLoc.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
                    
                    self.bountyLabel.text = String(object["Bounty"] as Int)
                    self.bountyLabel.font = dateFont
                    
                    self.attendingLabel.text = (!self.toProve) ? String(object["Attendees"] as Int) : String(object["UpVotes"] as Int)
                    self.attendingLabel.font = dateFont
                }
                
               (object["proofToConfirm"] as PFFile).getDataInBackgroundWithBlock({
                    (imageData:NSData!, error:NSError!) -> Void in
                    if( error == nil)
                    {
                        if let image = UIImage(data:imageData) {
                            dispatch_async(dispatch_get_main_queue()) {
                                self.imageView.image = image
                            }
                        }
                    }
                })//end image load
                
                
               let headerFont = UIFont(name: "BebasNeueRegular", size: 32)
                if let headerFont = headerFont {
                    self.bountyPrefix.text = "BOUNTY:"
                    self.bountyPrefix.font = headerFont
                    
                    self.attendingPrefix.text = (!self.toProve == true) ? "ATTENDING:" : "UP VOTES:"
                    self.attendingPrefix.font = headerFont
                }
               
                //true if need to vote false if need to attend
                if self.toProve
                {
                   self.userButton.setTitle("Up Vote", forState: UIControlState.Normal)
                }
                else
                {
                   self.userButton.setTitle("Attend", forState: UIControlState.Normal)
                }
                
            }
        })
    }
   
    //TODO prevent people from hitting the button in each state
    //more than once
    @IBAction func buttonPress()
    {
       if self.toProve
       {
         self.upVote()
       }
       else
       {
         self.attend()
       }
    }
    
    func upVote()
    {
       var q = PFQuery(className: "InprogressDares")
        q.getObjectInBackgroundWithId(self.dareId, block: {
            (dare:PFObject!, error:NSError!) -> Void in
            if( error == nil )
            {
               dare["UpVotes"] = (dare["UpVotes"] as Int) + 1
                dare.saveInBackgroundWithBlock({
                    (allGood:Bool!, error:NSError!) -> Void in
                    if !allGood
                    {
                        println("Save did not work")
                    }
                })
                let dateFont = UIFont(name: "BebasNeueBold", size: 22)
                if let dateFont = dateFont {
                    self.attendingLabel.text = String(dare["UpVotes"] as Int)
                    self.attendingLabel.font = dateFont
                }
                self.checkIfEnoughVotes(dare["UpVotes"] as Int, attended: dare["Attendees"] as Int)
            }
        })
    }
    
    func checkIfEnoughVotes(numVotes:Int, attended:Int)
    {
       //TODO come up with some fancy function based of time, votes, and number of attended
        //to determin if they won
       
        //winner
        if( numVotes > 5 )
        {
            var newCompleated = PFObject(className: "CompleatedDares")
            var q = PFQuery(className: "InprogressDares")
            q.getObjectInBackgroundWithId(self.dareId, block: {
                (dare:PFObject!, error:NSError!) -> Void in
                if error == nil
                {
                   //long list of vars to catch parse erros not 
                    //found if dare[] = otherDare[]
                    var name:String              = dare["Name"] as String
                    var dareText:String          = dare["DareText"] as String
                    var bounty:Int               = dare["Bounty"] as Int
                    var date:String              = dare["Date"]  as String
                    var location:String          = dare["Location"] as String
                    var locationGps:String       = dare["LocationGPS"] as String
                    var userAttempting:String    = dare["UserAttempting"] as String
                    var userAttemptingID:String  = dare["userAttemptingID"] as String
                    var attendees:Int            = dare["Attendees"] as Int
                    var upVotes:Int              = dare["UpVotes"] as Int
                    var proof:PFFile             = dare["proofToConfirm"] as PFFile
                    
                    newCompleated["Name"]              = name
                    newCompleated["DareText"]          = dareText
                    newCompleated["Bounty"]            = bounty
                    newCompleated["Date"]              = date
                    newCompleated["Location"]          = location
                    newCompleated["LocationGPS"]       = locationGps
                    newCompleated["User"]              = userAttempting
                    newCompleated["Attendees"]         = attendees
                    newCompleated["UpVotes"]           = upVotes
                    newCompleated["Proof"]             = proof
                    newCompleated["winnerID"]          = userAttemptingID
                    
                    newCompleated.saveInBackgroundWithBlock({
                        (allGood:Bool!, error:NSError!) -> Void in
                        if( !allGood )
                        {
                            println("Compleated Dare Craetion Failed")
                        }
                    })
                    
                    dare.deleteInBackgroundWithBlock({
                        (allGood:Bool!, error:NSError!) -> Void in
                        if !allGood
                        {
                            println("Failed to delete old in progress dare")
                        }
                    })
                    
                }
            })
        }
    }
    
    func attend()
    {
        var q = PFQuery(className: "InprogressDares")
        q.getObjectInBackgroundWithId(self.dareId, block: {
            (dare:PFObject!, error:NSError!) -> Void in
            if( error == nil )
            {
               dare["Attendees"] = (dare["Attendees"] as Int) + 1
                dare.saveInBackgroundWithBlock({
                    (allGood:Bool!, error:NSError!) -> Void in
                    if !allGood
                    {
                        println("Save did not work")
                    }
                })
                
                var userAttending: [String] = PFUser.currentUser()["attending"] as [String]
                userAttending.append(self.dareId)
                PFUser.currentUser()["attending"] = userAttending
                PFUser.currentUser().saveInBackgroundWithBlock({
                    (allGood:Bool!, error:NSError!) -> Void in
                    if( !allGood )
                    {
                       println("User attending list not updated")
                    }
                })
                
                let dateFont = UIFont(name: "BebasNeueBold", size: 22)
                if let dateFont = dateFont {
                    self.attendingLabel.text = String(dare["Attendees"] as Int)
                    self.attendingLabel.font = dateFont
                }
            }
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
