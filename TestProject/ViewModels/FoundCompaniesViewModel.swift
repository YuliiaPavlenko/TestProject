//
//  FoundCompaniesViewModel.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 21/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

protocol FoundCompaniesViewModelDelegate: class {
    func onFetchFailed(title: String, message: String)
    func showCompanyDetails()
    func onFetchCompleted()
    func onFetchCompletedWithNoData(title: String, message: String)
}

class FoundCompaniesViewModel {
    private weak var delegate: FoundCompaniesViewModelDelegate?
    
    private var companies: [Company] = []
    
    init(delegate: FoundCompaniesViewModelDelegate) {
        self.delegate = delegate
    }
    
    var companiesCount: Int {
        return companies.count
    }
    
    
    func company(at index: Int) -> Company {
        return companies[index]
    }
    
    func fetchCompanies(with text: String) {
        
        NetworkManager.shared.findCompanies(for: text) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.onFetchFailed(title: "Error", message: error.reason)
                }
            case .success(let response):
                DispatchQueue.main.async {
                    self.companies.append(contentsOf: response)
                    if response.count > 0 {
                        self.delegate?.onFetchCompleted()
                    } else {
                        self.delegate?.onFetchCompletedWithNoData(title: "Warning", message: "No data found")
                    }
                }
            }
        }
    }
    
    func companyClicked(_ atIndex: Int) {
        Cache.shared.setSelectedCompany(companies[atIndex])
        delegate?.showCompanyDetails()
    }
    
    func setNavigationBarTitle() -> String {
        return "Companies"
    }
}
