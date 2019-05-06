//
//  BaseTabBarController.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 06/05/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavigationController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
            createNavigationController(viewController: UIViewController(), title: "Apps", imageName: "apps"),
            createNavigationController(viewController: SearchViewController(), title: "Search", imageName: "search")
        ]
    }
    
    fileprivate func createNavigationController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
       
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(named: imageName)
    
        return navigationController
    }
}
