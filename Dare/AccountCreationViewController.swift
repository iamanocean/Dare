//
//  AccountCreationViewController.swift
//  Dare
//
//  Created by Louis Olivas on 3/23/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
