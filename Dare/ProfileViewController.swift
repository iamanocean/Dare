//
//  ProfileViewController.swift
//  Dare
//
//  Created by Louis Olivas on 3/23/15.
//  Edited by Matthias Sainz 3/38/2015
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var userDareTable: UITableView!
    
    /*
     *
     */
    @IBOutlet weak var userBounty: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userBountyCount: UILabel!
    @IBOutlet weak var userWon: UILabel!
    @IBOutlet weak var userWonCount: UILabel!
    @IBOutlet weak var userLost: UILabel!
    @IBOutlet weak var userLostCount: UILabel!
    
    
    /*
     * Buttons for viewing different dares relative to the user
     */
    @IBOutlet weak var attendingButton: UIButton!
    @IBOutlet weak var pendingButton: UIButton!
    @IBOutlet weak var wonButton: UIButton!
    @IBOutlet weak var lostButton: UIButton!
    
    var currentUser = PFUser.currentUser()
    
    var dareArray:NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        self.userDareTable.rowHeight = UITableViewAutomaticDimension
        self.userDareTable.estimatedRowHeight = 44.0
        fontConfig()
        
        
        let font = UIFont(name: "BebasNeueBold", size: 32)
        if let font = font {
            userBounty.font = font
            userName.font = font
            userWon.font = font
            userLost.font = font
        }
        
        
        self.loadUserStats()
        

    }
    
      // Set title, colors, and typefaces see SignInViewController for detailed description
    func fontConfig()
    {
        let font = UIFont(name: "BebasNeueRegular", size: 38)
        if let font = font {
            navigationController?.navigationBar.topItem?.title = "PROFILE"
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor()]
        }
        self.view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.956, alpha: 1)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.userDareTable.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = self.dareArray.objectAtIndex(indexPath.row) as? String
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dareArray.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUserStats()
    {
        var currentUser = PFUser.currentUser()
        
        userName.text   = currentUser.username
        userBounty.text = "Bounty:"
        userWon.text    = "Won:"
        userLost.text   = "Lost:"

        //TODO fix userWonCount and Bounty count to point to correct lables
        userWonCount.text = String(currentUser["bounty"] as Int)
        userBountyCount.text  = String(currentUser["wins"] as Int)
        userLostCount.text   = String(currentUser["losses"] as Int)
        
    }
    
    func loadAttendingDares()
    {
        
    }
    
    func loadPendingDares()
    {
        
    }
    
    func loadWonDares()
    {
        
    }
    
    func LoadLostDares()
    {
        
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
