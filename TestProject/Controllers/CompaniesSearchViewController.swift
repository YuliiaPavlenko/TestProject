//
//  CompaniesSearchViewController.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 21/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CompaniesSearchViewController: UIViewController {
    private enum SegueIdentifiers {
        static let list = "CompaniesViewController"
    }
    
    @IBOutlet var companyTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    private var behavior: ButtonEnablingBehavior!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .white
        
        behavior = ButtonEnablingBehavior(textFields: [companyTextField]) { [unowned self] enable in
            if enable {
                self.searchButton.isEnabled = true
                self.searchButton.alpha = 1
            } else {
                self.searchButton.isEnabled = false
                self.searchButton.alpha = 0.7
            }
        }
        
        companyTextField.setBottomBorder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.list {
            if let listViewController = segue.destination as? FoundCompaniesViewController {
                listViewController.company = companyTextField.text!
            }
        }
    }
}
