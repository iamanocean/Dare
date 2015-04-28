//
//  CompletedDareTableViewCell.swift
//  Dare
//
//  Created by Louis Olivas on 3/25/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class CompletedDareTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var upVotesLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    @IBOutlet weak var attendeesLabel: UILabel!
    @IBOutlet weak var dareImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBAction func didSelectShareButton(sender: UIButton) {
    }
    
    
    
    /**
    :brief:         Function that prepares the TableViewCell for Drawing
                    All parameters are expected to be strings
    :param:         title       The title of the dare
    :param:         image       The name of the file that contains the image to be used
    :param:         user        The name of the user for the dare
    :param:         attendees   The number of attendees for the dare
    :param:         upVotes     The number of upVotes for the dare
    :param:         bounty      The amount of bounty for the dare
    :param:         date        The date that the dare will occur.
    */
    func loadItem(#title: String, image: PFFile, location: String, user: String, attendees: String, upVotes: String, bounty: String, date: String) {
        let font = UIFont(name: "BebasNeueRegular", size: 36)
        if let font = font {
            titleLabel.font = font
        }
        let bebasBoldFont = UIFont(name: "BebasNeueBold", size: 26)
        if let bebasBoldFont = bebasBoldFont {
            locationLabel.font = bebasBoldFont
            userLabel.font = bebasBoldFont
            locationLabel.textColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1)
            userLabel.textColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1)
        }
        
        let helveticaFont = UIFont(name: "BebasNeueRegular", size: 20)
        if let helveticaFont = helveticaFont {
            dateLabel.font = helveticaFont
            attendeesLabel.font = helveticaFont
            bountyLabel.font = helveticaFont
            upVotesLabel.font = helveticaFont
            dateLabel.textColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            attendeesLabel.textColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            bountyLabel.textColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            upVotesLabel.textColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        }
        
        image.getDataInBackgroundWithBlock({
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
        titleLabel.text = title
        locationLabel.text = location
        userLabel.text = user
        attendeesLabel.text = attendees
        upVotesLabel.text = upVotes
        bountyLabel.text = bounty
        dateLabel.text = date;
        shareButton.setTitle("Share", forState: UIControlState.Normal)
        shareButton.titleLabel?.font = helveticaFont;
        
        dareImageView.contentMode = UIViewContentMode.ScaleAspectFill;
        dareImageView.clipsToBounds = true;
        
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
