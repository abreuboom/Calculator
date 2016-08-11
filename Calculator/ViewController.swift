//
//  ViewController.swift
//  Calculator
//
//  Created by John Abreu on 6/20/16.
//  Copyright © 2016 John Abreu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    @IBOutlet private weak var history: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit(sender: UIButton){
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping && digit != "." || (digit == "." && display.text!.rangeOfString(".") == nil) {
            display.text = display.text! + digit
        }
        else {
            if digit == "." {
                display.text = "0" + digit
            } else {
                display.text = digit
            }
            userIsInTheMiddleOfTyping = true
        }
        history.text = history.text! + display.text!
    }
    
    var displayValue: Double {
        
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        history.text = history.text! + String(sender.currentTitle!)
        displayValue = brain.result
        history.text = history.text! + String(displayValue)
    }
    
    
}

