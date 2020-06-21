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
    @IBOutlet var companyCoordinatesLabel: UILabel!
    @IBOutlet var companyImageView: UIImageView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    private var viewModel: CompanyDetailsViewModel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorView.startAnimating()
        
        configureUI()
        
        viewModel = CompanyDetailsViewModel(delegate: self)
        
        viewModel.viewIsPrepared()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customizeNavigationBar(animated)
    }
    
    // MARK: - Navigation Bar
    func customizeNavigationBar(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
        title = viewModel.setNavigationBarTitle()
    }
    
    // MARK: - Custom functions
    private func configureUI() {
        companyNameLabel.textColor = Colors.grayTitle
        companyNameLabel.font = Fonts.title
        
        companyDescriptionLabel.textColor = Colors.grayTitle
        companyDescriptionLabel.font = Fonts.title
        
        companyAddressLabel.textColor = Colors.grayTitle
        companyAddressLabel.font = Fonts.title
        
        companyCoordinatesLabel.textColor = Colors.grayTitle
        companyCoordinatesLabel.font = Fonts.title
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
            self.companyAddressLabel.text = "Company address: \(company.address?.city ?? "No city name")"
            self.companyCoordinatesLabel.text = "Company coordinates: \(company.address?.coordinates?.latitude ?? ""), \(company.address?.coordinates?.longitude ?? "")"
            
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
