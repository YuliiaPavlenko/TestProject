//
//  CompaniesListViewController.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 20/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CompaniesListViewController: UIViewController {
    private enum CellIdentifiers {
        static let list = "CompanyList"
        static let loadingCellIdentifier = "LoadingTableViewCell"
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    private var viewModel: CompaniesViewModel!
        
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorView.startAnimating()
 
        viewModel = CompaniesViewModel(delegate: self)
        
        setupTableView()
        
        viewModel.fetchCompanies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customizeNavigationBar(animated)
    }
    
    // MARK: - Navigation Bar
    func customizeNavigationBar(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = Colors.blue
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.white, .font: Fonts.navigationTitle!]
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.tabBarController?.navigationItem.title = viewModel.setNavigationBarTitle()
    }
    
    // MARK: - Custom functions
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorColor = Colors.separatorColor
    }
}

// MARK: - UITableView DataSource
extension CompaniesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if viewModel.shouldLoadNextPages && indexPath.row == (self.viewModel.itemsCount() - 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.loadingCellIdentifier, for: indexPath) as! LoadingTableViewCell
            cell.indicatorView.startAnimating()
            viewModel.fetchCompanies()
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.list, for: indexPath) as! CompanyTableViewCell
        
        cell.configure(with: viewModel.company(at: indexPath.row))
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension CompaniesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.companyClicked(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CompaniesViewModelDelegate
extension CompaniesListViewController: CompaniesViewModelDelegate {
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
