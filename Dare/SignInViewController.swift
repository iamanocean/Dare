//
//  ViewController.swift
//  Dare
//
//  Created by Louis Olivas on 2/7/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    
    // View outlets
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var newAccountButton: UIButton!
    
    var fieldArray: NSArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //// CONSIDER DELETING
        // UITextFieldArray used for implementing keyboard's 'next' feature
        //fieldArray = [emailTextField, passwordTextField]
        
        // Setup next button for email text field.
        emailTextField.addTarget(passwordTextField, action: "becomeFirstResponder", forControlEvents: UIControlEvents.EditingDidEndOnExit)

        
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
    
    
    ////CONSIDER DELETING
    /*
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        println("I RAn")
        var didResign: Bool = textField.resignFirstResponder()
        if (!didResign) {
            return false;
        }
        
        var index: Int = self.fieldArray.indexOfObject(textField)
            if (index == NSNotFound || index + 1 == fieldArray.count) {
                return false;
            }
        var nextField: AnyObject = fieldArray.objectAtIndex(index + 1)
        nextField.becomeFirstResponder()
        
        return true;
    }*/
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

