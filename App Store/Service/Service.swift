//
//  Service.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 08/05/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        
        let urlSring = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlSring) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // ERROR
            if let error = error {
                print("Failed to fetcg apps: ", error)
                completion([], error)
                return
            }
            
            // SUCCESS
            guard let data = data else { return }
            
            do {
                
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)

                completion(searchResult.results, nil)
                
            } catch {
                
                print("Failed to decode json: ", error)
                completion([], error)
            }
            
            
            }.resume()
    }
    
    func fetchNewApps(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopFree(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopPaid(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free-ipad/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    
    
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self , from: data!)
                completion(appGroup, nil)
            } catch {
                completion(nil, error)
                print("Failed to decode: ", error)
            }
            }.resume()
    }
    
    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
        
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            do {
                let objects = try JSONDecoder().decode([SocialApp].self , from: data!)
                completion(objects, nil)
            } catch {
                completion(nil, error)
                print("Failed to decode: ", error)
            }
            }.resume()
    }
}
