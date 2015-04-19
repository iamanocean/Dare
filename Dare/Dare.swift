//
//  Dare.swift
//  Dare
//
//  Created by Ellie Daw on 4/19/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import Foundation


/**
:brief:     Shoddy implementation of the dare class, it's basically just a list of properties,
needs refinement.
*/


// Import this header into your Swift bridge header file to
// let Armor know that PFObject privately provides most of
// the methods for PFSubclassing.
//#import <Parse/PFObject+Subclass.h>


class Dare : PFObject, PFSubclassing {
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String! {
        return "Dare"
    }
}

//class Dare: NSObject {
//    var blankDescription: String
//    var title: String
//    var date: NSDate
//    var votes: [String]
//    var possibleElements: [[String]]
//    
//    init(title: String, blankDescription: String, date: NSDate, elements: [[String]]) {
//        self.title = title
//        self.blankDescription = blankDescription
//        self.date = date
//        self.possibleElements = elements
//        self.votes = []
//    }
//    override init() {
//        self.title = "Dare not found"
//        self.blankDescription = "Something went wrong, the Boese god did not permit this to happen"
//        self.date = NSDate()
//        self.possibleElements = [[":(",":(",":("],[":(",":(",":("],[":(",":(",":("]]
//        self.votes = []
//    }
//}