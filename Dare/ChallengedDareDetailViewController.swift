//
//  challengedDareDetailViewController.swift
//  Dare
//
//  Created by Louis Olivas on 3/26/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit
import MapKit

class ChallengedDareDetailViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    @IBOutlet weak var bountyCountLabel: UILabel!
    @IBOutlet weak var locationView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        self.title = "Challenged"
    
        let font = UIFont(name: "BebasNeueRegular", size: 38)
        if let font = font {
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor()]
        }
        
        let descriptionFont = UIFont(name: "BebasNeueBook", size: 34)
        if let descriptionFont = descriptionFont {
            descriptionLabel.text = "YOU WILL DELIVER A SMALL PIECE OF CHOCOLATE TO EVERY PROFESSOR IN THE ENGINEERING CENTER DRESSED AS SANTA CLAUS"
            descriptionLabel.font = descriptionFont
            descriptionLabel.textColor = UIColor(red: 0.325, green: 0.325, blue: 0.325, alpha: 1)
        }
        let headerFont = UIFont(name: "BebasNeueRegular", size: 32)
        if let headerFont = headerFont {
            bountyLabel.text = "BOUNTY:"
            bountyLabel.font = headerFont
        }
        
        
        let dateFont = UIFont(name: "BebasNeueBold", size: 22)
        if let dateFont = dateFont {
            dateLabel.text = "FEB 22 IN THE ENGINEERING CENTER @ 2:00 PM"
            dateLabel.font = dateFont
            dateLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            
            bountyCountLabel.text = "200"
            bountyCountLabel.font = dateFont
        }
        
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
