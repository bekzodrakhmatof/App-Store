//
//  AppsHorizontalHeaderViewController.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 09/05/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import UIKit

class AppsHorizontalHeaderViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellID = "AppsHeaderCollectionViewCell"
    
    var socialApps = [SocialApp]()
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        
        // Register cell classes
        self.collectionView!.register(AppHeaderCell.self, forCellWithReuseIdentifier: cellID)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.scrollDirection = .horizontal
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return socialApps.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppHeaderCell
        let app = socialApps[indexPath.item]
        cell.companyLabel.text = app.name
        cell.titleLabel.text = app.tagline
        cell.imageView.sd_setImage(with: URL(string: app.imageUrl))
        return cell
    }
}
