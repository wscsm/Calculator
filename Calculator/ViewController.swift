//
//  ViewController.swift
//  Calculator
//
//  Created by suyanlu on 16/7/8.
//  Copyright © 2016年 suyanlu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    private var brain = CalculatorBrain()

    private var displayValue: Double {
        get {
            let displayText = display.text!
            //if (displayText[displayText.endIndex.predecessor()] == ".") {
            if (displayText.characters.last! == ".") {
                return Double(displayText+"0")!
            }
            else{
                return Double(displayText)!
            }
        }
        set {
            display.text = String(newValue)
        }
    }
    
    // MARK: Actions
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
        else {
            if (digit == "."){
                display.text = "0."
            }
            else {
                display.text = digit
            }
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction private func performOperation(sender: UIButton) {
        if (userIsInTheMiddleOfTyping) {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

