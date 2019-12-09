//
//  JokeAPIClient.swift
//  NetworkHelper
//
//  Created by Kelby Mittan on 12/6/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation



struct JokeAPIClient {
    
    
    static func getJokes(completion: @escaping (Result<[Joke], AppError>) -> ()) {
        
        let url = "https://official-joke-api.appspot.com/jokes/programming/ten"
        
        NetworkHelper.shared.performDataTask(with: url) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                do {
                    let jokes = try JSONDecoder().decode([Joke].self, from: data)
                    completion(.success(jokes))
                } catch {
                    print(error)
                }
            }
        }
    }
}
