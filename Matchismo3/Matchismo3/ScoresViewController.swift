//
//  ScoresViewController.swift
//  Matchismo3
//
//  Created by Nathan Crowther on 10/3/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import UIKit

class ScoresViewController: UIViewController {
    //Read scores here
    let userDefaults = NSUserDefaults.standardUserDefaults()
   
    @IBOutlet weak var scoreDisplay: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(userDefaults.dictionaryRepresentation())")
        
        if let data = userDefaults.objectForKey("scoreKey") as? NSData {
            let unarc = NSKeyedUnarchiver(forReadingWithData: data)
            let scoreArray = unarc.decodeObjectForKey("root") as! [Scores]
            
            scoreDisplay.text = ""
            
            for score in scoreArray {
                let points = score.points
                let endTime = score.endTime
                let startTime = score.startTime
                
                // var interval = gameInterval(startTime, endTime)
                print("Points: \(points), StartTime: \(startTime), \(endTime)")
                scoreDisplay.text! += "Score: \(points), \(startTime), \(endTime) \n"
            }
        } else {
            scoreDisplay.text = "No Scores"
        }
        //scoreDisplay.text = "Hello World"
    }
    
    
    
//    @IBAction func displayData() {
//        
//        
//
//    }
    

}
/*
class MyObject {
    var x: Int
    var y: Int
    var z: Int

    func toPropertyList() -> [String] {
        return [" \(x) \(y) \(z)"]
    }
    
    init() {
        x = 0
        y = 1
        z = 2
    }
    convenience init(string: String) { //convenience
        self.init()

        let parts = string.componentsSeparatedByString(" ")
        
        if let convertedValue = Int(parts[0]) {
            x = convertedValue
        }


        y = Int(parts[1])!
    
    //swift convert string to int
    }
}

var myObjects = [STring]()
myObjects.append(MyObject())
var obj1 = MyObject()

property List slide "More Swift - Day 5"

print(myObjects.first!)
obj1.fromString("5 6 7")
print("Obj1: \(obj1)")

encode/decode

NSUserDefaults.standardUserDefaults().synchronize() /.removeObjectforKey("history")
*/