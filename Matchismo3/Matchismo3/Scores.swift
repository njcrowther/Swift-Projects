//
//  Scores.swift
//  Matchismo3
//
//  Created by Nathan Crowther on 10/5/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import Foundation

class Scores : NSCoder {
    var points: NSNumber
    var endTime: NSDate
    var startTime: NSDate

    
    override init(){
        points = 0
        endTime = NSDate()
        startTime = NSDate()
    }
    
    required init(coder aDecoder: NSCoder) {
        if let newPoints = aDecoder.decodeObjectForKey("points") as? NSNumber {
            points = newPoints
        } else {
            points = 0
        }
        
        if let newEndTime = aDecoder.decodeObjectForKey("endTime") as? NSDate {
            endTime = newEndTime
        } else {
            endTime = NSDate()
        }
        
        if let newStartTime = aDecoder.decodeObjectForKey("startTime") as? NSDate {
            startTime = newStartTime
        } else {
            startTime = NSDate()
        }

        //store other date and calculate it when you need it
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(points, forKey: "points")
        aCoder.encodeObject(endTime, forKey: "endTime")
        aCoder.encodeObject(startTime, forKey: "startTime")
    }
    
    //get current date
    func getDate() -> NSDate {
        return endTime
    }
    
    func getPoints() -> NSNumber {
        return points
    }
    
    func gameInterval(startTime: NSDate, endTime: NSDate) -> NSTimeInterval {
        return 0
        
        //shortstyle
    }

    
}

//NSTimeInterval

