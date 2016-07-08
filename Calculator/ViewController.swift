//
//  ViewController.swift
//  Calculator
//
//  Created by suyanlu on 16/7/8.
//  Copyright © 2016年 suyanlu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Actions
    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle
        print(digit)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

