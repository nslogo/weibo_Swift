//
//  OAuthViewController.swift
//  NSLWB
//
//  Created by nsl on 16/8/16.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //导航栏
        setupNavigationBar()
        //webView
        loadPage()
    }
}


// MARK: - 设置UI界面
extension OAuthViewController {
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: #selector(OAuthViewController.closeClick))
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .Plain, target: self, action: #selector(OAuthViewController.fillTextClick))
        
        title = "登录页面"
        
    }
    
    private func loadPage() {
        
        // 1.获取登录页面的URLString
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
      
        // 2.创建对应NSURL
        guard let url = NSURL(string: urlString) else {
            return
        }
        
        // 3.创建NSURLRequest对象
        let request = NSURLRequest(URL: url)
        
        // 4.加载request对象
        webView.loadRequest(request)
        
    }

}


// MARK: - 监听事件
extension OAuthViewController {
    @objc private func closeClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func fillTextClick() {
        print("填充")
        // 1.书写js代码 : javascript / java --> 雷锋和雷峰塔
        let jsCode = "document.getElementById('userId').value='账号';document.getElementById('passwd').value='密码';"
        // 2.执行js代码
        webView.stringByEvaluatingJavaScriptFromString(jsCode)
    }
}



// MARK:- webView的delegate方法
extension OAuthViewController : UIWebViewDelegate {
    // webView开始加载网页
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.showWithStatus("加载中...")
    }
    
    // webView网页加载完成
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    // webView加载网页失败
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        SVProgressHUD.dismiss()
    }
    
    // 当准备加载某一个页面时,会执行该方法
    // 返回值: true -> 继续加载该页面 false -> 不会加载该页面
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        //1.获取加载网页的URL，因为获取的时候会加载多个URL，所以需要过滤判断
        guard let url = request.URL else {
            return true
        }
        
        //2.获取URL中的字符串，转格式
        let urlString = url.absoluteString
        
        //3.判断该字符串中是否包含code=，如果！=则继续
        guard urlString!.containsString("code=") else {
            return true
        }
        
        //4.截取
        let code = urlString!.componentsSeparatedByString("code=").last!
        print("\(urlString)")
        print("\(code)")
        
        //5.请求accessToken
        loadAccessToken(code)

        return false
    }
}

// MARK:- 请求数据
extension OAuthViewController {
    private func loadAccessToken(code: String) {
        /// 请求AccessToken
        NetworkTools.shareInstance.loadAccessToken(code) { (result, error) -> () in
            // 1.错误校验
            if error != nil {
                print(error)
                return
            }
            
            // 2.拿到结果
            print(result)
            guard let  accountDict = result else {
                print("没有发现获取授权后的数据")
                return
            }
            print("字典信息：\(accountDict)")
            // 3.字典转模型
            let account = UserAccount(dict: accountDict)
            print("account: \(account)")
            
            // 4 请求用户信息
            self.loadUserInfo(account)
        }

    }
    
    
    //请求用户信息的方法
    private func loadUserInfo(account: UserAccount) {
        //获取accesstoken
        guard let accessToken = account.access_token else {
            return
        }
        //获取uid
        guard let uid = account.uid else {
            return
        }
        //发送网络请求
        NetworkTools.shareInstance.loadUserInfo(accessToken, uid: uid) { (result, error) in
            //1 校验错误
            if error != nil {
                print(error)
                return
            }
            
            //2 拿到用户信息的结果
            guard let userInfoDict = result else {
                return
            }
            
            //3 从字典取出昵称和用户头像的地址
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            print(account)
            
            //4 将account对象保存
            NSKeyedArchiver.archiveRootObject(account, toFile: UserAccountViewModel.shareIntance.accountPath)
            
            // 5.将account对象设置到单例对象中
            UserAccountViewModel.shareIntance.account = account
            
            // 6.退出当前控制器
            self.dismissViewControllerAnimated(false, completion: { () -> Void in
                UIApplication.sharedApplication().keyWindow?.rootViewController = WelcomeViewController()
            })
        }
    }
}

























