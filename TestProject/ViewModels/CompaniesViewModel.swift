//
//  CompaniesViewModel.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 20/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

protocol CompaniesViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(title: String, message: String)
    func showCompanyDetails()
}

class CompaniesViewModel {
    private weak var delegate: CompaniesViewModelDelegate?
    
    private var companies: [Company] = []
    private var currentPage = 1
    
    init(delegate: CompaniesViewModelDelegate) {
        self.delegate = delegate
    }
    
    var currentCount: Int {
        return companies.count
    }
    
    var shouldLoadNextPages = false
    
    func company(at index: Int) -> Company {
        return companies[index]
    }
    
    func fetchCompanies() {
        
        NetworkManager.shared.getCompanies(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.onFetchFailed(title: "Error", message: error.reason)
                }
            case .success(let response):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    
                    if response.results.count > 0 {
                        self.shouldLoadNextPages = true
                        self.companies.append(contentsOf: response.results)
                    } else {
                        self.shouldLoadNextPages = false
                    }
                    self.delegate?.onFetchCompleted()
                    
                }
            }
        }
    }
    
    func itemsCount() -> Int {
        if shouldLoadNextPages {
            return companies.count + 1
        } else {
            return companies.count
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
