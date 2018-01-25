//
//  ViewController.swift
//  CoinCompanion
//
//  Created by Tim Palmieri on 1/21/18.
//  Copyright © 2018 TPdevs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var currency: UITextField!
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
    
    //    @IBAction func Test(_ sender: UIButton) {
    //        userIsInTheMiddleOfTyping = false
    //        if let idk = sender.currentTitle{
    //
    //        }
    //
    //    }
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
            case "GO":
                let number = getTheNumber(currency: currency.text!)
                display1Value = display1Value * Double(number)!

            default:
                break
            }
        }
    }
    
    
    
}

func getTheNumber(currency: String) -> String {
    
    let test = currency
    
    
    func getInfo() -> String { //method returns string of page source
        let myURLString = "https://coinmarketcap.com" //input url
        guard let myURL = URL(string: myURLString) else { //checks if url is valid; if valid continue
            return("Error: \(myURLString) doesn't seem to be a valid URL") //else return error
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            return("HTML : \(myHTMLString)")
        } catch let error {
            return("Error: \(error)")
        }
    }
    
    let text = getInfo() //assigns page source to variable
    
    func shortenPageSource() -> String {
        // print(text.count) //print length of page source
        //shorten page source
        let start = text.index(text.startIndex, offsetBy: 60000)
        let end = text.index(text.endIndex, offsetBy: -12000)
        let range = start..<end
        let shorter = text[range]
        return String(shorter)
    }
    
    
    func findCoin() -> Int {
        var index = 0
        let coin = test
        let shortSource = shortenPageSource()
        for char in shortSource {
            if coin.first == char {
                let startOfFoundCharacter = shortSource.index(shortSource.startIndex, offsetBy: index)
                let lengthOfFoundCharacter = shortSource.index(shortSource.startIndex, offsetBy: (coin.count + index))
                let range = startOfFoundCharacter..<lengthOfFoundCharacter
                if shortSource[range] == coin {
                    return(index)
                    
                }
            }
            index += 1
        }
        return(0)
    }
    
    
    func shortenAgain() -> String {
        let start = text.index(text.startIndex, offsetBy: 60000+findCoin())
        let end = text.index(text.endIndex, offsetBy: -12000)
        let range = start..<end
        let shorter = text[range]
        return String(shorter)
    }
    
    // Loop through parent string looing for the first character of the substring
    func findValue() -> String {
        var index = 0
        let goal = "#markets"
        let shortSource = shortenAgain()
        for char in shortSource {
            if goal.first == char {
                // Create a start and end index to ultimately creata range
                //
                // Hello Agnosticdev, I love Tutorials
                //       6   ->   17 - rage of substring from 7 to 18
                //
                let startOfFoundCharacter = shortSource.index(shortSource.startIndex, offsetBy: index)
                let lengthOfFoundCharacter = shortSource.index(shortSource.startIndex, offsetBy: (goal.count + index))
                let range = startOfFoundCharacter..<lengthOfFoundCharacter
                
                // Grab the substring from the parent string and compare it against substring
                // Essentially, looking for the needle in a haystack
                if shortSource[range] == goal {
                    break
                }
            }
            index += 1
        }
        let start = shortSource.index(shortSource.startIndex, offsetBy: index+34)
        let end = shortSource.index(shortSource.startIndex, offsetBy: index+34+7)
        let range = start..<end
        let string1 = shortSource[range]
        return(String(string1))
    }
    return(findValue())
}









