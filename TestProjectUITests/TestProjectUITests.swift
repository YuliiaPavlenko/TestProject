//
//  TestProjectUITests.swift
//  TestProjectUITests
//
//  Created by Yuliia Pavlenko on 19/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import XCTest

class TestProjectUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIfTextFieldIsNotEmpty() {
        
        let companyTextField = app.textFields["Company"]
        
        let findCompaniesButton = app.buttons["Find Companies"]
                        
        if !companyTextField.title.isEmpty {
            XCTAssertTrue(findCompaniesButton.isEnabled)
        } else {
            XCTAssertFalse(findCompaniesButton.isEnabled)
        }

    }
    
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
