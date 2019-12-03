//
//  NoNetworkViewController.swift
//  MCListView_Example
//
//  Created by 满聪 on 2019/11/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class NoNetworkViewController:  BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "无网络处理"
        
        tableView.showNoNetwork()
        
        tableView.noNotworkView.eventClosure = {
            self.tableView.hideNoNetwork()
        }
    }
}
