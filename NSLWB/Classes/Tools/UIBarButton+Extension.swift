//
//  UIBarButton+Extension.swift
//  NSLWB
//
//  Created by nsl on 16/8/15.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //便利构造器创建UIBarButtonItem，方式一
    convenience init(imageName: String) {
        self.init()
        let itemBtn = UIButton()
        itemBtn.setImage(UIImage(named: imageName), forState: .Normal)
        itemBtn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        itemBtn.sizeToFit()
        self.customView = itemBtn
    }
    //便利构造器创建UIBarButtonItem，方式一
    convenience init(imageNameHighlight: String) {
        self.init()
        let itemBtn = UIButton()
        itemBtn.setImage(UIImage(named: imageNameHighlight), forState: .Normal)
        itemBtn.setImage(UIImage(named: imageNameHighlight + "_highlight"), forState: .Highlighted)
        itemBtn.sizeToFit()
        self.customView = itemBtn
    }
    //便利构造器创建UIBarButtonItem，方式二
//    convenience init(imageName: String) {
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imageName), forState: .Normal)
//        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
//        btn.sizeToFit()
//        self.init(customView: btn)
//    }
    
    convenience init(title : String) {
        self.init()
        let itemBtn = UIButton()
        itemBtn.setTitle(title, forState: .Normal)
        itemBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        itemBtn.setTitleColor(UIColor.orangeColor(), forState: .Highlighted)
        itemBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        itemBtn.sizeToFit()
        self.customView = itemBtn
    }
}
