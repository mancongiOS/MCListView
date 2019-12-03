//
//  ViewController.swift
//  MCListView
//
//  Created by 562863544@qq.com on 11/29/2019.
//  Copyright (c) 2019 562863544@qq.com. All rights reserved.
//

import UIKit
import MCListView
import MJRefresh

class ViewController: UIViewController {

    private var numberCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        title = "使用示例"
        
        view.addSubview(tableView)
    }

    lazy var tableView = MCTableView.mc_make(registerCell: UITableViewCell.self, delegate: self).then {
        $0.frame = self.view.frame
        $0.rowHeight = 60
    }
    
    lazy var dataArray: [String] = [
        "进入就展示空页面，加载处理空页面",
        "进入不展示空页面，加载处理空页面",
        "有事件处理的空页面",
        "关于有headerView的空页面的处理",
        "处理无网络页面",
        "CollectionView的使用和TableView的一致",
        "CollectionView瀑布流",
        "CollectionView居左cell",
    ]
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.mc_makeCell(indexPath: indexPath)
        
        cell.backgroundColor = UIColor.groupTableViewBackground
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = OneViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            let vc = TwoViewController()
            navigationController?.pushViewController(vc, animated: true)
         
        case 2:
            let vc = ThreeViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = FourViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case 4:
            let vc = NoNetworkViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case 5:
            let vc = CollectionViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = WaterfallLayoutViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case 7:
            let vc = LeftLayoutViewController()
            navigationController?.pushViewController(vc, animated: true)
          
            
            
        default:
            break
        }
    }
}

