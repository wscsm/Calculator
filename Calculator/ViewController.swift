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
    @IBOutlet weak var btnAC: UIButton!
    
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
        // 重复输入点号,不处理直接返回;
        if (digit == "." && display.text!.containsString(".")){
            return
        }
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            // 检查是否重复输入了".", 忽略之;
            
            if (textCurrentlyInDisplay == "0" && digit != "."){
                display.text = digit
            }
            else{
                display.text = textCurrentlyInDisplay + digit
            }
        }
        else {
            if (digit == "."){
                display.text = "0."
            }
            else if (digit == "0"){
                display.text = "0"
            }
            else {
                display.text = digit
            }
        }
        btnAC.setTitle("C", forState: .Normal)
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction private func performOperation(sender: UIButton) {
        if (sender == btnAC && btnAC.currentTitle == "C"){
            btnAC.setTitle("AC", forState: .Normal)
        }
        else if (sender != btnAC){
            btnAC.setTitle("C", forState: .Normal)
        }
        
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

