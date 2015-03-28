//
//  DareCreationViewController.swift
//  Dare
//
//  Created by Louis Olivas on 3/23/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit


/**
:brief:     Shoddy implementation of the dare class, it's basically just a list of properties,
            needs refinement.
*/

class Dare: NSObject {
    var blankDescription: String
    var title: String
    var date: NSDate
    var votes: [String]
    var possibleElements: [[String]]
    
    init(title: String, blankDescription: String, date: NSDate, elements: [[String]]) {
        self.title = title
        self.blankDescription = blankDescription
        self.date = date
        self.possibleElements = elements
        self.votes = []
    }
    override init() {
        self.title = "Dare not found"
        self.blankDescription = "Something went wrong, the Boese god did not permit this to happen"
        self.date = NSDate()
        self.possibleElements = [[":(",":(",":("],[":(",":(",":("],[":(",":(",":("]]
        self.votes = []
    }
}



class DareCreationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var darePickerView: UIPickerView!
    var dare: Dare?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dare = Dare()
        pullDare()
        
        
        // Do any additional setup after loading the view.
        
        
        // Set title, colors, and typefaces see SignInViewController for detailed description
        self.title = "CREATE"
        let font = UIFont(name: "BebasNeueRegular", size: 38)
        if let font = font {
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor()]
        }
        let titleFont = UIFont(name: "BebasNeueRegular", size: 56)
        if let titleFont = titleFont {
            titleLabel.font = titleFont;
        }
        let descriptionFont = UIFont(name: "BebasNeueBold", size: 32)
        if let descriptionFont = descriptionFont {
            descriptionLabel.font = descriptionFont;
            descriptionLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        }
        let dateFont = UIFont(name: "BebasNeueBold", size: 14)
        if let dateFont = descriptionFont {
            dateLabel.font = descriptionFont;
            dateLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        }
        
        
        // Set the data source and delegate for the class.
        self.darePickerView.dataSource = self
        self.darePickerView.delegate = self
        

        // hardcoded, ignore, needs to be deleted and improved.
        if let dare = dare {
            titleLabel.text = dare.title
            descriptionLabel.text = dare.blankDescription
            dateLabel.text = formatDate(dare.date)
        }
        //
    }
    
    /**
    :brief:     Incomplete function for pulling a dare from the cloud. Presently just hardcodes a dare
                When completed, should pull dare, and if that fails produce a UI alertView explaining why
    */
    func pullDare() {
        dare = Dare(title: "Serenade", blankDescription: "You will serenade A_______ In ________________            and give them ___________.", date: NSDate(), elements: [["professor","student","janitor","staff member"], ["Engineering","Duane","The C4C"], ["Chocolate","Roses","A Rubber Ducky"]])
    }
    
    /**
    :brief:     Incomplete function used for upvoting a certain dare, right now just prints
                the title of the dare to the console
    :param:     element     The element that was voted for.
    */
    func voteForElement(element: String) {
        println(element)
    }
    
    
    /**
    :brief:     Helper function that returns a properly formatted date from an NSDate object
    :date:      The NSDate object to be formatted
    :return:    Returns the date in the format: Month Day, Year, Hour:Minute
    */
    func formatDate(date: NSDate) -> String {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMM dd YYYY HH:mm")
        let dateString: NSString = formatter.stringFromDate(date)
        return dateString
    }

    
    
    
    /**
    :brief:     Implemented as part of the UIPickerViewDelegate interface. Currently dares only
                support three columns of madlibs data. Four is too messy
    :param:     pickerView      The pickerView to be operated on
    :return:    Returns the number of columns to draw in the picker view
    */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if let dare = dare {
            return dare.possibleElements.count;
        } else {
            return 1
        }
    }
    
    
    
    
    
    /**
    :brief:     Implemented as part of the UIPickerViewDelegate interface. Sets the number of
                rows per component
    :param:     pickerView                  The pickerView to be operated on
    :param:     numberOfRowsInComponent     The component to set the number of rows for
    :return:    Returns the number of rows for the specified component
    */
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let dare = dare {

            switch component {
            case 0:
                return dare.possibleElements[component].count
            case 1:
                return dare.possibleElements[component].count
            case 2:
                return dare.possibleElements[component].count
            default:
                return 1;
            }
        } else {
            return 1;
        }
    }
    
    
    
    
    
    /**
    :brief:     Sets the data for the specified row at the specified component and formats each label
    :param:     pickerView      The pickerView to be operated on
    :param:     viewForRow      The row to set the view for
    :param:     forComponent    The column in which the view resides
    :param:     reusingView     The view object used to draw each row
    :return:    Retuns a UILabel object that defines how the text should be formatted.
    */
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var pickerLabel: UILabel = UILabel()
        pickerLabel.font = UIFont(name: "BebasNeueRegular", size: 20)
        pickerLabel.textAlignment = NSTextAlignment.Left
        
        if let dare = dare {

            switch component {
            case 0:
                pickerLabel.text = dare.possibleElements[component][row]
                return pickerLabel
            case 1:
                pickerLabel.text = dare.possibleElements[component][row]
                return pickerLabel
            case 2:
                pickerLabel.text = dare.possibleElements[component][row]
                return pickerLabel
            default:
                pickerLabel.text = ":("
                return pickerLabel
            }
        } else {
            pickerLabel.text = ":("
            return pickerLabel
        }
    }
    
    
    
    
    /**
    :brief:     Implemented as part of the UIPickerViewDelegateProtocol, votes for the selected element.
                This function is not yet complete. Be aware that the UIPickerView will call this method
                every single time one of the components is moved, as such, it is important that vote for
                dare only store the most recent vote.
    :param:     pickerView      The pickerView to take input from
    :param:     didSelectRow    The row for the element
    :param:     inComponent     The component for the elemnt
    */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let dare = dare {
            voteForElement(dare.possibleElements[component][row])
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
