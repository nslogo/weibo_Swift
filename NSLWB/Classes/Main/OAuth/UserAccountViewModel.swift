//
//  UserAccountTool.swift
//  NSLWB
//
//  Created by nie on 16/8/18.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class UserAccountViewModel {
    // MARK:- 将类设计成单例
    static let shareIntance : UserAccountViewModel = UserAccountViewModel()
    
    // MARK:- 定义属性
    var account : UserAccount?
    
    // MARK:- 计算属性
    var accountPath : String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        return (accountPath as NSString).stringByAppendingPathComponent("accout.plist")
    }
    
    var isLogin : Bool {
        if account == nil {
            return false
        }
        
        guard let expiresDate = account?.expires_date else {
            return false
        }
        
        return expiresDate.compare(NSDate()) == NSComparisonResult.OrderedDescending
    }
    
    // MARK:- 重写init()函数
    init () {
        // 1.从沙盒中读取中归档的信息
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
    }

}
