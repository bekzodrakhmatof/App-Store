//
//  MusicController.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 21/07/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import UIKit

class MusicController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellID = "trackCellID"
    fileprivate let footerID = "footerID"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(TrackCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(MusicLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
        fetchData()
    }
    
    var results = [Result]()
    fileprivate let searchTerm = "taylor"
    
    fileprivate func fetchData() {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=20"
        Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, error) in
            
            if let error = error {
                print("Failed to fetch data: ", error)
            }
            
            searchResult?.results.forEach({ (result) in
                print(result.trackName)
            })
            self.results = searchResult?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerID, for: indexPath)
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        let height: CGFloat = isDonePaginating ? 0 : 100
        
        return .init(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return results.count
    }
    
    var isPaginating = false
    var isDonePaginating = false
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TrackCell
        let track = results[indexPath.item]
        cell.nameLabel.text = track.trackName
        cell.imageView.sd_setImage(with: URL(string: track.artworkUrl100))
        cell.subtitleLabel.text = "\(track.artistName ?? "") • \(track.collectionName ?? "")"
        
        if indexPath.item == results.count - 1  && !isPaginating && !isDonePaginating {
            
            print("Fetch more data")
            
            isPaginating = true
            
            let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(results.count)&limit=20"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, error) in
                
                if let error = error {
                    print("Failed to fetch data: ", error)
                    self.isDonePaginating = true
                }
                
                if searchResult?.results.count == 0 {
                    
                    self.isDonePaginating = true
                }
                
                sleep(1)
                
                searchResult?.results.forEach({ (result) in
                    print(result.trackName)
                })
                self.results += searchResult?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                self.isPaginating = false
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 100)
    }
}
