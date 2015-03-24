//
//  DareTabBarViewController.swift
//  Dare
//
//  Created by Louis Olivas on 3/23/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class DareTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Set title, colors, and typefaces see SignInViewController for detailed description
        self.view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.956, alpha: 1)
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
