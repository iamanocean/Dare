//
//  InProgressDareTableViewCell.swift
//  Dare
//
//  Created by Louis Olivas on 3/25/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class InProgressDareTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    @IBOutlet weak var dareImageView: UIImageView!

    

    
    /**
    :brief:         Function that prepares the TableViewCell for Drawing
    All parameters are expected to be strings
    :param:         title       The title of the dare
    :param:         location    The location of the dare
    :param:         date        The date that the dare will occur.
    :param:         bounty      The amount of bounty for the dare
    */
    func loadItem(#title: String, location: String, date: String, bounty: String, pfImage:PFFile) {
        
        let font = UIFont(name: "BebasNeueRegular", size: 36)
        if let font = font {
            titleLabel.font = font
            titleLabel.text = title
        }
        
        let helveticaFont = UIFont(name: "HelveticaNeue-Light", size: 20)
        if let helveticaFont = helveticaFont {
            locationLabel.text = location
            locationLabel.font = helveticaFont
            
            bountyLabel.text = bounty
            bountyLabel.font = helveticaFont
            bountyLabel.textColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)

            dateLabel.font = helveticaFont
            dateLabel.text = date
            dateLabel.textColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        }

        self.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.3)
        pfImage.getDataInBackgroundWithBlock({
            (imageData:NSData!, error:NSError!) -> Void in
            if( error == nil)
            {
                if let image = UIImage(data:imageData) {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.dareImageView.image = image
                    }
                }
            }
        })
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
