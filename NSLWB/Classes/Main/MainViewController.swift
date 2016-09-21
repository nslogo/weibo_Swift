//
//  MainViewController.swift
//  NSLWB
//
//  Created by SilongNie on 16/8/11.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    //懒加载
    private lazy var composeBtn : UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpComposeBtn()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        setUpTabBarItems()
    }
}

// MARK:- 设置UI界面的扩充
extension MainViewController{
    
    private func setUpComposeBtn() {
        //1.将composeBtn发布按钮添加在tabBar上
        tabBar.addSubview(composeBtn)
        //2.设置其位置
        composeBtn.center = CGPointMake(tabBar.center.x, tabBar.bounds.size.height * 0.5)
        //3.监听发布按钮的点击
        composeBtn.addTarget(self, action: #selector(MainViewController.composeBtnClick), forControlEvents: .TouchUpInside)
    
//    private func setUpTabBarItems() {
//        for i in 0..<tabBar.items!.count{
//            let item = tabBar.items![i]
//            if i == 2 {
//                item.enabled = false
//                continue
//            }
//        }
    }
}

// MARK:- 事件监听的扩充
extension MainViewController{
    
    //监听事件本质是发送消息，但是发送消息是OC的特性
    //将方法包装成@SEL 类方法列表）
    //如果swift中将一个函数声明称private那么该方法不会被添加到方法列表中，需要@objc
    @objc private func composeBtnClick() {
        print("点击了发布按钮")
        //创建发布控制器
        let composeVC = ComposeViewController()
        //包装导航控制器
        let composeNav = UINavigationController(rootViewController: composeVC)
        //弹出控制器
        presentViewController(composeNav, animated: true, completion: nil)
    }
}









