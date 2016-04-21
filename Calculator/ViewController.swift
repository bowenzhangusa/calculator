//
//  ViewController.swift
//  Calculator
//
//  Created by Bowen Zhang on 4/18/16.
//  Copyright © 2016 Bowen Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var middleOfTypingNumber = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if middleOfTypingNumber {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            middleOfTypingNumber = true
        }
        
        print("digit = \(digit)")
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if middleOfTypingNumber {
            enter()
        }
        switch operation {
            case "✕": performOperation(multiply)
            
        case "÷": performOperation({ (opt1: Double, opt2: Double) -> Double in return opt2/opt1})
        case "＋": performOperation({ (opt1: Double, opt2: Double) -> Double in return opt1 + opt2})
        case "－": performOperation({ (opt1: Double, opt2: Double) ->
            Double in return opt2 - opt1})
        case "√": performOperation({ (opt1: Double) -> Double in return sqrt(opt1)})
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if (operandStack.count >= 2) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
     private func performOperation(operation: Double -> Double) {
        if (operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func multiply(opt1: Double, opt2: Double) -> Double {
        return opt1 * opt2
    }
    @IBAction func enter() {
        middleOfTypingNumber = false
        operandStack.append(displayValue)
        print("operand stack is \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            middleOfTypingNumber = false
        }
    }
}

