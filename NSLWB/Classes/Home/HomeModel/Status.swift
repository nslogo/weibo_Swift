//
//  Status.swift
//  NSLWB
//
//  Created by nie on 16/8/19.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class Status: NSObject {

    // MARK:- 属性
    var created_at : String?            // 微博创建时间
//    {
//        didSet {
//            // 1.nil值校验
//            guard let created_at = created_at else {
//                return
//            }
//            
//            // 2.对时间处理
//            createAtText = NSDate.createDateString(created_at)
//        }
//    }
    var source : String?               //来源
//        {
//        didSet {
//            guard let source = source where source != "" else {
//                return
//            }
//            
//        }
//    }
    var text : String?                          //微博正文
    var mid : Int = 0                           //微博ID
    var user : User?                            //个人信息
    var pic_urls : [[String : String]]?         //微博的配图
    var retweeted_status : Status?              //对应的转发的微博
    
    // MARK:- 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = User(dict: userDict)
        }
        
        //将转发微博的字典转成模型对象
        if let retweetedStatusDict = dict["retweeted_status"] as? [String : AnyObject] {
            retweeted_status = Status(dict: retweetedStatusDict)
        }
        
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}
