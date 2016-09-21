//
//  MessageViewController.swift
//  NSLWB
//
//  Created by SilongNie on 16/8/11.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewConreoller {
    private var listArr = ["@我的","评论","赞"]
    private var listImageArr = ["messagescenter_at","messagescenter_comments","messagescenter_good"]

    private var listNetArr = ["汽车之家","斗鱼直播平台","未关注人消息","无锡生活"]
    private var listNetImageArr = ["messagescenter_messagebox","messagescenter_messagebox","messagescenter_messagebox","messagescenter_messagebox"]
    private var listNetExplainArr = ["感谢你关注我的","欢迎来到我的微博","hello，我是xxx","新闻最前沿"]

    
    override func viewDidLoad() {
        super.viewDidLoad()


        if !isLogin {
            visitorView.setUpVisitorViewInfo("visitordiscover_image_message", title: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
        } else {
            setUpNavigationBar()
        }
    }
}

// MARK: - UI
extension MessageViewController {
    func setUpNavigationBar () {
        // 1.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "发现群")
        
        // 2.设置右侧的Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageNameHighlight: "navigationbar_icon_newchat")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArr.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  searchView : UISearchBar = UISearchBar()
        searchView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44)
        searchView.barStyle = .Default
        searchView.text = ""
        return searchView
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row < 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell1")
            cell?.imageView?.image = UIImage(named: "\(listImageArr[indexPath.row])")
            cell?.textLabel?.text = listArr[indexPath.row]
            return cell!
        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell2") as! MessageViewCell
            
            cell.nameLabels.text = listNetArr[indexPath.row - 3]
            cell.explainLabels.text = listNetExplainArr[indexPath.row - 3]
            cell.headImageViews.image = UIImage(named: "\(listNetImageArr[indexPath.row - 3])")
            
            return cell
        }
       
    }
}
