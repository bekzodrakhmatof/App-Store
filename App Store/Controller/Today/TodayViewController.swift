//
//  TodayViewController.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 26/06/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import UIKit

class TodayViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    let items = [
//        TodayItem.init(category: "THE DAILY LIST", title: "Test-Drive These CarPlay Apps", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple),
//        TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently orginize your life the right way.", backgroundColor: .white, cellType: .single),
//        TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Travel without your packet so it will be easy to capture", backgroundColor: #colorLiteral(red: 0.9837816358, green: 0.9648348689, blue: 0.7342819571, alpha: 1), cellType: .single)
//    ]
    var items = [TodayItem]()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()

        fetchData()
        
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = #colorLiteral(red: 0.9537332654, green: 0.9488452077, blue: 0.9571188092, alpha: 1)
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)

    }
    
    fileprivate func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        var topGrossingGroup: AppGroup?
        var gamesGroup: AppGroup?
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, error) in
            
            // Check error
            topGrossingGroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, error) in
            
            gamesGroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            // I will have access
            self.activityIndicatorView.stopAnimating()
            
            self.items = [
                TodayItem.init(category: "Daily List", title: topGrossingGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topGrossingGroup?.feed.results ?? []),
                TodayItem.init(category: "Daily List", title: gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently orginize your life the right way.", backgroundColor: .white, cellType: .multiple, apps: gamesGroup?.feed.results ?? []),
                TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Travel without your packet so it will be easy to capture", backgroundColor: #colorLiteral(red: 0.9837816358, green: 0.9648348689, blue: 0.7342819571, alpha: 1), cellType: .single, apps: [])
            ]
            
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    var appFullScreenController: AppFullScreenController!
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if items[indexPath.item].cellType == .multiple {
            
            let fullController = TodayMultipleAppsViewController(mode: .fullcreen)
            fullController.results = self.items[indexPath.item].apps
            present(fullController, animated: true)
            return
        }
        
        let appFullScreenController = AppFullScreenController()
    
        appFullScreenController.todayItem = items[indexPath.row]
        appFullScreenController.dismissHandler = {
            self.handleRemoveRedView()
        }
        
        let fullScreenView = appFullScreenController.view!
        view.addSubview(fullScreenView)
        addChild(appFullScreenController)
        
        self.appFullScreenController = appFullScreenController
        fullScreenView.layer.cornerRadius = 16
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.isUserInteractionEnabled = false
        
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        
        topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()

            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
            
        }, completion: nil)
    }
     
    @objc func handleRemoveRedView() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.appFullScreenController.tableView.contentOffset = .zero
            guard let startingFrame = self.startingFrame else { return }
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = .identity
            
            guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 24
            cell.layoutIfNeeded()
        }, completion: { _ in
            
            self.appFullScreenController.view.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
    
    var startingFrame: CGRect?
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //multiple app cell
        
        let cellID = items[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! BaseTodayCell
        
        cell.todayItem = items[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    
    static let cellSize: CGFloat = 500
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width - 48, height: TodayViewController.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
