//
//  CompanyDetailsPropertiesTests.swift
//  TestProjectTests
//
//  Created by Yuliia Pavlenko on 21/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import XCTest
@testable import TestProject

class CompanyDetailsPropertiesTests: XCTestCase {
    
    var sut: CompanyDetailsViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(withIdentifier: "CompanyDetailsViewController") as? CompanyDetailsViewController
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testCompanyDetailsForm_WhenLoaded_UILabelsConnected() throws {
        _ = try XCTUnwrap(sut.companyNameLabel, "Company Name UILabel is not connected")
         _ = try XCTUnwrap(sut.companyDescriptionLabel, "Company Description UILabel is not connected")
         _ = try XCTUnwrap(sut.companyAddressLabel, "Company Address UILabel is not connected")
    }
    
    func testCompanyDetailsForm_WhenLoaded_UIImageViewConnected() throws {
        _ = try XCTUnwrap(sut.companyImageView, "Company Image UIImageView is not connected")
    }
}

