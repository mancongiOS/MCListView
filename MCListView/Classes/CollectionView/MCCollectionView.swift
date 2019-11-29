//
//  UICollectionView+Extension.swift
//  MCListView
//
//  Created by 满聪 on 2019/4/18.
//

import UIKit

public class MCCollectionView: UICollectionView {
       
    public func mc_reloadData() {
        super.reloadData()
        
        let sections = self.numberOfSections
                
        var isHiddenEmtpy: Bool = false
        
        for i in 0..<sections {
            let rows = self.numberOfItems(inSection: i)
            if rows > 0 {
                isHiddenEmtpy = true
                break
            } else {
                isHiddenEmtpy = false
            }
        }
        self.emptyView.isHidden = isHiddenEmtpy
    }

    
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = UIColor.white
        self.backgroundView = self.emptyView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if let temp = superview {
            temp.addSubview(noNotworkView)
        }
    }

    
    /// 展示空数据UI
    public func showBackground() {
        self.emptyView.isHidden = false
    }
    
    /// 隐藏空数据UI
    public func hideBackground() {
        self.emptyView.isHidden = true
    }
    
    
    
    public lazy var emptyView: MCEmptyView = {
        let view = MCEmptyView()
        view.frame = frame
        view.isHidden = true
        return view
    }()
    
    public lazy var noNotworkView: MCEmptyView = {
        let view = MCEmptyView()
        view.isHidden = true
        view.frame = frame
        view.backgroundColor = UIColor.white
        
        let image = Bundle.loadImage("noNetwork", from: "MCListViewBundle", in: "MCListView")

        view.textLabel.text = "网络竟然崩溃了"
    
        view.imageView.image = image
        return view
    }()
}


extension MCCollectionView {
    
    
    /// MCCollectionView的构造方法
    ///
    /// - Parameters:
    ///   - cell: 要注册的cell.type
    ///   - header: 要注册的header.type
    ///   - footer: 要注册的footer.type
    ///   - delegate: 代理
    ///   - layout: layout
    /// - Returns: MCCollectionView
    public static func mc_make<T: UICollectionViewCell, X: UICollectionReusableView> (
        registerCell cell: T.Type,
        registerHeader header: X.Type? = nil,
        registerFooter footer: X.Type? = nil,
        delegate: Any,
        layout: UICollectionViewFlowLayout
        ) -> MCCollectionView {
        
        
        let co = MCCollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        co.delegate = delegate as? UICollectionViewDelegate
        co.dataSource = delegate as? UICollectionViewDataSource
        co.showsHorizontalScrollIndicator = false
        co.showsVerticalScrollIndicator = false
        co.mc_registerCell(cell)
        
        if header != nil {
            co.mc_registerSectionHeader(header!)
        }
        
        if footer != nil {
            co.mc_registerSectionFooter(footer!)
        }

        return co
    }
}



extension MCCollectionView {
    /// 提前注册cell
    public func mc_registerCell<T: UICollectionViewCell>(_: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: getClassName(T.classForCoder()))
    }
    
    /// 提前注册SectionHeader
    public func mc_registerSectionHeader<T: UICollectionReusableView>(_: T.Type) {
        
        self.register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: getClassName(T.classForCoder()))
    }
    
    /// 提前注册SectionFooter
    public func mc_registerSectionFooter<T: UICollectionReusableView>(_: T.Type) {
        
        self.register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: getClassName(T.classForCoder()))
    }
}


extension UICollectionView {
    
    /// 获取复用的cell
    public func mc_makeCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        let identifier = getClassName(T.classForCoder())
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            return T()
        }
        
        return cell
    }
    
    /// 获取复用的 SectionHeader
    public func mc_makeSectionHeader<T: UICollectionReusableView>(indexPath: IndexPath) -> T {
        let identifier = getClassName(T.classForCoder())
        
        guard let header = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier, for: indexPath) as? T else { return T() }
        return header
    }
    
    
    /// 获取复用的 SectionFooter
    public func mc_makeSectionFooter<T: UICollectionReusableView>(indexPath: IndexPath) -> T {
        let identifier = getClassName(T.classForCoder())
        
        guard let header = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier, for: indexPath) as? T else { return T() }
        return header
    }

}


private func getClassName(_ obj:Any) -> String {
    let mirro = Mirror(reflecting: obj)
    let className = String(describing: mirro.subjectType).components(separatedBy: ".").first!
    return className
}
