//
//  Company.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 19/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

struct Company: Codable {
    var address: Address?
    var coverImage: String?
    var description: String?
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case address
        case coverImage = "cover_image"
        case description, id, name
    }
}
