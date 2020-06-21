//
//  CompanyRequest.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 19/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

struct CompanyRequest {
    
    private static let baseURL = "http://127.0.0.1:5000/"
    static let companies: String = baseURL + "companies"
    
    static func getCompaniesForPage(_ page: Int) -> String {
        return companies + "?page_number=\(page)"
    }
    
    static func getCompaniesForQuery(_ text: String) -> String {
        return companies + "/search?query=\(text)"
    }
    
    static func getDetailsForCompany(_ id: Int) -> String {
        return companies + "/\(id)"
    }
    
}
