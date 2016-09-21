//
//  StatusViewModel.swift
//  NSLWB
//
//  Created by nie on 16/8/22.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {
    
    //MARK : - 定义属性
    var status : Status?                   //个人信息

    // MARK:- 对数据处理的属性
    var sourceText : String?               //来源处理后的属性
    var createAtText : String?             //时间处理后的属性
    var verifiedImage : UIImage?           //处理用户认证图标
    var vipImage : UIImage?                //处理用户会员等级
    var profileURL : NSURL?                //处理用户头像的地址
    var picUrls : [NSURL] = [NSURL]()      //处理微博图片的数据
    
    //MARK : - 自定义构造函数
    init(status : Status) {
        self.status = status
        
        //1 对来源进行处理
        if let source  = status.source where source != "" {
            //对来源的字符串进行处理
            //获取起始位置
            let starIndex = (source as NSString).rangeOfString(">").location + 1
            //获取截取的长度
            let length = (source as NSString).rangeOfString("</").location - starIndex
            //截取字符串
            sourceText = (source as NSString).substringWithRange(NSRange(location: starIndex, length: length))
        }
        
        //2 对时间进行处理
        if let createAt = status.created_at {
            createAtText = NSDate.createDateString(createAt)
        }
        
        //3 处理用户认证图标
        let verified_type = status.user?.verified_type ?? -1
        switch verified_type {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2,3,5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
        
        //4 处理用户会员等级
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        //5 用户头像的处理
        let profileURLStr = status.user?.profile_image_url ?? ""
        profileURL = NSURL(string: profileURLStr)
        
        
        //6 处理配图数据
        let picURLDicts = status.pic_urls!.count != 0 ? status.pic_urls : status.retweeted_status?.pic_urls
        
        if let picURLDicts = picURLDicts  {
            for picURLDic in picURLDicts {
                guard let picURLString = picURLDic["thumbnail_pic"] else {
                    continue
                }
                picUrls.append(NSURL(string: picURLString)!)
            }
        }
        
    }
}
