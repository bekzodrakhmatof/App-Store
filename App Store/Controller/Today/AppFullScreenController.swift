//
//  AppFullScreenController.swift
//  App Store
//
//  Created by Bekzod Rakhmatov on 26/06/2019.
//  Copyright © 2019 BekzodRakhmatov. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 450
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = UITableViewCell()
            let todayCell = TodayCell()
            cell.addSubview(todayCell)
            todayCell.centerInSuperview(size: .init(width: 250, height: 250))
            return cell
        }
        
        let cell = AppFullScreenDescriptionCell()
        return cell
    }
}
