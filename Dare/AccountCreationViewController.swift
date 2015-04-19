//
//  AccountCreationViewController.swift
//  Dare
//
//  Created by Louis Olivas on 3/23/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit
/**
Also nearly complete, needs some backend support
*/
class AccountCreationViewController: UIViewController {
    
    // View outlets
    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var newPasswordConfirmationField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup next buttons for email and new password text fields.
        emailAddressField.addTarget(newPasswordField, action: "becomeFirstResponder", forControlEvents: UIControlEvents.EditingDidEndOnExit)
        newPasswordField.addTarget(newPasswordConfirmationField, action: "becomeFirstResponder", forControlEvents: UIControlEvents.EditingDidEndOnExit)
        newPasswordConfirmationField.addTarget(self, action: "createNewAccount", forControlEvents: UIControlEvents.EditingDidEndOnExit)

        // Do any additional setup after loading the view.
        // Set titles for outlets
        createAccountLabel?.text = "CREATE AN ACCOUNT"
        
        /*
        Custom Typefaces are added as follows:
        1. Click and drag the typefaces to the sidebar to add them to the project
        2. Open up the plist and add a row for "Fonts provided by application"
        3. Add in all of the typefaces as new items
        4. Go to target > Build phases > Copy Bundle Resources and add all of the typefaces
        5. See below
        */
        let font = UIFont(name: "BebasNeueRegular", size: 48)
        if let font = font {
            createAccountLabel.font = font;
        }
        // Set up color scheme
        self.view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.956, alpha: 1)
        emailAddressField.backgroundColor = UIColor(red: 0.882, green: 0.874, blue: 0.874, alpha: 1)
        newPasswordField.backgroundColor = UIColor(red: 0.882, green: 0.874, blue: 0.874, alpha: 1)
        newPasswordConfirmationField.backgroundColor = UIColor(red: 0.882, green: 0.874, blue: 0.874, alpha: 1)
        // All other appearance setup is done through the storyboard.

    }

    
    
    
    /**
    :brief:     Overrode viewDidAppear to allow autohiding the keyboard
    :param:     animated        A boolean to indicate whether or not the views appearance is animated
    */
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapRecognizer)
    }

    
    
    
    /**
    :brief:     Helper method used to autohide the keyboard when a user taps on the screen
    :param:     recognizer      A UITapGestureRecognizer to respond to.
    */
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    /**
    :brief:     Incomplete function that Handles account creation, including verification 
                of credentials and backend functionality, additionally provides user with inital bounty
                to spend
    */
    func createNewAccount() {
        
        let successFullAccountCreationAlertView: UIAlertView = UIAlertView(title: "Account Created!", message: "You are being returned to the sign in screen", delegate: nil, cancelButtonTitle: "Cool!")
        
        if verifyCredentialsForEmail(emailAddressField.text, forPassword: newPasswordField.text, withConfirmationPassword: newPasswordConfirmationField.text) {
        // Go to the server and do magical things
            
        // ...
            
            var user:PFUser = PFUser()
            user.username = emailAddressField.text
            user.password = newPasswordField.text
            user.email = emailAddressField.text
            user["bounty"] = 200
            user["wins"]   = 0
            user["losses"] = 0
            user["attempting"] = []
            
            user.signUpInBackgroundWithBlock{
                (succeeded: Bool!, error: NSError!) -> Void in
                if error == nil {
                    successFullAccountCreationAlertView.show()
                } else {
                    // let errorString = error.userInfo["error"] as NSString
                    // Show the errorString somewhere and let the user try again.
                    // Not sure when this would return an error, we can add a
                    // handler later if we need/want to.
                }
            }
           
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    
    
    //////////////////////////Needs Completion///////////////////////////It would be neat if we could check for a valid email address, but otherwise it works as expected.
    /**
    :brief:     Verifies credentials for creation of a new account. Checks for matching 
                passwords, and the existence of the email address in the database
    :param:     userEmail                   The email address to create an account for
    :param:     forPassword                 The proposed password
    :param:     withConfirmationPassword    The verification password
    :return:                                Returns true on success, false otherwise
    */
    
    func verifyCredentialsForEmail(userEmail: String, forPassword password: String, withConfirmationPassword confirmPassword:String) -> Bool {
        // ReassignFirstResponder to avoid awkward UI issues
        self.newPasswordConfirmationField.resignFirstResponder()
        self.becomeFirstResponder()
        
        
        // Sets up the alert controllers using closures
        let passwordsDoNotMatchAlertView: UIAlertView = UIAlertView(title: "Passwords Did Not Match", message: "Please try again", delegate: nil, cancelButtonTitle: "OK")
        let accountIsAlreadyCreated: UIAlertController = UIAlertController(title: "Account is already created", message: "There is already an account for this email address.", preferredStyle: UIAlertControllerStyle.Alert)
        accountIsAlreadyCreated.addAction(
            UIAlertAction(title: "Log in", style: UIAlertActionStyle.Cancel, handler:
                { (_) -> Void in
                    self.dismissViewControllerAnimated(true , completion: nil)
                }
            )
        )
        accountIsAlreadyCreated.addAction(
            UIAlertAction(title: "Recover Password", style: UIAlertActionStyle.Destructive, handler:
                { (_) -> Void in
                    self.recoverPasswordForUser(userEmail)
                }
            )
        )
        
        if (password != confirmPassword) {
            passwordsDoNotMatchAlertView.show()
            return false;
        } else if (self.accountAlreadyExistsForEmail(userEmail)) {
            
            self.presentViewController(accountIsAlreadyCreated, animated: true, completion: nil)
            return false;
        }
        
        return true;
    }
    
    
    
    
    //////////////////////////Needs Completion///////////////////////////This needs to implemented from the ground up
    /**
    :brief:     Checks if an account for an email already exists
    :param:     userEmail       The email to be checked
    :return:    Returns true if an account already exists for userEmail, false otherwise
    */
    func accountAlreadyExistsForEmail(userEmail: String) -> Bool {
        return false;
    }
    
    
    
    
    //////////////////////////Needs Completion///////////////////////////Still needs to send an email, or at least let the server know, or something, I don't know.
    /**
    :brief:     Sends the user a password recovery email, and notifies them of this
    :param:     userEmail       The email to be notified
    */
    func recoverPasswordForUser(userEmail: String) {
        let emailSentAlert: UIAlertView = UIAlertView(title: "Password recovery email sent", message: "Please follow the link in your email to recover your password", delegate: nil, cancelButtonTitle: "Okay!")
        emailSentAlert.show()
        self.dismissViewControllerAnimated(true, completion: nil)
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
