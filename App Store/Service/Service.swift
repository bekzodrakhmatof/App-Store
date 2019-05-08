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
    
    func fetchApps(completion: @escaping ([Result], Error?) -> ()) {
        
        let urlSring = "https://itunes.apple.com/search?term=instagram&entity=software"
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
}
