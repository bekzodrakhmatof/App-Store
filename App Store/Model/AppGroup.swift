//
//  AppGroup.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 30/05/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
    
    let feed: Feed
}

struct Feed: Decodable {
    
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    
    let name, artistName, artworkUrl100: String
}
