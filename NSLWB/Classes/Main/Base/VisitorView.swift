//
//  VisitorView.swift
//  NSLWB
//
//  Created by nsl on 16/8/13.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    class func visitorView() -> VisitorView {
        // MARK:- 提供快速通过xib创建的类方法
        return NSBundle.mainBundle().loadNibNamed("VisitorView", owner: nil, options: nil)!.first as! VisitorView
    }
    // MARK:- 控件的属性

    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    // MARK:- 自定义函数
    func setUpVisitorViewInfo(iconName: String, title: String ) {
        iconView.image = UIImage(named: iconName)
        tipLabel.text = title
        rotationView.hidden = true
    }
    
    //设置动画
    func addRotationAnimation() {
        
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.fromValue = 0
        rotationAnim.toValue = M_PI * 2
        rotationAnim.repeatCount = MAXFLOAT //无限旋转
        rotationAnim.duration = 5 //时间
        rotationAnim.removedOnCompletion = false //
        rotationView.layer.addAnimation(rotationAnim, forKey: nil)
    }
    
}
