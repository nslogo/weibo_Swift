//
//  ProfileViewCell1.swift
//  NSLWB
//
//  Created by nie on 16/9/14.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class ProfileViewCell1: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        /// 头像
        let headImageView : UIImageView = UIImageView()
        headImageView.image = UIImage(named: "avatar_default")
        addSubview(headImageView)
        headImageView .snp_makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(15)
            make.width.height.equalTo(60)
        }
        headImageView.layer.cornerRadius = 30
        headImageView.layer.masksToBounds = true
        
        //姓名
        let nameLabel : UILabel = UILabel()
        nameLabel.font = UIFont.boldSystemFontOfSize(16)
        addSubview(nameLabel)
        nameLabel .snp_makeConstraints { (make) in
            make.left.equalTo(headImageView.snp_right).offset(15)
            make.top.equalTo(headImageView.snp_top).offset(10)
        }
        nameLabel.text = "聶聶聶大仁"
        
        //签名
        let signatureLabel : UILabel = UILabel()
        signatureLabel.textColor = UIColor.darkGrayColor()
        signatureLabel.font = UIFont.systemFontOfSize(14)
        addSubview(signatureLabel)
        signatureLabel .snp_makeConstraints { (make) in
            make.top.equalTo(headImageView.snp_centerY).offset(5)
            make.left.equalTo(nameLabel)
        }
        signatureLabel.text = "这是一种签名方式"
        
        //会员种类
        let isVipLabel : UILabel = UILabel()
        isVipLabel.textColor = UIColor.orangeColor()
        isVipLabel.font = UIFont.systemFontOfSize(14)
        addSubview(isVipLabel)
        isVipLabel .snp_makeConstraints { (make) in
            make.centerY.equalTo(headImageView.snp_centerY)
            make.right.equalTo(self).offset(-25)
        }
        isVipLabel.text = "会员用户"
        
        //会员图片标识
        let isVipImageView : UIImageView = UIImageView()
        isVipImageView.image = UIImage(named: "common_icon_membership_level6")
        addSubview(isVipImageView)
        isVipImageView.sizeToFit()
        isVipImageView .snp_makeConstraints { (make) in
            make.centerY.equalTo(headImageView.snp_centerY)
            make.right.equalTo(isVipLabel.snp_left).offset(-5)
            make.width.height.equalTo(20)
        }
        
        //会员提示圆点
        let isVipView : UIView = UIView()
        isVipView.backgroundColor = UIColor.redColor()
        isVipView.layer.cornerRadius = 5
        isVipView.layer.masksToBounds = true
        addSubview(isVipView)
        isVipView .snp_makeConstraints { (make) in
            make.left.equalTo(isVipLabel.snp_right).offset(5)
            make.centerY.equalTo(isVipLabel.snp_centerY)
            make.width.height.equalTo(10)
        }
        
        //分割线
        let lineView : UIView = UIView()
        lineView.backgroundColor = UIColor.init(colorLiteralRed: 242/255.0, green: 244/255.0, blue: 242/255.0, alpha: 1)
        addSubview(lineView)
        lineView .snp_makeConstraints { (make) in
            make.top.equalTo(headImageView.snp_bottom).offset(15)
            make.width.equalTo(self)
            make.height.equalTo(1)
        }
        
        let numberArr = ["5555","6666","7777"]
        let explainArr  = ["微博","关注","粉丝"]
        
        
        //数量循环
        for index in 1...3 {
            
            let numberLabel : UILabel = UILabel()
            numberLabel.text = numberArr[index - 1]
            numberLabel.textAlignment = .Center
            numberLabel.font = UIFont.boldSystemFontOfSize(16)
            addSubview(numberLabel)
            let width = UIScreen.mainScreen().bounds.width / 3
            numberLabel.frame = CGRect(x: width * CGFloat(index - 1), y: 95, width: width, height: 30)
            
            let explainLabel : UILabel = UILabel()
            explainLabel.text = explainArr[index - 1]
            explainLabel.textColor = UIColor.darkGrayColor()
            explainLabel.textAlignment = .Center
            explainLabel.font = UIFont.systemFontOfSize(13)
            addSubview(explainLabel)
            explainLabel.frame = CGRect(x: width * CGFloat(index - 1), y: 120, width: width, height: 20)

        }

//    func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    }
    
}
