//
//  CompaniesSearchPropertiesTests.swift
//  TestProjectTests
//
//  Created by Yuliia Pavlenko on 21/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import XCTest

@testable import TestProject

class CompaniesSearchPropertiesTests: XCTestCase {
    
    var sut: CompaniesSearchViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(withIdentifier: "CompaniesSearchViewController") as? CompaniesSearchViewController
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testCompanyForm_WhenLoaded_TextFieldConnected() throws {
     _ = try XCTUnwrap(sut.companyTextField, "Company UITextField is not connected")
    }
    
    func testSearchButton_WhenCreated_Connected() {
        
        // Check if Controller has UIButton property
        let searchButton: UIButton = sut.searchButton
        XCTAssertNotNil(searchButton, "Companies Search View Controller does not have UIButton property")
    }
}
