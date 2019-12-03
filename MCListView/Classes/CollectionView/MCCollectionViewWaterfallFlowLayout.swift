//
//  UICollectionViewWaterfallFlowLayout.swift
//  MCComponentExtension
//
//  Created by 满聪 on 2019/6/22.
//

import Foundation

import UIKit

public protocol MCCollectionViewWaterfallFlowLayoutDataSource: NSObjectProtocol {
    
    /// 获取item的高度
    func waterfallLayout(_ layout : MCCollectionViewWaterfallFlowLayout, heightForRowAt indexPath : IndexPath) -> CGFloat
    /// 需要展示多少列
    func waterfallLayout(columnCountOfLayout layout : MCCollectionViewWaterfallFlowLayout) -> Int
}


public class MCCollectionViewWaterfallFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: 对外提供属性
    public weak var dataSource : MCCollectionViewWaterfallFlowLayoutDataSource?
    
    
    //存放所有cell的布局属性
    lazy var attrsArray = [UICollectionViewLayoutAttributes]()
    //存放所有列的当前高度
    lazy var columnHeightsAry = [CGFloat]()
    
    /// 第一步 ：初始化
    override public func prepare() {
        super.prepare()
        
        let edgeInsets = sectionInset
        
        //清除高度
        columnHeightsAry.removeAll()
        
        let columnCount =  self.dataSource?.waterfallLayout(columnCountOfLayout: self) ?? 2
        for _ in 0 ..< columnCount {
            columnHeightsAry.append(edgeInsets.top)
        }
        
        //清除所有的布局属性
        attrsArray.removeAll()
        
        let sections: Int = (self.collectionView?.numberOfSections) ?? 1
        
        for num in 0 ..< sections {
            //获取分区0有多少个item
            let count : Int = (self.collectionView?.numberOfItems(inSection: num)) ?? 0
            for i in 0 ..< count {
                let indexpath: IndexPath = IndexPath.init(item: i, section: num)
                let attrs = self.layoutAttributesForItem(at: indexpath)!
                attrsArray.append(attrs)
            }
        }
    }
    
    
    ///第二步 ：返回indexPath位置cell对应的布局属性
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attrs = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        let collectionWidth = self.collectionView?.frame.size.width
        
        
        let columnCount =  self.dataSource?.waterfallLayout(columnCountOfLayout: self) ?? 2
        let itemMargin = minimumLineSpacing
        let columnMargin = minimumInteritemSpacing
        let edgeInsets = sectionInset
        
        
        //获得所有item的宽度
        let itemW = (collectionWidth! - edgeInsets.left - edgeInsets.right - CGFloat(columnCount-1) * columnMargin) / CGFloat(columnCount)
        let itemH = dataSource?.waterfallLayout(self, heightForRowAt: indexPath) ?? 100
        
        //找出高度最短那一列
        var dextColum : Int = 0
        var mainH = columnHeightsAry[0]
        
        for i in 1 ..< columnCount {
            //取出第i列的高度
            let columnH = columnHeightsAry[i]
            
            if mainH > columnH {
                mainH = columnH
                dextColum = i
            }
        }
        
        let x = edgeInsets.left + CGFloat(dextColum) * (itemW + columnMargin)
        var y = mainH
        
        if y != edgeInsets.top {
            y = y + itemMargin
        }
        attrs.frame = CGRect(x: x, y: y, width: itemW, height: CGFloat(itemH))
        //更新最短那列高度
        columnHeightsAry[dextColum] = attrs.frame.maxY
        return attrs
    }
    
    //第三步 ：重写  返回所有列的高度
    override public var collectionViewContentSize: CGSize {
        
        
        let columnCount =  self.dataSource?.waterfallLayout(columnCountOfLayout: self) ?? 2
        let edgeInsets = sectionInset
        
        var maxHeight = columnHeightsAry[0]
        
        for i in 1 ..< columnCount {
            let columnHeight = columnHeightsAry[i]
            
            if maxHeight < columnHeight {
                maxHeight = columnHeight
            }
        }
        
        return CGSize.init(width: 0, height: maxHeight + edgeInsets.bottom)
    }
    
    //第四步 ：返回collection的item的frame
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return attrsArray
    }
}
