//
//  SometimesTests.swift
//  SometimesTests
//
//  Created by Alejandro Martinez on 24/11/15.
//  Copyright © 2015 Alejandro Martinez. All rights reserved.
//


import Quick
import Nimble

@testable import Sometimes

/// Extend `Dictionary`to conform to `SometimesStore`
extension Dictionary: SometimesStore {
    
    func boolForKey(defaultName: String) -> Bool {
        return (self[defaultName as! Key] as? Bool) ?? false
    }
    
    mutating func setBool(value: Bool, forKey defaultName: String) {
        self[defaultName as! Key] = (value as! Value)
    }
    
    mutating func removeBoolForKey(defaultName: String) {
        self[defaultName as! Key] = nil
    }
    
    func allKeys() -> Set<String> {
        return Set(self.map{ (key, value) in key as! String })
    }
}
typealias FakeDefaults = Dictionary<String, Bool>

class SometimesSpec: QuickSpec {
    override func spec() {
        
        describe("Execute") {
            
            context("the first time") {
                
                beforeEach {
                    Sometimes.defaults = FakeDefaults()
                }
                
                it("should run the code") {
                    let key = SometimesKey("test")
                    
                    var executed = false
                    Sometimes.execute(key) {
                        executed = true
                    }
                    
                    expect(executed).toEventually(beTrue())
                }
            }
            
            context("the second time") {
                
                let key = SometimesKey("test")

                beforeEach {
                    Sometimes.defaults = FakeDefaults()
                    Sometimes.execute(key) {}
                }
                
                it("should not run the code") {
                    
                    var executed = false
                    Sometimes.execute(key) {
                        executed = true
                    }
                    
                    expect(executed).toEventually(beFalse())
                    
                }
                
                
            }
        }
        
        describe("Clear") {
            
            var libKeys: Array<SometimesKey> = []
            var otherKeys: Array<String> = []
            
            beforeEach {
                // Prepare library and other app keys
                libKeys = [
                    SometimesKey("test1"),
                    SometimesKey("test2")
                ]
                otherKeys = [
                    "other1",
                    "other2"
                ]
                
                Sometimes.defaults = FakeDefaults()
                
                // Add all the keys
                Sometimes.execute(libKeys[0]) {}
                Sometimes.execute(libKeys[1]) {}
                
                Sometimes.defaults.setBool(true, forKey: otherKeys[0])
                Sometimes.defaults.setBool(true, forKey: otherKeys[1])
            }
            
            it("should remove all keys") {
                Sometimes.reset()
                
                expect(Sometimes.defaults.boolForKey(libKeys[0].valueKey)).to(beFalse())
                expect(Sometimes.defaults.boolForKey(libKeys[1].valueKey)).to(beFalse())
            }
            
            it("should keep app keys") {
                Sometimes.reset()
                
                expect(Sometimes.defaults.boolForKey(otherKeys[0])).to(beTrue())
                expect(Sometimes.defaults.boolForKey(otherKeys[1])).to(beTrue())
            }
            
        }
    }
}