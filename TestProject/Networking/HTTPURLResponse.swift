//
//  HTTPURLResponse.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 19/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
  var hasSuccessStatusCode: Bool {
    return 200...299 ~= statusCode
  }
}
