//
//  MCLeftLayoutViewController.swift
//  MCComponentPublicUI_Example
//
//  Created by 满聪 on 2019/6/22.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MCListView

class LeftLayoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.frame = view.frame
    }

    
    lazy var layout: MCCollectionViewLeftFlowLayout = {
        let layout = MCCollectionViewLeftFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    
    lazy var collectionView = MCCollectionView.mc_make(registerCell: UICollectionViewCell.self, delegate: self, layout: layout)
}


extension LeftLayoutViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        label.frame = CGRect.init(x: 5, y: 0, width: 100, height: 44)
        cell.contentView.addSubview(label)
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        let height: CGFloat = 44
        
        let width: CGFloat = CGFloat(arc4random_uniform(200) + 110)
        
        
        return CGSize.init(width: width, height: height)
        
    }

}
