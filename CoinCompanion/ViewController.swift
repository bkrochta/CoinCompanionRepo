//
//  ViewController.swift
//  CoinCompanion
//
//  Created by Tim Palmieri on 1/21/18.
//  Copyright © 2018 TPdevs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display1: UILabel!
    //routed to display
    //not an action
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        //routed to all numbers
        //action, must recieve sender info, and UIButton type
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay1 = display1.text!
            display1.text = textCurrentlyInDisplay1 + digit
        } else {
            display1.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    var display1Value: Double {
        get {
            return Double(display1.text!)!
        }
        set {
            display1.text = String(newValue)
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        //routed to squareroot and pi buttons
        //action, must recieve sender info, and UIButton type
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            switch mathematicalSymbol {
            case "π":
                display1Value = Double.pi
            case "√":
                display1Value = sqrt(display1Value)
            default:
                break
            }
        }
    }
    

}

