//
//  DistincTests.swift
//  Sometimes
//
//  Created by Alejandro Martinez on 19/12/15.
//  Copyright © 2015 Alejandro Martinez. All rights reserved.
//

import Quick
import Nimble

@testable import Sometimes

class DistincSpec: QuickSpec {
    override func spec() {
        
        describe("Execute") {
            
            context("initial execution") {
                let distinc = Distinc<Int>()
                
                it("should execute") {
                    
                    var res = false
                    
                    distinc.execute(ifChanged: 2) {
                        res = true
                    }
                    
                    expect(res).toEventually(beTrue())
                }
            }
            
            context("no change") {
                
                let distinc = Distinc(initialVale: 2)
                
                it("should not execute") {
                    
                    var res = false
                    
                    distinc.execute(ifChanged: 2) {
                        res = true
                    }
                    
                    expect(res).toNotEventually(beTrue())
                }
                
            }
            
            context("change") {
                
                let distinc = Distinc(initialVale: 2)
                
                it("should execute") {
                    
                    var res = false
                    
                    distinc.execute(ifChanged: 3) {
                        res = true
                    }
                    
                    expect(res).toEventually(beTrue())
                }
                
            }
            
            context("second change") {
                let distinc = Distinc(initialVale: 2)
                
                it("should execute") {
                    
                    do {
                        var res = false
                        
                        distinc.execute(ifChanged: 3) {
                            res = true
                        }
                        
                        expect(res).toEventually(beTrue())
                    }
                    do {
                        var res = false
                        
                        distinc.execute(ifChanged: 4) {
                            res = true
                        }
                        
                        expect(res).toEventually(beTrue())
                    }
                    
                }
            }
            
            context("second change to initial") {
                let distinc = Distinc(initialVale: 2)
                
                it("should execute") {
                    
                    do {
                        var res = false
                        
                        distinc.execute(ifChanged: 3) {
                            res = true
                        }
                        
                        expect(res).toEventually(beTrue())
                    }
                    do {
                        var res = false
                        
                        distinc.execute(ifChanged: 2) {
                            res = true
                        }
                        
                        expect(res).toEventually(beTrue())
                    }

                }
            }
            
        }
        
    }
}