//
//  AwesomeTests.swift
//  AwesomeTests
//
//  Created by Artak on 11/20/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import XCTest
@testable import Awesome

class AwesomeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
       // XCTAssertNotNil(nil, "Cannot nil instance");
        XCTAssertNotNil("Gevor", "Cannot nil instance");
    }
    
    func testNilability() {
     //   XCTAssertNotNil(nil, "Cannot nil instance");
    }
    
    func testAngleCalculatorArrowAngle() {
       XCTAssertEqual(AngleCalculator.getArrowAngleOf(segment: 5, ofTotal: 11) , 0)
    }
    
    func testAngleCalculatorSegmentRange() {
        let range = AngleCalculator.getRangeOf(segment: 7, ofTotal: 15)

        
        XCTAssert(range.1 - range.0 <= .pi / 10, "\(range)")

    }
    
    func testAngleCalculatorSegmentRangeEquality() {
        let range1 = AngleCalculator.getRangeOf(segment: 7, ofTotal: 15)
        let range2 = AngleCalculator.getRangeOf(segment: 9, ofTotal: 15)
        
        XCTAssertEqual(range1.1 - range1.0, range2.1 - range2.0)
    }
    
    func testAngleCalculatorSegmentRangeComparation() {
        let range1 = AngleCalculator.getRangeOf(segment: 7, ofTotal: 15)
        let range2 = AngleCalculator.getRangeOf(segment: 7, ofTotal: 16)
        
        XCTAssert(range1.1 - range1.0 > range2.1 - range2.0, "More segments small angle")
    }
        
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
