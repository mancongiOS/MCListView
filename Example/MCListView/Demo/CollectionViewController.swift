//
//  CollectionViewController.swift
//  MCListView_Example
//
//  Created by 满聪 on 2019/11/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MCListView

class CollectionViewController: UIViewController {

    private var numberCount: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        view.addSubview(collectionView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "清空数据", style: UIBarButtonItemStyle.done, target: self, action: #selector(cleanDataEvent))
                
        collectionView.deHeader { [weak self] in
            self?.numberCount = 1
            self?.getData()
        }
        
        collectionView.deFooter { [weak self] in
            self?.numberCount += 1
            self?.getData()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.mj_header.beginRefreshing()
    }
    

    

    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.init(top: 15, left: 15, bottom: 0, right: 15)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .vertical
        return layout
    }()

    
    lazy var collectionView = MCCollectionView.mc_make(registerCell: UICollectionViewCell.self, delegate: self, layout: layout).then {
        $0.setEmptyUI(type: .defaultType)
        $0.frame = self.view.frame
        $0.backgroundColor = UIColor.white
    }
    
    lazy var dataArray: [String] = []
}


//MARK: 代理方法
extension CollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let WH = (UIScreen.main.bounds.size.width - 35)/2
        return CGSize.init(width: WH, height: WH)

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.mc_makeCell(indexPath: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
}


extension CollectionViewController {
    
    @objc func cleanDataEvent() {
        dataArray.removeAll()
        collectionView.mc_reloadData()
    }
    
    func getData() {
        
        if numberCount == 1 {
            dataArray.removeAll()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            for item in 0..<10 {
                self.dataArray.append("第" + String(item + self.numberCount*10) + "行")
            }
            self.collectionView.mj_header.endRefreshing()
            self.collectionView.mj_footer.endRefreshing()

            self.collectionView.mc_reloadData()
        }
        
    }
}
