//
//  BaseViewConreoller.swift
//  NSLWB
//
//  Created by nsl on 16/8/13.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class BaseViewConreoller: UITableViewController {

    // MARK:- 创建懒加载
    lazy var visitorView : VisitorView = VisitorView.visitorView()
    
    // MARK:- 定义变量
    var isLogin: Bool = UserAccountViewModel.shareIntance.isLogin
    
    // MARK:- 系统回调函数
    override func loadView() {
        // 判断要加载哪一个View
        isLogin ? super.loadView() : setUpVisitorView()
        isLogin ? super.loadView() : setUpNavigationItems()
    }
    
    override func viewDidLoad() {
//        setUpNavigationItems()
    }
}

// MARK: - 设置UI界面
extension BaseViewConreoller{
    private func setUpVisitorView(){
        //设置访客视图
        view = visitorView
        visitorView.registerBtn.addTarget(self, action: #selector(BaseViewConreoller.registerBtnClick), forControlEvents: .TouchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(BaseViewConreoller.loginBtnClick), forControlEvents: .TouchUpInside)
    }
        //设置导航栏左右的items
    private func setUpNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: #selector(BaseViewConreoller.registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: #selector(BaseViewConreoller.loginBtnClick))
    }
}

// MARK: - 事件监听
extension BaseViewConreoller {
    @objc private func registerBtnClick() {
        print("注册")
    }
    
    @objc private func loginBtnClick() {

        //创建授权控制器
        let oauthVC = OAuthViewController()
        //包装导航栏控制器
        let oauthNav = UINavigationController(rootViewController: oauthVC)
        //弹出控制器
        presentViewController(oauthNav, animated: true, completion: nil)
        
    }
}