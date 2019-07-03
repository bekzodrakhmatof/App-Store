//
//  TodayItem.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 02/07/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import UIKit

struct TodayItem {
    
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    
    let cellType: CellType
    
    enum CellType: String {
        case single, multiple
    }
}
