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
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleCloseButton() {
        
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode == .fullcreen {
            
            setupCloseButton()
        } else {
            collectionView.isScrollEnabled = false
        }
    
        collectionView.backgroundColor = .white
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellID)
        
    }
    
    override var prefersStatusBarHidden: Bool { return true}
    
    func setupCloseButton() {
        
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if mode == .fullcreen {
            return .init(top: 12, left: 24, bottom: 12, right: 24)
        }
        
        return .zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if mode == .fullcreen {
            return results.count
        } else {
            return min(4, results.count)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MultipleAppCell
        cell.app = self.results[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if mode == .fullcreen {
            
            let height: CGFloat = 68
            return .init(width: view.frame.width - 48, height: height)
        }
        
        let height: CGFloat = (view.frame.height - 3 * spacing) / 4
        return .init(width: view.frame.width, height: height)
    }
    
    fileprivate let spacing: CGFloat = 16
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    fileprivate let mode: Mode
    
    enum Mode {
        case small, fullcreen
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
