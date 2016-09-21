//
//  ComposeViewController.swift
//  NSLWB
//
//  Created by nie on 16/9/8.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    
    //设置控件的属性
    @IBOutlet weak var compseTextView: CompseTextView!
    @IBOutlet weak var PicPickerView: PicPickerCollectionView!
    
    // MARK:- 约束的属性
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    @IBOutlet weak var picPickerViewHCons: NSLayoutConstraint!
    
    //懒加载的属性
    private lazy var titleView : CompseTitleView = CompseTitleView()
    private lazy var images : [UIImage] = [UIImage]()
    private lazy var emoticonVc : EmoticonController = EmoticonController  { (emoticon) in
    
        self.compseTextView.insertEmoticon(emoticon)
        //主动触发这个textViewDidChange方法，默认在这个闭包内部是不会自动触发的，必须自己主动调用
        self.textViewDidChange(self.compseTextView)
    }
    
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置导航栏
        setUpNavigationBar()
        
        // 监听通知
        setUpNotifications()

    }
    
    override func viewDidAppear(animated: Bool) {
        compseTextView.becomeFirstResponder()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

// MARK: - 设置UI界面
extension ComposeViewController {
    private func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: #selector(ComposeViewController.closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .Plain, target: self, action: #selector(ComposeViewController.composeItemClick))
        navigationItem.rightBarButtonItem?.enabled = false
        
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        navigationItem.titleView = titleView
    }
    
    //MARK : - 通知
    private func setUpNotifications() {
        //监听键盘的弹出
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ComposeViewController.keyboardWillChangeFrame), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        //监听添加图片按钮的点击
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ComposeViewController.addPhotoClick), name: picPickerAddPhotoNote, object: nil)
        
        //监听添加图片按钮的点击
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ComposeViewController.delPhotoClick), name: picPickerDelPhotoNote, object: nil)
    }
}

// MARK: - 添加图片与删除图片的事件
extension ComposeViewController {
    @objc private func addPhotoClick() {
        print("add")
        //判断数据源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            return
        }
        
        //创建照片选择控制器
        let ipc = UIImagePickerController()
        //设置照片源
        ipc.sourceType = .PhotoLibrary
        //设置代理
        ipc.delegate = self
        //弹出选择照片的控制器
        presentViewController(ipc, animated: true, completion: nil)

    }
    
    @objc private func delPhotoClick(note : NSNotification) {
        guard let image = note.object as? UIImage else {
            return
        }
        guard let index = images.indexOf(image) else {
            return
        }
        images.removeAtIndex(index)
         PicPickerView.images = images
    }
}

extension ComposeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print(info)
        //获取照片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //展示
        images.append(image)
        PicPickerView.images = images
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
}

// MARK: - 监听事件的函数
extension ComposeViewController {
    //关闭页面
    @objc private func closeItemClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    //发布内容
    @objc private func composeItemClick () {
        print(compseTextView.getEmoticonString())
        
        //关闭键盘
        compseTextView.resignFirstResponder()
        
        //获取微博正文
        let statusText = compseTextView.getEmoticonString()
        
        let finishedCallback = { (isSuccess : Bool) in
                if !isSuccess {
                    SVProgressHUD.showErrorWithStatus("发送失败")
                    return
                }
                SVProgressHUD.showSuccessWithStatus("发送成功")
                self.dismissViewControllerAnimated(true, completion: nil)

        }
        
        //获取选中的图片
        if let image = images.first {
            NetworkTools.shareInstance.sendStatus(statusText, image: image, isSuccess: finishedCallback)
        } else {
            NetworkTools.shareInstance.sendStatus(statusText, isSuccess: finishedCallback)
        }
    }
    
    @objc private func keyboardWillChangeFrame(note : NSNotification) {
        // 1.获取动画执行的时间
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        
        // 2.获取键盘最终Y值
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let y = endFrame.origin.y
        
        // 3.计算工具栏距离底部的间距
        let margin = UIScreen.mainScreen().bounds.height - y
        
        // 4.执行动画
        toolBarBottomCons.constant = margin
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    //底部工具栏点击选择图片的事件
    @IBAction func picPickerBtnClick(sender: AnyObject) {
        //使得键盘退出
        compseTextView.resignFirstResponder()
        
        //picPickerView的展示动画
        picPickerViewHCons.constant = UIScreen.mainScreen().bounds.height * 0.65
        UIView.animateWithDuration(0.5) { 
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func emoticonBtnClick(sender: AnyObject) {
        //关闭键盘
        compseTextView.resignFirstResponder()
        //切换键盘
        compseTextView.inputView = compseTextView.inputView != nil ? nil : emoticonVc.view
        //弹出键盘
        compseTextView.becomeFirstResponder()
    }
}

// MARK: - textViewDelegate
extension ComposeViewController : UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        self.compseTextView.placeHoderLabel.hidden = compseTextView.hasText()
        if compseTextView.text != "" {
            navigationItem.rightBarButtonItem?.enabled = true

        }else {
            navigationItem.rightBarButtonItem?.enabled = false
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        compseTextView.resignFirstResponder()
    }
}