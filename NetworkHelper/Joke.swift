//
//  Joke.swift
//  NetworkHelper
//
//  Created by Kelby Mittan on 12/6/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation


// encodable is encoding data to send to a web api
// decodable is decoding JSON or other data from the web
struct Joke: Decodable {
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}
