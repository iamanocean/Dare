//
//  ViewController.swift
//  Dare
//
//  Created by Louis Olivas on 2/7/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit
/**
This view controller is nearly complete in terms of front end development, back end still needs implementation
*/
class SignInViewController: UIViewController {

    
    // View outlets
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var newAccountButton: UIButton!
    
    var fieldArray: NSArray = NSArray()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up 'next' button for emailTextField. Set up 'go' button for passwordTextField
        emailTextField.addTarget(passwordTextField, action: "becomeFirstResponder", forControlEvents: UIControlEvents.EditingDidEndOnExit)

        passwordTextField.addTarget(self, action: "signIn", forControlEvents: UIControlEvents.EditingDidEndOnExit)
        
        // Do any additional setup after loading the view, typically from a nib.
        // Set titles for outlets
        signInLabel.text? = "SIGN IN"
        newAccountButton.setTitle("I don't have an account.", forState: UIControlState.Normal)
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
            signInLabel.font = font;
        }
        
        // Set up color scheme
        self.view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.956, alpha: 1)
        emailTextField.backgroundColor = UIColor(red: 0.882, green: 0.874, blue: 0.874, alpha: 1)
        passwordTextField.backgroundColor = UIColor(red: 0.882, green: 0.874, blue: 0.874, alpha: 1)
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
    
    
    
    
    /**
    :brief:     Incomplete function that handles signing in to the application
    */
    func signIn() {
        
        
        
        let passwordRecoveryNecessary: Bool = false;
        if verifyCredentialsForEmail(emailTextField.text, withPassword: passwordTextField.text) {
            let mainViewController: DareTabBarViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DareTabBarViewController") as DareTabBarViewController
            self.presentViewController(mainViewController, animated: true, completion: nil)
            
        } else {
            let incorrectCredentialsAlert: UIAlertController = UIAlertController(title: "Incorrect Credentials", message: "Incorrect email or password provided", preferredStyle: UIAlertControllerStyle.ActionSheet)

            incorrectCredentialsAlert.addAction(
                UIAlertAction(title: "Try Again.", style: UIAlertActionStyle.Cancel, handler: nil))
            
            incorrectCredentialsAlert.addAction(
                UIAlertAction(title: "Recover Password", style: UIAlertActionStyle.Destructive, handler:
                    {(_) -> Void in
                        self.sendPasswordRecoveryForEmail(self.emailTextField.text, withPassword: self.passwordTextField.text)
                    }
                )
            )
            self.presentViewController(incorrectCredentialsAlert, animated: true, completion: nil)
        }
    }
    
    
    
    
    /**
    :brief:     Incomplete Function that verifies a user's credentials for signing in
    :return:    Returns true if sign is successful, false otherwise
    */
    func verifyCredentialsForEmail(userEmail: String, withPassword userPassword: String) -> Bool {
        var verified = false;
        PFUser.logInWithUsernameInBackground(userEmail, password:userPassword) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                verified = true
            } else {
                // The login failed. Check error to see why.
            }
        }
        return verified;
    }
    
    
    
    
    /**
    :brief:     Function that handles password recovery
    :param:     userEmail       The email of the user in question
    :param:     withPassword    The matching user's password
    */
    func sendPasswordRecoveryForEmail(userEmail: String, withPassword password: String) {
        let emailSentAlert: UIAlertView = UIAlertView(title: "Password recovery email sent", message: "Please follow the link in your email to recover your password", delegate: nil, cancelButtonTitle: "Okay!")
        emailSentAlert.show()
    }
    


    @IBAction func userDidAskToCreateNewAccount(sender: UIButton) {
        
        let modalAccountCreationViewController: AccountCreationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AccountCreationViewController") as AccountCreationViewController
        self.presentViewController(modalAccountCreationViewController, animated: true, completion: nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

