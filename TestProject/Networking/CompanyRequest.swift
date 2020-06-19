//
//  CompanyRequest.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 19/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

struct CompanyRequest {
    static let companies: String = "companies"

    static func getDetailsForCompany(_ id: Int) -> String {
      return companies + "/\(id)"
    }
}
