//
//  CompanyDetailsViewController.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 20/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit
import Kingfisher

class CompanyDetailsViewController: UIViewController {
    
    @IBOutlet var companyNameLabel: UILabel!
    @IBOutlet var companyDescriptionLabel: UILabel!
    @IBOutlet var companyAddressLabel: UILabel!
    @IBOutlet var companyImageView: UIImageView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    private var viewModel: CompanyDetailsViewModel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorView.startAnimating()
        
        viewModel = CompanyDetailsViewModel(delegate: self)
        
        viewModel.viewIsPrepared()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customizeNavigationBar(animated)
    }
    
    // MARK: - Navigation Bar
    func customizeNavigationBar(_ animated: Bool) {
        title = viewModel.setNavigationBarTitle()
    }

}

// MARK: - CompanyDetailsViewModelDelegate
extension CompanyDetailsViewController: CompanyDetailsViewModelDelegate {
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        Alert.showAlertOnMainThread(on: self, with: title, message: message)
        
    }
    
    func showCompanyDetails(for company: Company) {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
            
            self.companyNameLabel.text = company.name ?? "No company name"
            self.companyDescriptionLabel.text = company.description ?? "No company description"
            self.companyAddressLabel.text = (company.address?.city)!
                //+ company.address?.coordinates?.latitude ?? "" + company.address?.coordinates?.longitude ?? ""
            
            if let coverImage = company.coverImage {
                let fixedCoverImageName = coverImage.replacingOccurrences(of: "i.", with: "")
                let url = URL(string: fixedCoverImageName)
                self.companyImageView.kf.setImage(with: url)
            } else {
                self.companyImageView.image = UIImage(named: "noImageIcon.png")
            }
        }
        
        
        
    }
    
    
}
