//
//  CompletedDareDetailViewController.swift
//  Dare
//
//  Created by Louis Olivas on 3/25/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class CompletedDareDetailViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bountyHeader: UILabel!
    @IBOutlet weak var attendedHeader: UILabel!
    @IBOutlet weak var conqueredHeader: UILabel!
    @IBOutlet weak var upVotesLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    @IBOutlet weak var attendeesLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dareImage: UIImageView!
    var dare: Dare?
    
    var dareId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "COMPLETED"
        let font = UIFont(name: "BebasNeueRegular", size: 38)
        if let font = font {
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor()]
        }

        let descriptionFont = UIFont(name: "BebasNeueBold", size: 27)
        if let descriptionFont = descriptionFont {
            descriptionLabel.text = "YOU WILL WEAR A HORSE MASK AND GO ABOUT YOUR NORMAL BUSINESS"
            descriptionLabel.font = descriptionFont
            descriptionLabel.textColor = UIColor(red: 0.325, green: 0.325, blue: 0.325, alpha: 1)
        }
        
        let dateFont = UIFont(name: "BebasNeueBold", size: 18)
        if let dateFont = dateFont {
            dateLabel.text = "FEB 12 2015 IN THE ENGINEERING CENTER @ 2:00 PM"
            dateLabel.font = dateFont
            dateLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        }
        
        let headerFont = UIFont(name: "BebasNeueBold", size: 32)
        if let headerFont = headerFont {
            bountyHeader.text = "BOUNTY:"
            bountyHeader.font = headerFont
            
            attendedHeader.text = "ATTENDED:"
            attendedHeader.font = headerFont
            
            conqueredHeader.text = "CONQUERED BY:"
            conqueredHeader.font = headerFont
        }
        
        let labelFont = UIFont(name: "BebasNeueBold", size: 23)
        if let labelFont = labelFont {
            attendeesLabel.font = labelFont
            attendeesLabel.text = "198 PEOPLE"
            
            userLabel.font = labelFont
            userLabel.text = "ROB_DAVIS"
        }
        
        dareImage.image = UIImage(named: "swift 2.jpg")
        println(dareId)
        // Do any additional setup after loading the view.
    }
    
    /**
    :brief:         This function gets the dare for the appropraite  
    */
    
    

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
