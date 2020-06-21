//
//  CompaniesViewModel.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 20/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

protocol CompaniesViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
    func showCompanyDetails()
}

class CompaniesViewModel {
    private weak var delegate: CompaniesViewModelDelegate?
  
    private var companies: [Company] = []
    private var currentPage = 1
    private var total = 0
    private var isFetchInProgress = false
  
    init(delegate: CompaniesViewModelDelegate) {
        self.delegate = delegate
    }
  
    var totalCount: Int {
        return total
    }
  
    var currentCount: Int {
        return companies.count
    }
  
    func company(at index: Int) -> Company {
        return companies[index]
    }
  
    func fetchModerators() {
        guard !isFetchInProgress else { return }
    
        isFetchInProgress = true
    
        NetworkManager.shared.getCompanies(page: currentPage) { [weak self] result in
            guard let self = self else { return }
                switch result {
                case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: error.reason)
                }
                case .success(let response):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    
//                    self.total = Int(response.page)!
                    self.companies.append(contentsOf: response.results)
                    self.total += self.companies.count

                    if Int(response.page)! > 1 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: response.results)
                        self.delegate?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        self.delegate?.onFetchCompleted(with: .none)
                    }
                }
            }
        }
    }
        
    private func calculateIndexPathsToReload(from newCompanies: [Company]) -> [IndexPath] {
        let startIndex = companies.count - newCompanies.count
        let endIndex = startIndex + newCompanies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func companyClicked(_ atIndex: Int) {
        Cache.shared.setSelectedCompany(companies[atIndex])
        delegate?.showCompanyDetails()
    }
  
}
