//
//  CompseTitleView.swift
//  NSLWB
//
//  Created by nie on 16/9/8.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class CompseTitleView: UIView {

    //MARK : - 懒加载属性
    private lazy var titleLabel : UILabel = UILabel()
    private lazy var screenNameLabel : UILabel = UILabel()
    
    //MARK : - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CompseTitleView {
    private func setUpUI() {
        //添加
        addSubview(titleLabel)
        addSubview(screenNameLabel)
        
        //设置frame
        titleLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        screenNameLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(titleLabel.snp_centerX)
            make.top.equalTo(titleLabel.snp_bottom).offset(3)
        }
        
        //设置属性
        titleLabel.font = UIFont.systemFontOfSize(16)
        screenNameLabel.font = UIFont.systemFontOfSize(14)
        screenNameLabel.textColor = UIColor.lightGrayColor()
        titleLabel.text = "发微博"
        screenNameLabel.text = UserAccountViewModel.shareIntance.account?.screen_name
    }
}