//
//  SearchResultCell.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 08/05/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    let appIconImageView: UIImageView = {
        
        let imgView = UIImageView()
        imgView.backgroundColor = .red
        imgView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imgView.layer.cornerRadius = 12
        return imgView
    }()
    
    let nameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "App name"
        return label
    }()
    
    let categoryLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Photoes & Videos"
        return label
    }()
    
    let ratingLabel: UILabel = {
        
        let label = UILabel()
        label.text = "9.25M"
        return label
    }()
    
    let getButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var screenshot1ImageView = self.screenshitImageView()
    lazy var screenshot2ImageView = self.screenshitImageView()
    lazy var screenshot3ImageView = self.screenshitImageView()
    
    func screenshitImageView() -> UIImageView {
        
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let infoTopStackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            VerticalStackView(arrangedSubviews: [
                nameLabel, categoryLabel, ratingLabel
                ]),
            getButton
            ])
        
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        let screenshotsStackView = UIStackView(arrangedSubviews: [
            screenshot1ImageView, screenshot2ImageView, screenshot3ImageView
            ])
        screenshotsStackView.spacing = 12
        screenshotsStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(arrangedSubviews: [
            infoTopStackView, screenshotsStackView
            ], spacing: 16)
    
        addSubview(overallStackView)
        
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
