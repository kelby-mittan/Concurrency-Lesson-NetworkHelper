//
//  Podcast.swift
//  NetworkHelper
//
//  Created by Kelby Mittan on 12/6/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation

struct AppleSearchAPI: Decodable {
    let results: [Podcast]
}

struct Podcast: Decodable {
    let artistName: String
    let collectionName: String
}
