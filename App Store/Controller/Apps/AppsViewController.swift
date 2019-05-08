//
//  AppsViewController.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 09/05/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import UIKit

class AppsViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "AppsCellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 250)
    }
}
