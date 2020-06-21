//
//  UITextField+Extensions.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 21/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

extension UITextField {
  func setBottomBorder() {
    borderStyle = .none
    layer.backgroundColor = UIColor.white.cgColor
    
    layer.masksToBounds = false
    
    layer.shadowColor = UIColor.lightGray.cgColor
    layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    layer.shadowOpacity = 1.0
    layer.shadowRadius = 0.0
  }
}
