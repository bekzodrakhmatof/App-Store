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
    let bodyLabel    = UILabel(text: "Review body\nReview body\nReview body", font: .systemFont(ofSize: 18), numberOfLines: 5)
    
    let starsStackView: UIStackView = {
        var arrangedSubview = [UIView]()
        
        (0..<5).forEach({ (_) in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubview.append(imageView)
        })
        
        arrangedSubview.append(UIView())
        
        return UIStackView(arrangedSubviews: arrangedSubview)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9498137832, green: 0.9447888732, blue: 0.982111752, alpha: 1)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                titleLabel,
                aurthorLabel
                ], customSpacing: 8),
            starsStackView,
            bodyLabel
            ], spacing: 12)
        
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        aurthorLabel.textAlignment = .right
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
