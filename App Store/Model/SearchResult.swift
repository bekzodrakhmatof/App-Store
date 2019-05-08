//
//  SearchResult.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 08/05/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String
}
