//
//  UN_CurrencyService.swift
//  currTV
//
//  Created by Admin on 05/11/2016.
//  Copyright © 2016 Admin. All rights reserved.
//

import XCTest

@testable import FixerClient

class UN_FixerService: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_baseURL(){
        XCTAssertEqual(FixerService.sharedInstance.baseURL, "http://localhost:3080")
    }
    
    func test_latest() {
        
        // Force busines error
        var asyncExpectation = expectation(description: "Force busines error")
        FixerService.sharedInstance.latest(base:"EUR",
            parameterWithDefault:"FORCE_BUSINESS_ERROR",
                success: {
                dateCurrencyRate in
                XCTFail()
            },serverFailure: { (error) in
                XCTFail()
            },businessFailure: { (error) in
                asyncExpectation.fulfill()
            }
        )
        self.waitForExpectations(timeout: 3, handler: nil)
        
        // Force server error
        asyncExpectation = expectation(description: "Force server error")
        FixerService.sharedInstance.latest(base:"EUR",parameterWithDefault:"FORCE_SERVER_ERROR",
                                              success: {
                                                dateCurrencyRate in
                                                XCTFail()
            },serverFailure: { (error) in
                asyncExpectation.fulfill()
            },businessFailure: { (error) in
                XCTFail()
            }
        )
        self.waitForExpectations(timeout: 3, handler: nil)
        
        // Good case
        asyncExpectation = expectation(description: "Good case")
        FixerService.sharedInstance.latest(base:"EUR",
                                              success: {
                                                dateCurrencyRate in
                                                XCTAssertEqual(dateCurrencyRate.base,"EUR")
                                                
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                                let date = dateFormatter.date(from: "2016-11-04")
                                                XCTAssertEqual(dateCurrencyRate.date,date)
                                                
                                                XCTAssertEqual(dateCurrencyRate.rates.count,31)
                                                
                                                asyncExpectation.fulfill()
            },serverFailure: { (error) in
                XCTFail()
            },businessFailure: { (error) in
                XCTFail()
            }
        )
        
        self.waitForExpectations(timeout: 3, handler: nil)
        
    }
    

}
