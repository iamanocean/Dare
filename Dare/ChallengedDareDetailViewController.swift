//
//  challengedDareDetailViewController.swift
//  Dare
//
//  Created by Louis Olivas on 3/26/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit
import MapKit

class ChallengedDareDetailViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    @IBOutlet weak var bountyCountLabel: UILabel!
    @IBOutlet weak var locationView: MKMapView!
    
    
    var dareId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        self.title = "Challenged"
    
        let font = UIFont(name: "BebasNeueRegular", size: 38)
        if let font = font {
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor()]
        }
        

        let headerFont = UIFont(name: "BebasNeueRegular", size: 32)
        if let headerFont = headerFont {
            bountyLabel.text = "BOUNTY:"
            bountyLabel.font = headerFont
        }
        
        loadDare()
        
    }
    
    func loadDare()
    {
       var challengeDare = PFQuery(className: "CompleatedTemplateDares")
        challengeDare.getObjectInBackgroundWithId(self.dareId, {
            (dare:PFObject!, error:NSError!) -> Void in
            if error == nil && dare != nil
            {
               self.setData(dare)
            }
        })
    }
    
    func setData(dare:PFObject)
    {
        let descriptionFont = UIFont(name: "BebasNeueBook", size: 34)
        if let descriptionFont = descriptionFont {
            descriptionLabel.text = dare["DareText"] as? String
            descriptionLabel.font = descriptionFont
            descriptionLabel.textColor = UIColor(red: 0.325, green: 0.325, blue: 0.325, alpha: 1)
        }
        
        let dateFont = UIFont(name: "BebasNeueBold", size: 22)
        if let dateFont = dateFont {
            dateLabel.text = (dare["Date"] as? String)! + " @ " + (dare["Location"] as? String)!
            dateLabel.font = dateFont
            dateLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            
            bountyCountLabel.text = String(dare["Bounty"] as Int)
            bountyCountLabel.font = dateFont
        }
    }
    
    @IBAction func addBounty()
    {
       getAndSetUserFunds(true)
    }
    
    @IBAction func subBounty()
    {
       getAndSetUserFunds(false)
    }
    
    @IBAction func acceptDare()
    {
        acceptCheck()
    }
    
    func acceptCheck()
    {
        
        let incorrectCredentialsAlert: UIAlertController = UIAlertController(title: "Are you sure", message: "Like really sure????", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        incorrectCredentialsAlert.addAction(
            UIAlertAction(title: "Nope", style: UIAlertActionStyle.Cancel, handler: nil))
        
        incorrectCredentialsAlert.addAction(
            UIAlertAction(title: "I'm In", style: UIAlertActionStyle.Destructive, handler:
                {(_) -> Void in
                    self.updateDareStatus()
                }
            )
        )
        self.presentViewController(incorrectCredentialsAlert, animated: true, completion: nil)
    }
    
    func updateDareStatus()
    {
        var newInprogressDare = PFObject(className: "InprogressDares")
        
        var d = PFQuery(className: "CompleatedTemplateDares")
        d.getObjectInBackgroundWithId(self.dareId, {
            (dObject: PFObject!, error:NSError!) -> Void in
            if( error == nil )
            {
                
                var name:String         = dObject["Name"] as String
                var dareText:String     = dObject["DareText"] as String
                var bounty:Int          = dObject["Bounty"] as Int
                var date:String         = dObject["Date"] as String
                var location:String     = dObject["Location"] as String
                var locationGps:String  = dObject["LocationGPS"] as String
                var userName:String     = PFUser.currentUser()["username"] as String
                
                newInprogressDare["Name"]           = name
                newInprogressDare["DareText"]       = dareText
                newInprogressDare["Bounty"]         = bounty
                newInprogressDare["Date"]           = date
                newInprogressDare["Location"]       = location
                newInprogressDare["LocationGPS"]    = locationGps
                newInprogressDare["UserAttempting"] = userName
                newInprogressDare["Attendees"]      = 0
                newInprogressDare["UpVotes"]      = 0
                
                dObject.deleteInBackgroundWithBlock({
                    (r:Bool!, error:NSError!) -> Void in
                    if( !r )
                    {
                        println("Faield")
                    }
                })
                newInprogressDare.saveInBackgroundWithBlock({
                    (r:Bool!, error:NSError!) -> Void in
                    if( !r )
                    {
                        println("Faield")
                    }
                })
                
                var userAttempting:[String] = PFUser.currentUser()["attempting"] as [String]
                userAttempting.append(newInprogressDare.objectId)
                PFUser.currentUser()["attempting"] = userAttempting
                PFUser.currentUser().saveInBackgroundWithBlock({
                    (r:Bool!, error:NSError!) -> Void in
                        if( error == nil)
                        {
                        }//end error user svaing
                        else
                        {
                            println("Error saving user info")
                        }
                })
                
                self.goBack()
                
            }
            else
            {
                println("...")
            }
        })
        
    }
    
    func goBack()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }

    func getAndSetUserFunds(add:Bool)
    {
        var currentUser = PFUser.currentUser()
        
        if currentUser["bounty"] as Int > 0
        {
            currentUser["bounty"] = (currentUser["bounty"] as Int) - 1
            PFUser.currentUser().saveInBackgroundWithBlock({
                (r:Bool!, error:NSError!) -> Void in
                if( error != nil)
                {
                   println("Failed to save user info")
                }
            })
            if add
            {
                updateDareBounty(1)
            }
            else
            {
                updateDareBounty(-1)
            }
        }
        else
        {
            let alertController: UIAlertController = UIAlertController(title: "Warning", message: "You are Broke", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func updateDareBounty(amount:Int)
    {
        var d = PFQuery(className: "CompleatedTemplateDares")
        d.getObjectInBackgroundWithId(self.dareId, {
            (dObject: PFObject!, error:NSError!) -> Void in
            if( error == nil )
            {
                dObject["Bounty"] = (dObject["Bounty"] as Int) + amount
                
                dObject.saveInBackgroundWithBlock({
                    (r:Bool!, error:NSError!) -> Void in
                    if( error != nil)
                    {
                        println("Failed to save")
                    }
                })
                
               let dateFont = UIFont(name: "BebasNeueBold", size: 22)
                if let dateFont = dateFont {
                    
                    self.bountyCountLabel.text = String(dObject["Bounty"] as Int)
                    self.bountyCountLabel.font = dateFont
                }
                
                
            }//end error check
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
