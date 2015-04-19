//
//  InProgressDareDetailViewController.swift
//  Dare
//
//  Created by Louis Olivas on 3/26/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class InProgressDareDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var bountyLabel: UILabel!
    @IBOutlet weak var attendingLabel: UILabel!
    @IBOutlet weak var attendiesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bountyCountLabel: UILabel!
    
    var dareId:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "In Progress"
        let font = UIFont(name: "BebasNeueBold", size: 38)
        if let font = font {
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor()]
        }
        
        let headerFont = UIFont(name: "BebasNeueRegular", size: 32)
        if let headerFont = headerFont {
            bountyLabel.text = "BOUNTY:"
            bountyLabel.font = headerFont
            
            attendingLabel.text = "ATTENDING:"
            attendingLabel.font = headerFont
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
                let descriptionFont = UIFont(name: "BebasNeueBook", size: 34)
                if let descriptionFont = descriptionFont {
                    self.descriptionLabel.text = object["DareText"] as? String
                    self.descriptionLabel.font = descriptionFont
                    self.descriptionLabel.textColor = UIColor(red: 0.325, green: 0.325, blue: 0.325, alpha: 1)
                }
                
                let dateFont = UIFont(name: "BebasNeueBold", size: 22)
                if let dateFont = dateFont {
                    self.dateLabel.text = (object["Date"] as String) + " @ " + (object["Location"] as String)
                    self.dateLabel.font = dateFont
                    self.dateLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
                    
                    self.bountyCountLabel.text = String(object["Bounty"] as Int)
                    self.bountyCountLabel.font = dateFont
                    
                    self.attendiesLabel.text = String(object["Attendees"] as Int)
                    self.attendiesLabel.font = dateFont
                }
            }
        })
    }
    
    @IBAction func proveIt()
    {
       let incorrectCredentialsAlert: UIAlertController = UIAlertController(title: "Photo Upload", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
       var imageSelect = UIImagePickerController()
        imageSelect.delegate = self
        incorrectCredentialsAlert.addAction(
            UIAlertAction(title: "Use Camra", style: UIAlertActionStyle.Default, handler: {
                (_) -> Void in
                imageSelect.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(imageSelect, animated: true,  nil)
            })
        )
        
        incorrectCredentialsAlert.addAction(
            UIAlertAction(title: "Choose Photo", style: UIAlertActionStyle.Default, handler:
                {(_) -> Void in
                    imageSelect.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                    self.presentViewController(imageSelect, animated: true, nil)
                }
            )
        )
        self.presentViewController(incorrectCredentialsAlert, animated: true, completion: nil) 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    //TODO dont delte dare and instead render a new failure dare view so all can see the shame
    @IBAction func userDidSelectChickenOut(sender: AnyObject) {
    
        let alertController: UIAlertController = UIAlertController(title: "Are you sure?", message: "Really Though?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Bawk!", style: UIAlertActionStyle.Destructive, handler: { (_) -> (Void) in
            var q = PFQuery(className: "InprogressDares")
            q.getObjectInBackgroundWithId(self.dareId, block:{
                (dare:PFObject!, error:NSError!) -> Void in
                if error == nil
                {

                    
                    var userAttempting:[String] = PFUser.currentUser()["attempting"] as [String]
                    userAttempting = userAttempting.filter(){ $0 != self.dareId }
                    PFUser.currentUser()["attempting"] = userAttempting
                    
                    var userFailed:[String] = PFUser.currentUser()["failed"] as [String]
                    userFailed.append(dare["Name"] as String)
                    PFUser.currentUser()["failed"] = userFailed
                    
                    var currentLosses = PFUser.currentUser()["losses"] as Int + 1
                    PFUser.currentUser()["losses"] = currentLosses
                    
                    PFUser.currentUser().saveInBackgroundWithBlock({
                        (allGood:Bool!, error:NSError!) -> Void in
                        if !allGood
                        {
                            println("Failed to update user stats")
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
            let failViewController = self.storyboard?.instantiateViewControllerWithIdentifier("failViewController") as UIViewController
            self.presentViewController(failViewController, animated: true, completion: nil)
            //add dare to user fail and transition dare back to inprogress state
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        let imageData = UIImagePNGRepresentation(image)
        let imageFile = PFFile(name:"proof.png", data:imageData)
        
        var q = PFQuery(className: "InprogressDares")
        q.getObjectInBackgroundWithId(self.dareId, block: {
            (dare:PFObject!, error:NSError!) -> Void in
            if error == nil
            {
                dare["proofToConfirm"] = imageFile
                dare["attempterHasProof"] = true
                dare.saveInBackgroundWithBlock({
                    (allGood:Bool!, error:NSError!) -> Void in
                    if !allGood
                    {
                       println("Could not upload photo")
                    }
                    else
                    {

                    }
                })
            }
        })
        
        self.dismissViewControllerAnimated(true, completion: {
        (_) -> Void in
            let alertController: UIAlertController = UIAlertController(title: "Photo is Uploading", message: "It may take a moment for your proof to apear in the list", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        })

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
