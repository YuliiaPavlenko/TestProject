//
//  PagedCompanyResponse.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 20/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

struct PagedCompanyResponse: Codable {
    let page: String
    let results: [Company]
}
