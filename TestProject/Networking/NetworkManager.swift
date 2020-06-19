//
//  NetworkManager.swift
//  TestProject
//
//  Created by Yuliia Pavlenko on 19/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    private lazy var baseURL: URL = {
      return URL(string: "http://127.0.0.1:5000/")!
    }()

    static let shared = NetworkManager()
    let session: URLSession

    private init() {
        session = URLSession(configuration: .default)
    }
    
    private func getData<Data: Decodable>(with url: URL, completion: @escaping ((Data?, DataResponseError?) -> Void)) {
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in

            if let _ = error {
                completion(nil, .decoding)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.hasSuccessStatusCode,
                  let data = data
            else {
                completion(nil, .network)
                return
            }

            do {
                let point = try JSONDecoder().decode(Data.self, from: data)

                completion(point, nil)
            } catch {
                completion(nil, .decoding)
            }

        })
        task.resume()
    }
    
    func getCompanies(completion: @escaping (([Company]?, DataResponseError?) -> Void)) {
        let url = baseURL.appendingPathComponent(CompanyRequest.companies)
        getData(with: url, completion: completion)
    }

    func getCompanyDetails(companyId: Int, completion: @escaping ((Company?, DataResponseError?) -> Void)) {
        let url = baseURL.appendingPathComponent(CompanyRequest.getDetailsForCompany(companyId))
        getData(with: url, completion: completion)
    }
}
