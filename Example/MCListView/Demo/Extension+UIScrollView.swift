//
//  Extension+UIScrollView.swift
//  Design
//
//  Created by 满聪 on 2019/7/16.
//  Copyright © 2019 MC. All rights reserved.
//

import Foundation

import MJRefresh


// TODO: - MJRefresh 方法封装
extension UIScrollView {
    
    
    /// 添加下拉刷新控件
    public func deHeader(refreshingBlock: @escaping (() -> ())) {
        self.mj_header = MJRefreshNormalHeader.init(refreshingBlock: refreshingBlock)
    }
    
    /// 停止下拉刷新
    public func deHeaderEnd() {
        if self.mj_header != nil {
            self.mj_header.endRefreshing()
        }
    }
    
    
    /// 添加上拉加载控件
    public func deFooter(refreshingBlock: @escaping (() -> ())) {
        let footer = MJRefreshBackGifFooter.init(refreshingBlock: refreshingBlock)
        footer?.stateLabel.textColor = UIColor.gray
        footer?.stateLabel.font = UIFont.systemFont(ofSize: 15)
        footer?.setTitle(" 已经到底了 ", for: .noMoreData)
        self.mj_footer = footer
    }
    
    /// 停止上拉加载
    public func deFooterEnd() {
        if self.mj_footer != nil {
            self.mj_footer.endRefreshing()
        }
    }
    
    /// 显示没有更多数据
    public func deFooterNoMoreData() {
        if self.mj_footer != nil {
            self.mj_footer.endRefreshingWithNoMoreData()
        }
    }
    
    public func deResetNoMoreData() {
        if self.mj_footer != nil {
            self.mj_footer.resetNoMoreData()
        }
    }
}



