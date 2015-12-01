//
//  CalculatorBrain.swift
//  CalculatorDemo
//
//  Created by Nathan Crowther on 9/9/15.
//  Copyright (c) 2015 Nathan Crowther. All rights reserved.
//

import Foundation
import Darwin

class CalculatorBrain{
    private enum Op: CustomStringConvertible {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        case ConstantOperation(String, Double)

        
        var description: String{
            get{
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                case .ConstantOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]()

    private var knownOps = [String : Op]()
    
    init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷", {$1 / $0}))
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("-", {$1 - $0}))
        learnOp(Op.UnaryOperation("√", sqrt))
        learnOp(Op.UnaryOperation("sin", sin)) //Hook up sin()
        learnOp(Op.UnaryOperation("cos", cos)) //Hook up cos()
        learnOp(Op.ConstantOperation("π", M_PI)) //Learn Pi
    }
 
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        print("\(opStack) =  \(result) with \(remainder) left over")
        
        return result
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
            case .Operand(let operand):
              
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                
                if let operand = operandEvaluation.result {
                
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    
                    if let operand2 = op2Evaluation.result {
                
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            case .ConstantOperation(_, let constOperation):
        
                return (constOperation, remainingOps)
            }
        }
       
        return(nil, ops)
    }

    
    //Required Task #7
    var descriptionOfTopOfStack: String {
        get {
            var copyStack = opStack
            var returnDescription = descriptionOfTopOfStack(&copyStack, lastOp: nil)

            while !copyStack.isEmpty {
                returnDescription = descriptionOfTopOfStack(&copyStack, lastOp: nil) + ", " + returnDescription
            }
            returnDescription += " ="
            
            return returnDescription
        }
        //1. What if opStack is empty
        //2. iterate over the stack until it has described all the components.
        //3. In between each component it needs to join them with ", "
    }
    
    
    private func descriptionOfTopOfStack(inout stack: [Op], lastOp: Op?) -> String {
        if !stack.isEmpty {
            let op = stack.removeLast()
            print("OP: \(op), lastOp: \(lastOp), OPTYPE:")
            
            switch op {
            case .Operand(_):
                print("OP: \(op)")
                
                return op.description
           
            case .UnaryOperation(_, _):
                let a = descriptionOfTopOfStack(&stack, lastOp: op)
                print("OP: \(op), A: \(a)")
               
                return op.description + "(" + a + ")"

            case .BinaryOperation(_, _):
                print("Binary: \(op),")
                let a = descriptionOfTopOfStack(&stack, lastOp: op)
                let b = descriptionOfTopOfStack(&stack, lastOp: op)
                print(lastOp)
                if let switchOp = lastOp {
                    switch switchOp {
                    case .BinaryOperation(_,_):
                        print("(" + b + op.description + a + ")")
                       
                        return "(" + b + op.description + a + ")"
                    default:
                        print(b + op.description + a)
                        
                        return b + op.description + a
                    }
                }
                
                return b + op.description + a
                
                
            case .ConstantOperation(_, _):
                
                return op.description
            }
        }
        return "?"
    }

    func performOperation(symbol: String) -> Double?{
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        
        return evaluate()
    }
    
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        
        return evaluate()
    }
    
    func clearStack(){
        while !opStack.isEmpty{
            opStack.removeLast()
        }
    }
    
    func asPropertyList() -> [String] {
        var stack = [String]()
        
        for op in opStack {
            stack.append(op.description)
        }
        
        return stack
    }


}