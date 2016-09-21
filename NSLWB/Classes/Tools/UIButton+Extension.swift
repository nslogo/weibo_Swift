//
//  UIButton+Extension.swift
//  NSLWB
//
//  Created by nsl on 16/8/13.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

extension UIButton {
    //convenience : 便利构造器函数，常用在对系统的类进行构造函数的扩充的时候使用
    //便利构造器函数的特点：
    //1 便利构造函数通常是写在extension里面
    //2 便利构造函数init前面需要加载convenience
    //3 便利构造函数中需要明确调用self.init()
    
    convenience init (imageName: String, bgImageName: String) {
        self.init ()
        setImage(UIImage(named: imageName), forState: .Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        setBackgroundImage(UIImage(named: bgImageName), forState: .Normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), forState: .Highlighted)
        sizeToFit()
    }
    
    //MARK : -  图片浏览器中的btn
    convenience init?(bgColor : UIColor, title : String, fontSize : CGFloat) {
        self.init()
        backgroundColor = bgColor
        setTitle(title, forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
}
