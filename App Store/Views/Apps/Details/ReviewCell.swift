//
//  ReviewCell.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 25/06/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel   = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18))
    let aurthorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    let starsLabel   = UILabel(text: "Stars", font: .systemFont(ofSize: 16))
    let bodyLabel    = UILabel(text: "Review body\nReview body\nReview body", font: .systemFont(ofSize: 14), numberOfLines: 0)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9498137832, green: 0.9447888732, blue: 0.982111752, alpha: 1)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                titleLabel,
                UIView(),
                aurthorLabel
                ]),
            starsLabel,
            bodyLabel
            ], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
