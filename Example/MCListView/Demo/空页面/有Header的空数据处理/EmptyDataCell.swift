//
//  DEEmptyDataCell.swift
//  Design
//
//  Created by 满聪 on 2019/10/13.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit
import MCListView

class EmptyDataCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white
        self.selectionStyle = .none
        
        
        self.addSubview(emptyView)
        emptyView.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var emptyView: MCEmptyView = {
        let view = MCEmptyView()
//        view.imageView.image = UIImage.init(named: "Empty_designs")
        view.textLabel.text = "暂无数据"
        view.eventButton.isHidden = true
        view.detailTextLabel.isHidden = true
        view.isHidden = false
        view.imageMargin = 30
        view.textMargin = 10

        return view
    }()
}
