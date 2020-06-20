//
//  Alert.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 20/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

struct Alert {
    static func showAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = baseAlert(title: title, message: message)
        vc.present(alert, animated: true)
    }
    
    private static func baseAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
}
