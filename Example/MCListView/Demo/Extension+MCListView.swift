//
//  Extension+MCListView.swift
//  MCListView_Example
//
//  Created by 满聪 on 2019/11/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

import MCListView

protocol MCTableViewEmptyData {
    func setEmptyUI(type: DEEmptyListType)
}

public enum DEEmptyListType {
    
    /// 无网络页面
    case noNetwork
    
    /// 不显示空页面
    case no
    
    /// 关注列表
    case attention
    
    /// 某个列表(消息列表)的空页面
    case message
    
    /// 某个列表(购物车)的空页面
    case shoppingCart
    /// 默认的空页面
    case defaultType
}

extension MCTableView: MCTableViewEmptyData {
    func setEmptyUI(type: DEEmptyListType) {
        emptyUI(type: type, emptyView: self.emptyView)
    }
    
    func showNoNetwork() {
        noNotworkView.textLabel.text = "暂无网络"
        noNotworkView.eventButton.setTitle("重新加载", for: .normal)
        noNotworkView.eventButton.isHidden = false
        noNotworkView.isHidden = false
    }
    
    func hideNoNetwork() {
        noNotworkView.isHidden = true
    }
}


extension MCCollectionView: MCTableViewEmptyData {
    func setEmptyUI(type: DEEmptyListType) {
        emptyUI(type: type, emptyView: self.emptyView)
    }
    
    func showNoNetwork() {
        noNotworkView.textLabel.text = "暂无网络"
        noNotworkView.eventButton.setTitle("重新加载", for: .normal)
        noNotworkView.isHidden = false
    }
    
    func hideNoNetwork() {
        noNotworkView.isHidden = true
    }
}


fileprivate func emptyUI(type: DEEmptyListType, emptyView: MCEmptyView) {
    emptyView.isHidden = false
    emptyView.eventButton.isHidden = true

    emptyView.imageMargin = 220
    emptyView.textMargin = 10
    emptyView.buttonMargin = 40
    emptyView.buttonSize = CGSize.init(width: 200, height: 40)
    switch type {
      
    case .no:
        emptyView.imageView.isHidden = true
        emptyView.textLabel.isHidden = true
        emptyView.eventButton.isHidden = true

    case .attention:
        emptyView.isHidden = false
        emptyView.eventButton.isHidden = false
        emptyView.imageView.image = UIImage.init(named: "Empty_attention")
        emptyView.textLabel.text = "未关注任何人"
        emptyView.eventButton.setTitle("去关注", for: .normal)

    case .message:
        emptyView.isHidden = false
        emptyView.eventButton.isHidden = true
        emptyView.imageView.image = UIImage.init(named: "Empty_searchResult")
        emptyView.textLabel.text = "暂无搜索内容"
        
    case .shoppingCart:
        emptyView.isHidden = true
        emptyView.eventButton.isHidden = true
        emptyView.imageView.image = UIImage.init(named: "Empty_shoppingCart")
        emptyView.textLabel.text = "暂无购物车数据"
        
        
    default:
        emptyView.imageView.image = UIImage.init(named: "Empty_searchResult")
        emptyView.textLabel.text = "暂无数据"
        break
    }
}

