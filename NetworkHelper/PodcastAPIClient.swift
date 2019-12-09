//
//  PodcastAPIClient.swift
//  NetworkHelper
//
//  Created by Kelby Mittan on 12/6/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation

struct PodcastAPIClient {
    static func getPodcasts(completion: @escaping (Result<[Podcast], AppError>) -> ()) {
        let endpointURLString = "https://itunes.apple.com/search?media=podcast&limit=200&term=swift"
        
        NetworkHelper.shared.performDataTask(with: endpointURLString) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searches = try JSONDecoder().decode(AppleSearchAPI.self, from: data)
                    let podcasts = searches.results
                    completion(.success(podcasts))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
