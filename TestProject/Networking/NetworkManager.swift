//
//  NetworkManager.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 19/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    let session: URLSession
    
    private init() {
        session = URLSession(configuration: .default)
    }
    
    func getCompanies(page: Int, completion: @escaping (Result<PagedCompanyResponse, DataResponseError>) -> Void) {

        let url = URL(string: CompanyRequest.getCompaniesForPage(page))!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if let _ = error {
                completion(.failure(.network))
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(.failure(.decoding))
                    return
            }
            
            do {
                let point = try JSONDecoder().decode(PagedCompanyResponse.self, from: data)
                
                completion(.success(point))
            } catch {
                completion(.failure(.decoding))
            }
            
        })
        task.resume()
    }
    
    func getCompanyDetails(companyId: Int, completion: @escaping (Result<Company, DataResponseError>) -> Void) {
        let url = URL(string: CompanyRequest.getDetailsForCompany(companyId))!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if let _ = error {
                completion(.failure(.network))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.decoding))
                return
            }
            
            do {
                let point = try JSONDecoder().decode(Company.self, from: data!)
                
                completion(.success(point))
            } catch {
                completion(.failure(.decoding))
            }
            
        })
        task.resume()
    }
}
