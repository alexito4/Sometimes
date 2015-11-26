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
    let valueKey: String
    
    public init(_ key: String) {
        self.valueKey = Sometimes.keyPrefix + key
    }
}

/// Defines the protocol need for the object to store the keys.
protocol SometimesStore {
    func allKeys() -> Set<String>
    func boolForKey(defaultName: String) -> Bool
    mutating func setBool(value: Bool, forKey defaultName: String)
    mutating func removeBoolForKey(defaultName: String)
}

/// Extend `NSUserDefaults` to conform to `SometimesStore`
extension NSUserDefaults: SometimesStore {
    func removeBoolForKey(defaultName: String) {
        self.removeObjectForKey(defaultName)
    }
    func allKeys() -> Set<String> {
        return Set(self.dictionaryRepresentation().keys)
    }
}

public struct Sometimes {
    
    private static let keyPrefix = "sometimes_"
    
    public typealias Block = Void -> ()
    
    /// Object used to store the keys.
    /// `NSUserDefaults.standardUserDefaults()` by default.
    static var defaults: SometimesStore = NSUserDefaults.standardUserDefaults()
    
    /**
     Executes the clousure... sometimes.
     Well, the first time.
     
     - parameter key:  uniquely identifies a block of execution
     - parameter code: code to be run (or not)
     
     - returns: true if the closure has been executed.
     */
    public static func execute(key: SometimesKey, @noescape code: Block) -> Bool {
        
        guard shouldExecute(key) else { return false }
        
        code()
        
        return true
    }
    
    /**
     Removes all the stored keys.
     */
    public static func reset() { 
        defaults.allKeys()
            .filter { $0.hasPrefix(keyPrefix) }
            .forEach { key in
                defaults.removeBoolForKey(key)
            }
    }
    
    // MARK: Private
    
    static let queue = dispatch_queue_create("com.alejandromp.sometimes", DISPATCH_QUEUE_SERIAL)
    
    static func shouldExecute(key: SometimesKey) -> Bool {
        var result = false

        dispatch_sync(queue) {
            // Check if it has been already executed
            
            if defaults.boolForKey(key.valueKey) == false {
                result = true
                
                // Update the value
                defaults.setBool(true, forKey: key.valueKey)
            }
        }
        
        return result
    }

}