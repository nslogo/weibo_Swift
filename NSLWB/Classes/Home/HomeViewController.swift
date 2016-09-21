//
//  HomeViewController.swift
//  NSLWB
//
//  Created by SilongNie on 16/8/11.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewConreoller {

    //懒加载 private只在本文件内使用
    private lazy var titleBtn: UIButton = TitleButton()
    // 注意:在闭包中如果使用当前对象的属性或者调用方法,也需要加self
    // 两个地方需要使用self : 1> 如果在一个函数中出现歧义 2> 在闭包中使用当前对象的属性和方法也需要加self
    private lazy var popoverAnimator : PopoverAnimator = PopoverAnimator{[weak self](presented) -> ()in
        self?.titleBtn.selected = presented
    }
//    private lazy var status : [Status] = [Status]() //首页模型
    private lazy var viewModels : [StatusViewModel] = [StatusViewModel]() //视图模型
    private lazy var tipLabel : UILabel = UILabel()
    private lazy var photoBrowserAnimator : PhotoBrowserAnimator = PhotoBrowserAnimator()
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1 没有登录时显示的内容
        visitorView.addRotationAnimation()
        if !isLogin{
            return
        }
        
        //2 设置导航栏的内容
        setUpNavigationBar()
        
        //3 获取网络请求
//        loadStatuses()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        //4 布局header/ footer
        setUpHeaderView()
        setUpFooterView()
        
        //5 设置提示的Lable
        setUpTipLabel()
        
        //6 监听通知
        setupNatifications()
    }
}

// MARK: - 绘制UI界面
extension HomeViewController{
    private func setUpNavigationBar() {
        // 1.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        
        // 2.设置右侧的Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        // 3.设置titleView
        titleBtn.setTitle("ZoroNie", forState: .Normal)
        titleBtn.addTarget(self, action: #selector(HomeViewController.titleBtnClick(_:)), forControlEvents: .TouchUpInside)
        navigationItem.titleView = titleBtn;
    }
    
    private func setUpHeaderView () {
        let header = MJRefreshNormalHeader(refreshingTarget: self,refreshingAction: #selector(HomeViewController.loadNewStatuses))
        
        header.setTitle("下拉刷新", forState: .Idle)
        header.setTitle("释放更新", forState: .Pulling)
        header.setTitle("加载中...", forState: .Refreshing)
        
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
    }
    
    private func setUpFooterView() {
        let footer = MJRefreshAutoFooter(refreshingTarget: self,refreshingAction: #selector(HomeViewController.loadMoreStatuses))
        tableView.mj_footer = footer
    }
    
    //设置提示的label的属性
    private func setUpTipLabel() {
        navigationController?.navigationBar.insertSubview(tipLabel, atIndex: 0)
        tipLabel.frame = CGRect(x: 0, y: 10, width: UIScreen.mainScreen().bounds.width, height: 30)
        tipLabel.backgroundColor = UIColor.orangeColor()
        tipLabel.textColor = UIColor.whiteColor()
        tipLabel.font = UIFont.systemFontOfSize(14)
        tipLabel.textAlignment = .Center
        tipLabel.hidden = true
    }
    
    private func setupNatifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.showPhotoBrowser(_:)), name: ShowPhotoBrowserNote, object: nil)
    }
}

// MARK: - 监听事件的方法
extension HomeViewController {
    @objc private func titleBtnClick(titleBtn: TitleButton) {
//        // 1.改变按钮的状态
//        titleBtn.selected = !titleBtn.selected
        
        // 1.创建弹出的控制器
        let popoverVC  = PopoverViewViewController()
        
        // 2.设置控制器的modal样式Custom样式 底层的控件不会被移除
        popoverVC.modalPresentationStyle = .Custom
        
        // 3.设置转场代理
        popoverVC.transitioningDelegate = popoverAnimator
        popoverAnimator.presentedFrame = CGRect(x:(self.view.frame.size.width - 150)/2 , y: 55, width: 150, height: 250)
        
        // 4.弹出控制器
        presentViewController(popoverVC, animated: true, completion: nil)
        
    }
    
    @objc private func showPhotoBrowser(note : NSNotification) {
        // 0.取出数据
        let indexPath = note.userInfo![ShowPhotoBrowserIndexKey] as! NSIndexPath
        let picURLs = note.userInfo![ShowPhotoBrowserUrlsKey] as! [NSURL]
        let object = note.object as! PicCollectionView
        
        // 1.创建控制器
        let photoBrowserVc = PhotoBrowserController(indexPath: indexPath, picUrls: picURLs)
        
        // 2.设置modal样式
        photoBrowserVc.modalPresentationStyle = .Custom
        
        // 3.设置转场的代理
        photoBrowserVc.transitioningDelegate = photoBrowserAnimator
        
        // 4.设置动画的代理
        photoBrowserAnimator.presentedDelegate = object
        photoBrowserAnimator.indexPath = indexPath
        photoBrowserAnimator.dismissDelegate = photoBrowserVc
        
        // 以modal的形式弹出控制器
        presentViewController(photoBrowserVc, animated: true, completion: nil)    }
}

// MARK: - 网络请求
extension HomeViewController {
    
    //加载最新的数据
    @objc private func loadNewStatuses() {
        loadStatuses(true)
    }
    
    //加载更多数据
    @objc private func loadMoreStatuses() {
        loadStatuses(false)
    }
    
    private func loadStatuses(isNewDate : Bool) {
        
        var since_id = 0
        var max_id = 0
        if isNewDate {
            since_id = viewModels.first?.status?.mid ?? 0
        } else {
            max_id = viewModels.last?.status?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id - 1)
        }
        
        NetworkTools.shareInstance.loadStatuses(since_id, max_id: max_id) { (result, error) in
            //校验错误
            if error != nil {
                print(error)
                return
            }
            //获取可选类型中的数据
            guard let resultArray = result else {
                return
            }
            
            //遍历微博对应的字典
            var tempViewModel = [StatusViewModel]()
            for statusDict in resultArray {
                let statu = Status(dict: statusDict)
                let viewModel = StatusViewModel(status: statu)
//                self.viewModels.append(viewModel)
                tempViewModel.append(viewModel)
            }
            //刷新表格
//            self.tableView.reloadData()
            if isNewDate {
                self.viewModels = tempViewModel + self.viewModels
            } else {
                self.viewModels += tempViewModel
            }
            
            //缓存图片
            self.cacheImages(tempViewModel)
        }
    }
    
    
    private func cacheImages(viewModels : [StatusViewModel]) {
        //创建一个线程组
        let group = dispatch_group_create()
        
        //缓存图片
        for viewModel in viewModels {
            for picURL in viewModel.picUrls {
                dispatch_group_enter(group)
                SDWebImageManager.sharedManager().downloadImageWithURL(picURL, options: [], progress: nil, completed: { (_, _, _, _, _) in
                    dispatch_group_leave(group)
                })
            }
        }
        //刷新表格
        dispatch_group_notify(group, dispatch_get_main_queue()) { 
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            
            //显示提示的Label
            self.showTipLabel(viewModels.count)
        }
    }
    
    //显示提示的Label
    private func showTipLabel(count : Int) {
        tipLabel.hidden = false
        tipLabel.text = count == 0 ? "没有新数据" : "加载\(count)条微博"
        
        UIView.animateWithDuration(1.0) { 
            self.tipLabel.frame.origin.y = 44
        }
        UIView.animateWithDuration(1.0, delay: 1.5, options: [], animations: { 
            self.tipLabel.frame.origin.y = 10
            }) { (_) in
                self.tipLabel.hidden = true
        }
    }
    
}

// MARK:- tableView的数据源方法
extension HomeViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 1.创建cell
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell") as! HomeViewCell
        
        // 2.给cell设置数据
        cell.viewModel = viewModels[indexPath.row]
        
        return cell
    }
}

















