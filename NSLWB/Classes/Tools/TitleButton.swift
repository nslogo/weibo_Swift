//
//  TitleButton.swift
//  NSLWB
//
//  Created by nsl on 16/8/15.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    // MARK: - 重写init函数
    //override重写系统方法时
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.size.width + 5
    }
}
