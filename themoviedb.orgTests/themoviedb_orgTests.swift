//
//  themoviedb_orgTests.swift
//  themoviedb.orgTests
//
//  Created by Nigel Barber on 05/10/2018.
//  Copyright © 2018 Nigel Barber. All rights reserved.
//

import XCTest
@testable import themoviedb_org

class themoviedb_orgTests: XCTestCase {
    
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
    }
    
    func testNowPlaying() {
        API.searchNowPlaying() { results in
            XCTAssert(results.count != 0)
        }
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
