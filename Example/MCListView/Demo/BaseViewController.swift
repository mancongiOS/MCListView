//
//  BaseViewController.swift
//  MCListView_Example
//
//  Created by 满聪 on 2019/11/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

import MCListView
import MJRefresh
import Then

class BaseViewController: UIViewController {

    private var numberCount: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "清空数据", style: UIBarButtonItemStyle.done, target: self, action: #selector(cleanDataEvent))
                
        tableView.deHeader { [weak self] in
            self?.numberCount = 1
            self?.getData()
        }
        
        tableView.deFooter { [weak self] in
            self?.numberCount += 1
            self?.getData()
        }
        
        
        tableView.emptyView.isHidden = false
        tableView.emptyView.eventClosure = {
            print("点击按钮")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.mj_header.beginRefreshing()
    }
    

    lazy var tableView = MCTableView.mc_make(registerCell: UITableViewCell.self, delegate: self).then {
        $0.frame = self.view.frame
        $0.rowHeight = 60
    }
    
    lazy var dataArray: [String] = []
}


extension BaseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.mc_makeCell(indexPath: indexPath)
        
        cell.backgroundColor = UIColor.groupTableViewBackground
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
}



extension BaseViewController {
    
    @objc func cleanDataEvent() {
        dataArray.removeAll()
        tableView.mc_reloadData()
    }
    
    func getData() {
        
        if numberCount == 1 {
            dataArray.removeAll()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            for item in 0..<10 {
                self.dataArray.append("第" + String(item + self.numberCount*10) + "行")
            }
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()

            self.tableView.mc_reloadData()
        }
        
    }
}
