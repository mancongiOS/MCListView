//
//  MCEmptyView.swift
//  GMMCPublicUI
//
//  Created by 满聪 on 2019/4/18.
//

import UIKit


public class MCEmptyView: UIView {
    
    /// 按钮事件回调
    public var eventClosure: (() -> Void)?
    
    /// 图片距顶部的距离
    public var imageMargin: CGFloat = 180
    /// 文字距离图片底部的距离
    public var textMargin: CGFloat = 20
    /// 详情文字距离文字底部的距离
    public var detailTextMargin: CGFloat = 0
    /// 按钮距离详情文字底部的距离
    public var buttonMargin: CGFloat = 40
    /// 按钮的大小
    public var buttonSize: CGSize = CGSize.init(width: 200, height: 40)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        self.addSubview(textLabel)
        self.addSubview(detailTextLabel)
        self.addSubview(eventButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        
        let imageSize = imageView.image?.size ?? CGSize.zero
        
        /// 对大图的处理
        
        let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        
        
        imageView.frame =  CGRect.init(x: (screenWidth - imageSize.width)/2, y: imageMargin, width: imageSize.width, height: imageSize.height)
        
        textLabel.frame = CGRect.init(x: 0, y: imageView.frame.maxY + textMargin, width: screenWidth, height: 30)
        
        detailTextLabel.frame = CGRect.init(x: 0, y: textLabel.frame.maxY + detailTextMargin, width: screenWidth, height: 20)

        
        eventButton.frame = CGRect.init(x: (screenWidth - buttonSize.width)/2, y: detailTextLabel.frame.maxY + buttonMargin, width: buttonSize.width, height: buttonSize.height)
    }
    
    @objc private func emptyButtonEvent() {
        eventClosure?()
    }
    
    
    public lazy var imageView: UIImageView = {
        let iv = UIImageView.init()
        let image1 = Bundle.loadImage("defaultImage", from: "MCListViewBundle", in: "MCListView")
        iv.image = image1
        return iv
    }()
    
    public lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.text = "暂无数据"
        return label
    }()
    
    public lazy var detailTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.text = "暂时无数据，再等等吧"
        return label
    }()
    
    public lazy var eventButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("点击", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.addTarget(self, action: #selector(emptyButtonEvent), for: .touchUpInside)
        return button
    }()
}


@objc extension Bundle {
    
    /**
     * 加载指定bundle下的图片资源
     * 在哪个pod下的哪个bundle下的image
     */
    static func loadImage(_ imageName: String, from bundleName: String, in podName: String) -> UIImage? {
        
        
        var associateBundleURL = Bundle.main.url(forResource: "Frameworks", withExtension: nil)
        associateBundleURL = associateBundleURL?.appendingPathComponent(podName)
        associateBundleURL = associateBundleURL?.appendingPathExtension("framework")
       
        
        if associateBundleURL == nil {
            print("获取bundle失败")
            return nil
        }

        
        let associateBunle = Bundle.init(url: associateBundleURL!)
        associateBundleURL = associateBunle?.url(forResource: bundleName, withExtension: "bundle")
        let bundle = Bundle.init(url: associateBundleURL!)
        let scale = Int(UIScreen.main.scale)
        
        // 适配2x还是3x图片
        let name = imageName + "@" + String(scale) + "x"
        let path = bundle?.path(forResource: name, ofType: "png")
        
        if path == nil {
            print("获取bundle失败")
            return nil
        }
        
        let image1 = UIImage.init(contentsOfFile: path!)
        return image1
    }
}
