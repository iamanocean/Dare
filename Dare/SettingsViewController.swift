//
//  SettingsViewController.swift
//  Dare
//
//  Created by Louis Olivas on 3/24/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var deleteAccountButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "SETTINGS"
        let font = UIFont(name: "BebasNeueRegular", size: 38)
        if let font = font {
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor()]
        }
        let buttonFont = UIFont(name: "BebasNeueBold", size: 32)
        if let buttonFont = buttonFont {
            logOutButton.setTitle("LOG OUT", forState: .Normal)
            logOutButton.titleLabel?.font = buttonFont
            logOutButton.contentHorizontalAlignment = .Center;
            deleteAccountButton.setTitle("DELETE ACCOUNT :(", forState: .Normal)
            deleteAccountButton.titleLabel?.font = buttonFont
            deleteAccountButton.contentHorizontalAlignment = .Center
        }
    }

    @IBAction func didPushLogOut(sender: AnyObject) {
        
    }
    @IBAction func didPushDeleteAccount(sender: AnyObject) {
        let accountDeletionAlertController: UIAlertController = UIAlertController(title: "Account Deletion", message: "Are you sure you want to delete your account?", preferredStyle: UIAlertControllerStyle.Alert)
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
