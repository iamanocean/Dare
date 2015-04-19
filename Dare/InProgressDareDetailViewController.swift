//
//  InProgressDareDetailViewController.swift
//  Dare
//
//  Created by Louis Olivas on 3/26/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class InProgressDareDetailViewController: UIViewController {
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
        
        let descriptionFont = UIFont(name: "BebasNeueBook", size: 34)
        if let descriptionFont = descriptionFont {
            descriptionLabel.text = "YOU WILL POGO STICK THROUGH LIZ'S LECTURE YELLING THE BRITISH ARE COMING DRESSED AS SACAGAWEA"
            descriptionLabel.font = descriptionFont
            descriptionLabel.textColor = UIColor(red: 0.325, green: 0.325, blue: 0.325, alpha: 1)
        }

        let headerFont = UIFont(name: "BebasNeueRegular", size: 32)
        if let headerFont = headerFont {
            bountyLabel.text = "BOUNTY:"
            bountyLabel.font = headerFont
            
            attendingLabel.text = "ATTENDING:"
            attendingLabel.font = headerFont
        }
        
        let dateFont = UIFont(name: "BebasNeueBold", size: 22)
        if let dateFont = dateFont {
            dateLabel.text = "MAR 13 IN ECCR 200 @ 2:00 PM"
            dateLabel.font = dateFont
            dateLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            
            bountyCountLabel.text = "200"
            bountyCountLabel.font = dateFont
            
            attendiesLabel.text = "129 People"
            attendiesLabel.font = dateFont
        }
        // Do any additional setup after loading the view.
        println(dareId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userDidSelectChickenOut(sender: AnyObject) {
    
        let alertController: UIAlertController = UIAlertController(title: "Are you sure?", message: "Really Though?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Bawk!", style: UIAlertActionStyle.Destructive, handler: { (_) -> (Void) in
            let failViewController = self.storyboard?.instantiateViewControllerWithIdentifier("failViewController") as UIViewController
            self.presentViewController(failViewController, animated: true, completion: nil)
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
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
