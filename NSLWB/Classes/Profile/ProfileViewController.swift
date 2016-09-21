//
//  ProfileViewController.swift
//  NSLWB
//
//  Created by SilongNie on 16/8/11.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewConreoller {
    private var listArr = [[""],["新的好友","微博等级"],["我的相册","我的点评","我的赞"],["微博支付","微博运动"],["粉丝头条","粉丝服务"],["草稿箱"],["更多"]]
    private var listExplainArr = [[""],["","连续登陆30天"],["","",""],["十元夺保时捷718","每天10000步，你达标了吗？"],["推广博文及账号的利器","橱窗，私信，营销"],[""],["文章，收藏"]]

    private var listImageArr = [[""],["message_addfansgroup","message_addfansgroup"],["message_choosegroup","message_choosegroup","message_choosegroup"],["message_creatchat","message_creatchat"],["message_icon_group","message_icon_group"],["messagescenter_comments"],["messagescenter_groupchat_notice"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(colorLiteralRed: 242/255.0, green: 244/255.0, blue: 242/255.0, alpha: 1)

        if !isLogin {
            visitorView.setUpVisitorViewInfo("visitordiscover_image_profile", title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
        } else {
            setUpNavigationBar()
        }
        

    }
}

// MARK: - 设置UI
extension ProfileViewController {
    //NavigationBar
    func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "添加好友")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "设置")
    }
}

extension ProfileViewController {
    //    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let headView : ProfileHeaderView = ProfileHeaderView()
    //        headView.backgroundColor = UIColor.whiteColor()
    //        return headView
    //
    //    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 6 {
            return 10
        } else {
            return 0.01
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listArr[section].count
        }else{
            return listArr[section].count
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else {
            return 50
        }
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return listArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell1") as! ProfileViewCell1
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell2") as! ProfileViewCell2
            cell.nameLabels.text = listArr[indexPath.section][indexPath.row]
            cell.explainLables.text = listExplainArr[indexPath.section][indexPath.row]
            cell.headImageViews.image = UIImage(named: "\(listImageArr[indexPath.section][indexPath.row])")
            return cell
            
        }
        
        
    }
}
