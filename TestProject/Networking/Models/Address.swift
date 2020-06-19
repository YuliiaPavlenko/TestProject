//
//  Address.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 19/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

// MARK: - Address
struct Address: Codable {
    var city: String?
    var coordinates: Coordinates?
}

// MARK: - Coordinates
struct Coordinates: Codable {
    var latitude, longitude: String?
}
