//
//  FourViewController.swift
//  MCListView_Example
//
//  Created by 满聪 on 2019/12/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


import MCListView
import MJRefresh

class FourViewController: UIViewController {

    private var numberCount: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        tableView.tableHeaderView = headView
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "清空数据", style: UIBarButtonItem.Style.done, target: self, action: #selector(cleanDataEvent))
                
        tableView.deHeader { [weak self] in
            self?.numberCount = 1
            self?.getData()
        }
        
        tableView.deFooter { [weak self] in
            self?.numberCount += 1
            self?.getData()
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.mj_header.beginRefreshing()
    }
    
    
    lazy var headView: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.orange
        label.text = "这是一个headerView"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
        return label
    }()
    

    lazy var tableView = MCTableView.mc_make(registerCell: UITableViewCell.self, delegate: self).then {
        $0.frame = self.view.frame
        $0.rowHeight = 60
        $0.mc_registerCell(EmptyDataCell.self)
    }
    
    lazy var dataArray: [String] = []
}


extension FourViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dataArray.count == 0 {
            return 1
        } else {
            return dataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 如果没有数据源，加载一个空cell
        if dataArray.count == 0 {
            return 400
        } else {
            return 60
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataArray.count == 0 {
            let cell: EmptyDataCell = tableView.mc_makeCell(indexPath: indexPath)
            return cell
        }
        
        let cell: UITableViewCell = tableView.mc_makeCell(indexPath: indexPath)
        
        cell.backgroundColor = UIColor.groupTableViewBackground
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard dataArray.count != 0 else {
            return
        }
        
        print(indexPath.row)
    }
}



extension FourViewController {
    
    @objc func cleanDataEvent() {
        dataArray.removeAll()
        tableView.mc_reloadData()
    }
    
    func getData() {
        
        if numberCount == 1 {
            dataArray.removeAll()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()

            for item in 0..<10 {
                self.dataArray.append("第" + String(item + self.numberCount*10) + "行")
            }
            self.tableView.mc_reloadData()
        }
    }
}
