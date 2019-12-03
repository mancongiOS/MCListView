//
//  OneViewController.swift
//  MCListView_Example
//
//  Created by 满聪 on 2019/11/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class OneViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "进入就展示空数据"
        
        tableView.setEmptyUI(type: .message)
    }
}
