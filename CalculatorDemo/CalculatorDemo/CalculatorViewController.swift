//
//  CalculatorViewController.swift
//  CalculatorDemo
//
//  Created by Nathan Crowther on 9/9/15.
//  Copyright (c) 2015 Nathan Crowther. All rights reserved.
//

import UIKit

class CalculatorViewController : UIViewController{

    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var stackDisplay: UILabel!
    
    var brain = CalculatorBrain()
    
    private var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
       
        if userIsInTheMiddleOfTypingANumber{
            if(sender.currentTitle != "."){
                display.text = display.text! + digit
            }
            else if(display.text!.rangeOfString(".") == nil) {
                display.text = display.text! + digit
            }
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func delete() {
        if(display.text!.characters.count > 1){
            display.text! = String(display.text!.characters.dropLast())
        }
        else {
            display.text = "0"   
        }

    }
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        
        if let result = brain.pushOperand(displayValue!){
            displayValue = result
            stackDisplay.text = brain.descriptionOfTopOfStack
        } else {
            displayValue = 0
            stackDisplay.text = brain.descriptionOfTopOfStack
        }
    }
 
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
                stackDisplay.text = brain.descriptionOfTopOfStack
                
            } else {
                displayValue = 0
                stackDisplay.text = brain.descriptionOfTopOfStack                
            }
        }
    }

    
    @IBAction func clear() {
        brain.clearStack()
        displayValue = nil
        stackDisplay.text = ""
    }

    
    var displayValue: Double? {
        get{
           
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            if newValue != nil {
                display.text = "\(newValue!)"
            }
            else {
                display.text = "0"
            }
        }
    }
}