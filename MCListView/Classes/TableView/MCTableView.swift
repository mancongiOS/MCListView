//
//  UITableView+Extension.swift
//  GMJKPublicUI
//
//  Created by 满聪 on 2019/4/18.
//

import UIKit

public class MCTableView: UITableView {
        
    
    public func mc_reloadData() {
        super.reloadData()
        
        let sections = self.numberOfSections
        
        var isHiddenEmtpy: Bool = false
        
        for i in 0..<sections {
            let rows = self.numberOfRows(inSection: i)
            if rows > 0 {
                isHiddenEmtpy = true
                break
            } else {
                isHiddenEmtpy = false
            }
        }
        
        self.emptyView.isHidden = isHiddenEmtpy
    }
    
    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        separatorStyle = UITableViewCell.SeparatorStyle.none
        backgroundColor = UIColor.white
        
        estimatedRowHeight = 0
        estimatedSectionFooterHeight = 0
        estimatedSectionHeaderHeight = 0
        
        backgroundView = self.emptyView
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        

    /// 展示背景  空数据UI展示
    private func showBackground() {
        self.emptyView.isHidden = false
    }

    /// 隐藏背景  空数据UI隐藏
    private func hideBackground() {
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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if let temp = superview {
            temp.addSubview(noNotworkView)
        }
    }
}

extension MCTableView {
    
    
    /// MCTableView的构建方法
    ///
    /// - Parameters:
    ///   - cell: 要注册的cell
    ///   - delegate: 遵循代理
    ///   - style: plain & grouped
    /// - Returns: JKTableView
    public static func mc_make <T: UITableViewCell,X: UIView> (
        registerCell cell: T.Type,
        registerHeader header: X.Type? = nil,
        registerFooter footer: X.Type? = nil,
        delegate: Any,
        style: UITableView.Style = .plain) -> MCTableView {
        let tb = MCTableView.init(frame: .zero, style: style)
        tb.delegate = delegate as? UITableViewDelegate
        tb.dataSource = delegate as? UITableViewDataSource
        tb.mc_register(cell)
        
        if header != nil {
            tb.mc_registerSectionHeader(header!)
        }
        
        if footer != nil {
            tb.mc_registerSectionFooter(footer!)
        }
        
        return tb
    }
}



extension UITableView {
    /// 提前注册cell
    public func mc_register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: getClassName(T.classForCoder()))
    }
    
    /// 提前注册sectionHeader
    public func mc_registerSectionHeader<T: UIView>(_: T.Type) {
        let identifier = getClassName(T.classForCoder())
        register(T.self, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    /// 提前注册sectionFooter
    public func mc_registerSectionFooter<T: UIView>(_: T.Type) {
        let identifier = getClassName(T.classForCoder())
        register(T.self, forHeaderFooterViewReuseIdentifier: identifier)
    }
}

extension UITableView {
    
    /// 获取cell
    public func mc_makeCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        let identifier = getClassName(T.classForCoder())
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            return T()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    /// 获取复用的 SectionHeader
    public func mc_makeSectionHeader<T: UITableViewHeaderFooterView>(_: T.Type) -> T {
        let identifier = getClassName(T.classForCoder())
        guard let header = dequeueReusableHeaderFooterView(withIdentifier: identifier)  as? T else { return T() }
        return header
    }
    
    /// 获取复用的 SectionFooter
    public func mc_makeSectionFooter<T: UITableViewHeaderFooterView>(_: T.Type) -> T {
        let identifier = getClassName(T.classForCoder())
        guard let footer = dequeueReusableHeaderFooterView(withIdentifier: identifier)  as? T else { return T() }
        return footer
    }
    
}


fileprivate func getClassName(_ obj:Any) -> String {
    let mirro = Mirror(reflecting: obj)
    let className = String(describing: mirro.subjectType).components(separatedBy: ".").first!
    return className
}
