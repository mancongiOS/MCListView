//
//  MCWaterfallLayoutViewController.swift
//  MCComponentPublicUI_Example
//
//  Created by 满聪 on 2019/6/22.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

import MCListView

class WaterfallLayoutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.frame = view.frame
    }
    
    
    lazy var layout: MCCollectionViewWaterfallFlowLayout = {
        let layout = MCCollectionViewWaterfallFlowLayout()
        layout.dataSource = self
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)

        return layout
    }()
    
    lazy var collectionView = MCCollectionView.mc_make(registerCell: UICollectionViewCell.self, delegate: self, layout: layout)
}


extension WaterfallLayoutViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.mc_makeCell(indexPath: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        cell.backgroundColor = UIColor.orange
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "第" + String(indexPath.row) + "个"
        label.frame = CGRect.init(x: 5, y: 10, width: 100, height: 60)
        cell.contentView.addSubview(label)
        

        return cell
    }
    
}

extension WaterfallLayoutViewController : MCCollectionViewWaterfallFlowLayoutDataSource {
    
    /// itemwidth会根据column的值自动计算出来
    func waterfallLayout(columnCountOfLayout layout: MCCollectionViewWaterfallFlowLayout) -> Int {
        return 2
    }
    
    func waterfallLayout(_ layout: MCCollectionViewWaterfallFlowLayout, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random_uniform(200) + 100)
    }
}
