//
//  WelcomeViewController.swift
//  NSLWB
//
//  Created by nie on 16/8/18.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    // 设置改变的属性
    @IBOutlet weak var IconImageBottom: NSLayoutConstraint!
    @IBOutlet weak var iconImage: UIImageView!
    
    //系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        // 0.设置头像
        let profileURLString = UserAccountViewModel.shareIntance.account?.avatar_large
        // ?? : 如果??前面的可选类型有值,那么将前面的可选类型进行解包并且赋值
        // 如果??前面的可选类型为nil,那么直接使用??后面的值
        let url = NSURL(string: profileURLString ?? "")
        //改变约束的值
        IconImageBottom.constant = UIScreen.mainScreen().bounds.height - 230
        iconImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "avatar_default_big"))
        //执行动画
        // Damping : 阻力系数,阻力系数越大,弹动的效果越不明显 0~1
        // initialSpringVelocity : 初始化速度
        UIView.animateWithDuration(3.0, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: {
            self.view.layoutIfNeeded()
            }) { (_) in
                UIApplication.sharedApplication().keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
        
        
    }
}
