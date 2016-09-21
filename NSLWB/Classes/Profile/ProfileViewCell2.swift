//
//  ProfileViewCell2.swift
//  NSLWB
//
//  Created by nie on 16/9/14.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class ProfileViewCell2: UITableViewCell {

    var nameLabels: UILabel!
    var headImageViews : UIImageView!
    var rightImageViews : UIImageView!
    var explainLables : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /// 头像
        let headImageView : UIImageView = UIImageView()
        headImageView.image = UIImage(named: "avatar_default")
        addSubview(headImageView)
        headImageView .snp_makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(15)
            make.width.height.equalTo(20)
        }
        headImageView.layer.cornerRadius = 2
        headImageView.layer.masksToBounds = true
        headImageViews = headImageView
        
        //姓名
        let nameLabel : UILabel = UILabel()
        nameLabel.font = UIFont.systemFontOfSize(16)
        addSubview(nameLabel)
        nameLabel .snp_makeConstraints { (make) in
            make.left.equalTo(headImageView.snp_right).offset(10)
            make.centerY.equalTo(headImageView.snp_centerY)
        }
        nameLabel.text = "聶聶聶大仁"
        nameLabels = nameLabel
        
        //右侧剪头
        let rightImageView : UIImageView = UIImageView()
        rightImageView.image = UIImage(named: "SignIn_arrow")
        addSubview(rightImageView)
        rightImageView .snp_makeConstraints { (make) in
            make.centerY.equalTo(headImageView.snp_centerY)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(10)
            make.width.equalTo(7)
        }
        rightImageView.sizeToFit()
        rightImageViews = rightImageView
        
        //说明内容
        let explainLable : UILabel = UILabel()
        explainLable.font = UIFont.systemFontOfSize(14)
        explainLable.textColor = UIColor.grayColor()
        addSubview(explainLable)
        explainLable .snp_makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp_right).offset(7)
            make.centerY.equalTo(nameLabel.snp_centerY)
            //make.right.equalTo(rightImageView.snp_left).offset(15)
            make.height.equalTo(nameLabel.snp_height)
        }
        explainLables = explainLable
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
