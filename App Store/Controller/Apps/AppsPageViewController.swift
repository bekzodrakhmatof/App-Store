//
//  AppsViewController.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 09/05/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import UIKit

class AppsPageViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "AppsCellID"
    let headerID = "HeaderID"
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.register(AppsPageHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchData()
    }
    
    var groups = [AppGroup]()
    var socialApps = [SocialApp]()
    
    fileprivate func fetchData() {
        
        var group1: AppGroup?
        var group2: AppGroup?
        var group3: AppGroup?
        var group4: AppGroup?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        Service.shared.fetchGames { (appGroup, error) in
            
            dispatchGroup.leave()
            group1 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, error) in
            dispatchGroup.leave()
            group2 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchNewApps { (appGroup, error) in
            dispatchGroup.leave()
            group3 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopPaid { (appGroup, error) in
            dispatchGroup.leave()
            group4 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (apps, error) in
            dispatchGroup.leave()
            self.socialApps = apps ?? []
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Completed your dispatch group task...")
            
            if let group = group1 {
                self.groups.append(group)
            }
            
            if let group = group2 {
                self.groups.append(group)
            }
            
            if let group = group3 {
                self.groups.append(group)
            }
            
            if let group = group4 {
                self.groups.append(group)
            }
            
            self.collectionView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! AppsPageHeaderView
        header.appHeaderHorizontalController.socialApps = self.socialApps
        header.appHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppsGroupCell
        
        let appGroup = groups[indexPath.item]
        
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroup = appGroup
        cell.horizontalController.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
