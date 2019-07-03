//
//  TodayMultipleAppsViewController.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 03/07/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import UIKit

class TodayMultipleAppsViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "cellID"
    var results = [FeedResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.isScrollEnabled = false
        Service.shared.fetchGames { (appGroup, error) in
            self.results = appGroup?.feed.results ?? []
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, results.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MultipleAppCell
        cell.app = self.results[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat = (view.frame.height - 3 * spacing) / 4
        
        return .init(width: view.frame.width, height: height)
    }
    
    fileprivate let spacing: CGFloat = 16
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
