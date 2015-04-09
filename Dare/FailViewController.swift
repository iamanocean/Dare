//
//  FailViewController.swift
//  Dare
//
//  Created by Louis Olivas on 4/7/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class FailViewController: UIViewController {
    @IBOutlet weak var failLabel: UILabel!

    @IBOutlet weak var goHomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let recoginzer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "userDidTap")
        recoginzer.numberOfTapsRequired = 1;
        self.view.addGestureRecognizer(recoginzer)
        // Do any additional setup after loading the view.
        
        let font = UIFont(name: "BebasNeueBold", size: 72)
        if let font = font {
            failLabel.font = font
            failLabel.text = "FAIL"
        }
        
        let subfont = UIFont(name: "BebasNeueLight", size: 42)
        if let subfont = subfont {
            goHomeLabel.font = subfont
            goHomeLabel.text = "GO HOME IN SHAME"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userDidTap() {
        println("ran")
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
