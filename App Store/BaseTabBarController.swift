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

        let redViewController = UIViewController()
        redViewController.view.backgroundColor = .white
        redViewController.navigationItem.title = "Apps"
        
        let redNavigationController = UINavigationController(rootViewController: redViewController)
        redNavigationController.tabBarItem.title = "Apps"
        redNavigationController.tabBarItem.image = #imageLiteral(resourceName: "apps")
        redNavigationController.navigationBar.prefersLargeTitles = true
        
        let blueViewController = UIViewController()
        blueViewController.view.backgroundColor = .white
        blueViewController.navigationItem.title = "Search"
        
        let blueNavigationViewController = UINavigationController(rootViewController: blueViewController)
        blueNavigationViewController.tabBarItem.title = "Search"
        blueNavigationViewController.tabBarItem.image = #imageLiteral(resourceName: "search")
        blueNavigationViewController.navigationBar.prefersLargeTitles = true
        
        viewControllers = [
            redNavigationController,
            blueNavigationViewController
        ]
    }
}
