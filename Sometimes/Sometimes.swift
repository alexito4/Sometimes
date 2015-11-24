//
//  Sometimes.swift
//  GameOfLife
//
//  Created by Alejandro Martinez on 24/11/15.
//  Copyright © 2015 Alejandro Martinez. All rights reserved.
//

import Foundation

/// Typed key to use with the Sometimes type.
/*
TODO: Use a custom user defaults domain or prefix the keys.
    In oder to provide a `clean` method.
*/
public struct SometimesKey {
    private let valueKey: String
    
    public init(_ key: String) {
        self.valueKey = key
    }
}

public struct Sometimes {
    
    public typealias Block = Void -> ()
    
    /**
     Executes the clousure... sometimes.
     Well, the first time.
     
     - parameter key:  <#key description#>
     - parameter code: <#code description#>
     
     - returns: true if the closure has been executed.
     */
    public static func execute(key: SometimesKey, @noescape code: Block) -> Bool {
        
        guard shouldExecute(key) else { return false }
        
        code()
        
        return true
    }
    
    // MARK: Private
    
    static let queue = dispatch_queue_create("com.alejandromp.sometimes", DISPATCH_QUEUE_SERIAL)
    
    static func shouldExecute(key: SometimesKey) -> Bool {
        var result = false

        dispatch_sync(queue) {
            // Check if it has been already executed
            
            
            
            if NSUserDefaults.standardUserDefaults().boolForKey(key.valueKey) == false {
                result = true
                
                // Update the value
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: key.valueKey)
            }
        }
        
        return result
    }

}