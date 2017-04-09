//
//  LeantimeTests.swift
//  LeantimeTests
//
//  Created by Sebastian Hojas on 04/03/2017.
//  Copyright © 2017 Sebastian Hojas. All rights reserved.
//

import XCTest
@testable import Leantime

class LeantimeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWeek() {
        XCTAssertEqual(Timespan.weeks(5).timeInterval, 5*7*24*60*60)
    }
    
    func testYear() {
        XCTAssertEqual(Timespan.years(5).timeInterval, 5*365*24*60*60)
    }
    
    func testDays() {
        XCTAssertEqual(Timespan.days(5).timeInterval, 5*24*60*60)
    }

    func testHours() {
        XCTAssertEqual(Timespan.hours(5).timeInterval, 5*60*60)
    }

    func testMinutes() {
        XCTAssertEqual(Timespan.minutes(45).timeInterval, 45*60)
    }

    func testSeconds() {
        XCTAssertEqual(Timespan.seconds(5).timeInterval, 5)
    }
    
    func testEquatable() {
        XCTAssert(Timespan.seconds(60) == Timespan.minutes(1))
        XCTAssert(Timespan.minutes(60) == Timespan.hours(1))
        XCTAssert(Timespan.hours(24) == Timespan.days(1))
        XCTAssert(Timespan.days(7) == Timespan.weeks(1))
        XCTAssert(Timespan.days(365) == Timespan.years(1))
    }
    
    func testCompound() {
        XCTAssert(Timespan.seconds(30)+Timespan.minutes(2) == Timespan.seconds(150))
        XCTAssert(Timespan.hours(20)-Timespan.days(2) == Timespan.hours(-28))
    }

}
