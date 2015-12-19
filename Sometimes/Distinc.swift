//
//  Distinc.swift
//  Sometimes
//
//  Created by Alejandro Martinez on 19/12/15.
//  Copyright © 2015 Alejandro Martinez. All rights reserved.
//

/// Create an instance of this class to help you run code
/// only when the value has changed.
public final class Distinc<Value: Equatable> {
    
    var value: Value?
    
    public init() {
        self.value = nil
    }
    
    public init(initialVale: Value) {
        self.value = initialVale
    }
    
    /**
     Executes the clousure... sometimes.
     Well, the first time.
     
     - parameter key:  uniquely identifies a block of execution
     - parameter code: code to be run (or not)
     
     - returns: true if the closure has been executed.
     */
    public func execute(ifChanged value: Value, @noescape code: Sometimes.Block) -> Bool {
        
        guard shouldExecute(value) else { return false }
        
        code()
        
        return true
    }
    
    // MARK: Private
    
    let queue = dispatch_queue_create("com.alejandromp.sometimes.distinc", DISPATCH_QUEUE_SERIAL)
    
    func shouldExecute(newValue: Value) -> Bool {
        var result = false
        
        dispatch_sync(queue) {
            // Check if it has been already executed
            
            // Update the value
            defer { self.value = newValue }

            if let old = self.value {
                result = old != newValue
            
            } else { // First time
                result = true
            }
        }
        
        return result
    }
}
