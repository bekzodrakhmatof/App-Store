//
//  HorizontalSnappingController.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 20/06/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import UIKit

class HozirontalSnappingController: UICollectionViewController {
    
    init() {
        
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
