//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by suyanlu on 16/7/9.
//  Copyright © 2016年 suyanlu. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private var accumulator = 0.0
    private var pending: PendingBinaryOperationInfo? = nil
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Ac
        case Equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "+": Operation.BinaryOperation{ $0 + $1 },
        "−": Operation.BinaryOperation{ $0 - $1 },
        "×": Operation.BinaryOperation{ $0 * $1 },
        "÷": Operation.BinaryOperation{ $0 / $1 },
        "=": Operation.Equals,
        "AC": Operation.Ac,
    ]
    
    func setOperand(operand: Double)  {
        accumulator = operand
    }
    
    func executePendingBinaryOperation() {
        if (pending != nil) {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    func performOperation(symbol: String) {
        if let op = operations[symbol] {
            switch op {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let fun):
                accumulator = fun(accumulator)
            case .BinaryOperation(let fun):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: fun, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            case .Ac:
                pending = nil
                accumulator = 0.0
            }
        }
    }
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}