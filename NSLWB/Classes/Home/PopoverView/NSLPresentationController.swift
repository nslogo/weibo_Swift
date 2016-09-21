//
//  NSLPresentationController.swift
//  NSLWB
//
//  Created by nsl on 16/8/15.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class NSLPresentationController: UIPresentationController {

    //对外提供的属性
    var presentedFrame : CGRect = CGRectZero
    
    // MARK:- 懒加载属性
    private lazy var coverView : UIView = UIView()
    
    // MARK:- 系统回调
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        //设置弹出view的尺寸
        presentedView()?.frame = presentedFrame
    
        // 添加蒙版
        setupCoverView()
    }
    
    
}

extension NSLPresentationController {
    private func setupCoverView() {
    
        containerView?.insertSubview(coverView, atIndex: 0)
        
        coverView.backgroundColor = UIColor(white: 0.8,alpha: 0.1)
        coverView.frame = containerView!.bounds
        
        let tapGes = UITapGestureRecognizer(target: self,action: #selector(NSLPresentationController.coverViewClick))
        coverView.addGestureRecognizer(tapGes)
    }
}


extension NSLPresentationController {
    @objc private func coverViewClick() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}