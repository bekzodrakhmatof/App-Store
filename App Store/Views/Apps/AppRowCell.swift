//
//  AppRowCell.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 09/05/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    
    let nameLabel = UILabel(text: "App name", font: .systemFont(ofSize: 16))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    let getButton = UIButton(title: "GET")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.constrainHeight(constant: 32)
        getButton.constrainWidth(constant: 80)
        getButton.layer.cornerRadius = 16
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView, VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4), getButton
            ])
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
