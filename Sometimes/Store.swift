//
//  Store.swift
//  Sometimes
//
//  Created by Alejandro Martinez on 26/11/15.
//  Copyright © 2015 Alejandro Martinez. All rights reserved.
//

import Foundation

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