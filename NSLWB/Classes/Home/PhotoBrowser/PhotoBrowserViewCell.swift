//
//  PhotoBrowserViewCell.swift
//  NSLWB
//
//  Created by nie on 16/9/13.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

/**
 *  设置代理
 */
protocol PhotoBrowserViewCellDelegate: NSObjectProtocol {
    func imageViewClick()
}

class PhotoBrowserViewCell: UICollectionViewCell {
    
    /**
     *  设置代理
     */
    var delegate : PhotoBrowserViewCellDelegate?
    
    //MARK : - 定义属性
    var picUrl : NSURL? {
        didSet {
           setUpContent(picUrl)
        }
    }
    
    //MARK : - 设置构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK : - 懒加载 
    private lazy var scrollView : UIScrollView = UIScrollView()
    lazy var imageView : UIImageView = UIImageView()
    private lazy var progressView : ProgressView = ProgressView()
}

// MARK: - 设置UI
extension PhotoBrowserViewCell {
    private func setUpUI() {
        
        //添加子控件
        contentView.addSubview(scrollView)
        contentView.addSubview(progressView)
        scrollView.addSubview(imageView)
        
        //设置子空间的frame
        scrollView.frame = contentView.bounds
        scrollView.frame.size.width -= 20
        progressView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        progressView.center = CGPoint(x: UIScreen.mainScreen().bounds.width * 0.5, y: UIScreen.mainScreen().bounds.height * 0.5)
        
        //设置控件的属性
        progressView.hidden = true
        progressView.backgroundColor = UIColor.clearColor()

        //图片的点击事件
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(PhotoBrowserViewCell.imageViewTap))
        imageView.addGestureRecognizer(tapGes)
        imageView.userInteractionEnabled = true
    }
}

// MARK: - 监听事件
extension PhotoBrowserViewCell {
    @objc func imageViewTap() {
        print("!!!")
        delegate?.imageViewClick()
    }
}
extension PhotoBrowserViewCell {
    private func setUpContent(picUrl : NSURL?) {
        //nil空值校验
        guard picUrl != nil else {
            return
        }
        
        //取出image对象
        let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(picUrl?.absoluteString)
        
        //iamgeView 的 frame
        let width = UIScreen.mainScreen().bounds.width
        let height = width / image.size.width * image.size.height
        var y : CGFloat = 0
        if height > UIScreen.mainScreen().bounds.height {
            y = 0
        } else {
            y = (UIScreen.mainScreen().bounds.height - height) * 0.5
        }
        imageView.frame = CGRect(x: 0, y: y, width: width, height: height)
        
        imageView.image = image
        
        //设置scrollView的contentSize
        scrollView.contentSize = CGSize(width: 0, height: height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        //
        progressView.hidden = false
        imageView.sd_setImageWithURL(getBigURL(picUrl!), placeholderImage: image, options: [], progress: { (current, total) in
            self.progressView.progress = CGFloat(current) / CGFloat(total)

            }) { (_, _, _, _) in
                self.progressView.hidden = true
                
        }
    }
    
    private func getBigURL(smallURL: NSURL) -> NSURL {
        let smallUrlString = smallURL.absoluteString
        let bigUrlString = smallUrlString!.stringByReplacingOccurrencesOfString("thumbnail", withString: "bmiddle")
        return NSURL(string : bigUrlString)!
    }
}
