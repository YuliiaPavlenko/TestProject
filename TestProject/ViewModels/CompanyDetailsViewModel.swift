//
//  CompanyDetailsViewModel.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 20/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

protocol CompanyDetailsViewModelDelegate: class {
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String)
    func showCompanyDetails(for company: Company)
}

class CompanyDetailsViewModel {
    private weak var delegate: CompanyDetailsViewModelDelegate?
    
    private var company = Company()
    
    private var isFetchInProgress = false
    
    init(delegate: CompanyDetailsViewModelDelegate) {
        self.delegate = delegate
    }
    
    func viewIsPrepared() {
        guard !isFetchInProgress else { return }
        
        isFetchInProgress = true
        let selectedCompany = Cache.shared.getSelectedCompany()
        
        if let company = selectedCompany {
            NetworkManager.shared.getCompanyDetails(companyId: company.id!) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    self.delegate?.presentAlertOnMainThread(title: "Error", message: error.reason, buttonTitle: "OK")
                case .success(let response):
                    let companyDetails = Company(address: response.address, coverImage: response.coverImage, description: response.description, id: response.id, name: response.name)
                    self.delegate?.showCompanyDetails(for: companyDetails)
                }
            }
        }
    }
    
    func setNavigationBarTitle() -> String {
        return "Company Details"
    }
    
}
