//
//  CompseTextView.swift
//  NSLWB
//
//  Created by nie on 16/9/8.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class CompseTextView: UITextView {

    //MARK : - 懒加载属性
   lazy var placeHoderLabel : UILabel = UILabel()
    
    //MARK : - 构造函数
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
        
    }

}


// MARK: - 设置UI界面
extension CompseTextView {
    private func setUpUI() {
        
        placeHoderLabel.text = "分享新鲜事..."
        placeHoderLabel.textColor = UIColor.lightGrayColor()
        placeHoderLabel.font = UIFont.systemFontOfSize(14)
        addSubview(placeHoderLabel)
        placeHoderLabel.snp_makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(10)
        }
        
        
        textContainerInset = UIEdgeInsets(top: 8, left: 6,  bottom: 0, right: 6)
        
    }
}