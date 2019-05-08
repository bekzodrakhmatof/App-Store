//
//  SearchViewController.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 06/05/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellID = "searchCellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellID)
        
        fetchItunesApps()
    }
    
    fileprivate func fetchItunesApps() {
        
        let urlSring = "https://itunes.apple.com/search?term=jack+johnson"
        guard let url = URL(string: urlSring) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // ERROR
            if let error = error {
                print("Failed to fetcg apps: ", error)
                return
            }
            
            // SUCCESS
            guard let data = data else { return }
            
            do {
                
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                searchResult.results.forEach({print($0.trackName, $0.primaryGenreName)})
                
            } catch {
                
                print("Failed to decode json: ", error)
            }
            
            
        }.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultCell
        
        cell.nameLabel.text = "Here is my app name"
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
