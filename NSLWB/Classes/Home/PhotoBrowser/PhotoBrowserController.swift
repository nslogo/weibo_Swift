//
//  PhotoBrowserController.swift
//  NSLWB
//
//  Created by nie on 16/9/12.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

private let PhotoBrowserCell = "PhotoBrowserCell"

class PhotoBrowserController: UIViewController {

    //MARK : - 懒加载属性
    private lazy var collectionView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: PhotoBrowserCollectionViewLayout())
    private lazy var closeBtn : UIButton = UIButton(bgColor: UIColor.darkGrayColor(), title: "关闭", fontSize: 14)!
    private lazy var saveBtn : UIButton = UIButton(bgColor: UIColor.darkGrayColor(), title: "保存", fontSize: 14)!
    
    
    //MARK : - 定义属性
    var indexPath : NSIndexPath
    var picUrls : [NSURL]
    
    //MARK : - 自定义构造函数
    init(indexPath : NSIndexPath, picUrls :[NSURL]) {
        self.indexPath = indexPath
        self.picUrls = picUrls
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK : - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setUpUI()
        
        //滚动到指定的图片
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
    }
    
    override func loadView() {
        super.loadView()
        view.frame.size.width += 20
    }

}

extension PhotoBrowserController {
    private func setUpUI() {
        self.view.backgroundColor = UIColor .blueColor()
        // 添加到view
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        
        //设置frame
        collectionView.frame = view.bounds
        closeBtn.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.bottom.equalTo(-20)
            make.size.equalTo(CGSize(width: 90, height: 32))
        }
        saveBtn.snp_makeConstraints { (make) in
            make.right.equalTo(-40)
            make.bottom.equalTo(closeBtn)
            make.size.equalTo(closeBtn.snp_size)
        }
        
        //设置collectionView的属性
        collectionView.registerClass(PhotoBrowserViewCell.self, forCellWithReuseIdentifier: PhotoBrowserCell)
        collectionView.dataSource = self
        
        //监听按钮事件
        closeBtn.addTarget(self, action: #selector(PhotoBrowserController.closeBtnClick), forControlEvents: .TouchUpInside)
        saveBtn.addTarget(self, action: #selector(PhotoBrowserController.saveBtnClick), forControlEvents: .TouchUpInside)
    }
}

// MARK: - 事件监听的函数方法
extension PhotoBrowserController {
    @objc private func closeBtnClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func saveBtnClick() {
        // 1.获取当前正在显示的image
        let cell = collectionView.visibleCells().first as! PhotoBrowserViewCell
        guard let image = cell.imageView.image else {
            return
        }
        
        // 2.将image对象保存相册
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(PhotoBrowserController.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func image(image : UIImage, didFinishSavingWithError error : NSError?, contextInfo : AnyObject) {
        var showInfo = ""
        if error != nil {
            showInfo = "保存失败"
        } else {
            showInfo = "保存成功"
        }
        
        SVProgressHUD.showInfoWithStatus(showInfo)
    }
}

// MARK: - collectionView数据源
extension PhotoBrowserController : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserCell, forIndexPath: indexPath) as! PhotoBrowserViewCell
        cell.delegate = self
        cell.picUrl = picUrls[indexPath.item]
    
        return cell
        
    }
}

// MARK:- PhotoBrowserViewCell的代理方法
extension PhotoBrowserController : PhotoBrowserViewCellDelegate {
    func imageViewClick() {
        closeBtnClick()
    }
}


// MARK: - collectionView的layout
class PhotoBrowserCollectionViewLayout : UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        
        itemSize = collectionView!.frame.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        
        collectionView?.pagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}

// MARK:- 遵守AnimatorDismissDelegate
extension PhotoBrowserController : AnimatorDismissDelegate {
    
    func indexPathForDimissView() -> NSIndexPath {
        // 1.获取当前正在显示的indexPath
        let cell = collectionView.visibleCells().first!
        
        return collectionView.indexPathForCell(cell)!
    }
    
    func imageViewForDimissView() -> UIImageView {
        // 1.创建UIImageView对象
        let imageView = UIImageView()
        
        // 2.设置imageView的frame
        let cell = collectionView.visibleCells().first as! PhotoBrowserViewCell
        imageView.frame = cell.imageView.frame
        imageView.image = cell.imageView.image
        
        // 3.设置imageView的属性
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
}