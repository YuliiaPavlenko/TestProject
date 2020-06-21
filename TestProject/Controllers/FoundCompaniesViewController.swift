//
//  FoundCompaniesViewController.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 21/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class FoundCompaniesViewController: UIViewController {
    private enum CellIdentifiers {
        static let list = "CompanyList"
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    private var viewModel: FoundCompaniesViewModel!
    
    private var shouldShowLoadingCell = false
    var company: String!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        indicatorView.startAnimating()
        
        setupTableView()
        
        viewModel = FoundCompaniesViewModel(delegate: self)
        
        viewModel.fetchCompanies(with: company)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customizeNavigationBar(animated)
    }
    
    // MARK: - Navigation Bar
    func customizeNavigationBar(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = Colors.blue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.white, .font: Fonts.navigationTitle!]
        navigationController?.setNavigationBarHidden(false, animated: animated)
        title = viewModel.setNavigationBarTitle()
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorColor = Colors.separatorColor
    }
}

// MARK: - UITableView DataSource
extension FoundCompaniesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.companiesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.list, for: indexPath) as! CompanyTableViewCell
        
        cell.configure(with: viewModel.company(at: indexPath.row))
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension FoundCompaniesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.companyClicked(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - FoundCompaniesViewModelDelegate
extension FoundCompaniesViewController: FoundCompaniesViewModelDelegate {
    func onFetchCompletedWithNoData() {
        indicatorView.stopAnimating()
        Alert.showAlert(on: self, with: "Warning", message: "No data")
    }
    
    func onFetchCompleted() {
        indicatorView.stopAnimating()
        tableView.reloadData()
    }
    
    func onFetchFailed(with reason: String) {
        indicatorView.stopAnimating()
        Alert.showAlert(on: self, with: "Warning", message: reason)
    }
    
    func showCompanyDetails() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CompanyDetailsViewController") as? CompanyDetailsViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
}
