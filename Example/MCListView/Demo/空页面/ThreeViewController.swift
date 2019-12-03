//
//  ThreeViewController.swift
//  MCListView_Example
//
//  Created by 满聪 on 2019/11/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ThreeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "关注列表"
        tableView.setEmptyUI(type: .attention)
        
        tableView.emptyView.eventClosure = {
            
            let alert = UIAlertController.init(title: "去关注人吧", message: nil, preferredStyle: .alert)
            
            let action = UIAlertAction.init(title: "我知道了", style: UIAlertAction.Style.cancel) { (_) in
                self.getData()
            }
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
    }
}
