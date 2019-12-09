//
//  NetworkHelper.swift
//  NetworkHelper
//
//  Created by Kelby Mittan on 12/6/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation

// we need to make our NetworkHelper a singleton
// this means there will only ever be one instance of this class throughout the application
// at no point will someone be able to create an instance of NetworkHelper

class NetworkHelper {
    
    // we will create a shared instance of the NetworkHelper
    static let shared = NetworkHelper()
    
    private var session: URLSession
    
    // we will make the default initializer private required in order to be considered a singleton
    private init() {
        session = URLSession(configuration: .default)
    }
    
    func performDataTask(with urlString: String,
                         completion: @escaping (Result<Data, AppError>) -> ()) {
        
        guard let url = URL(string: urlString) else {
            // handle bad url error case
            completion(.failure(.badURL(urlString)))
            return
        }
        
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            // 1. deal with error if any
            if let error = error {
                completion(.failure(.networkClientError(error)))
            }
            
            // 2. downcast URLResponse (response) to HTTPURLResponse to get access to the status code
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            // 3. unwrap the data object
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // 4. validate that the status code is in the 200 range otherwise it's a bad status code
            switch urlResponse.statusCode {
            case 200...299:
                break
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            
            // 5. capture data as a success case
            completion(.success(data))
            
        }
        
        dataTask.resume()
    }
}
