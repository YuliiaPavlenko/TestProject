//
//  Cache.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 20/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

class Cache {
    static let shared = Cache()

    private var selectedCompany: Company?

    private init() {}

    func setSelectedCompany(_ company: Company) {
        selectedCompany = company
    }

    func getSelectedCompany() -> Company? {
        return selectedCompany
    }
}
