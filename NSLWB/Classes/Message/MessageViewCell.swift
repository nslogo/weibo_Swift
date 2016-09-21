//
//  MessageViewCell.swift
//  NSLWB
//
//  Created by nie on 16/9/18.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {

    var headImageViews : UIImageView = UIImageView()
    var nameLabels : UILabel = UILabel()
    var explainLabels : UILabel = UILabel()
    var dateLabels : UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //左侧的头像
        let headImageView : UIImageView = UIImageView()
        headImageView.image = UIImage(named: "messagescenter_messagebox")
        addSubview(headImageView)
        headImageView .snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(5)
            make.width.height.equalTo(50)
        }
        headImageView.sizeToFit()
        headImageView.layer.cornerRadius = 25
        headImageView.layer.masksToBounds = true
        headImageViews = headImageView
        
        //名称
        let nameLabel : UILabel = UILabel()
        nameLabel.font = UIFont.systemFontOfSize(16)
        addSubview(nameLabel)
        nameLabel .snp_makeConstraints { (make) in
            make.top.equalTo(headImageView)
            make.left.equalTo(headImageView.snp_right).offset(10)
            make.bottom.equalTo(headImageView.snp_centerY)
            make.right.equalTo(self).offset(-70)
        }
        nameLabels = nameLabel
        
        //提示文字
        let explainLabel : UILabel = UILabel()
        explainLabel.font = UIFont.systemFontOfSize(14)
        explainLabel.textColor = UIColor.grayColor()
        addSubview(explainLabel)
        explainLabel .snp_makeConstraints { (make) in
            make.top.equalTo(headImageView.snp_centerY)
            make.left.equalTo(nameLabel.snp_left)
            make.bottom.equalTo(headImageView.snp_bottom)
            make.right.equalTo(self).offset(-50)
        }
        explainLabels = explainLabel
        
        //日期
        let dateLabel : UILabel = UILabel()
        dateLabel.textColor = UIColor.grayColor()
        dateLabel.font = UIFont.systemFontOfSize(14)
        addSubview(dateLabel)
        dateLabel .snp_makeConstraints { (make) in
            make.top.equalTo(headImageView.snp_top)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(nameLabel.snp_bottom)
        }
        dateLabels = dateLabel
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
