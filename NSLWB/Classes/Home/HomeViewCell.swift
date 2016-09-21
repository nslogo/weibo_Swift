//
//  HomeViewCell.swift
//  NSLWB
//
//  Created by SilongNie on 16/9/3.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit


private let edgeMargin : CGFloat = 15
private let itemMargin : CGFloat = 10

class HomeViewCell: UITableViewCell {

    // MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var verifiend: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: HYLabel!
    @IBOutlet weak var picView: PicCollectionView!
    @IBOutlet weak var reweetedContentLabel: HYLabel!//转发的微博的文字
    @IBOutlet weak var reweetedBgView: UIView!
    
    // MARK: - 约束属性
    @IBOutlet weak var contentLabelCon: NSLayoutConstraint!
    
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    
    @IBOutlet weak var reweetedContentLabelTopCons: NSLayoutConstraint!
    @IBOutlet weak var reweetedContentLabelCon: NSLayoutConstraint!
    
    @IBOutlet weak var bottomViewTopCons: NSLayoutConstraint!
    
    // MARK: - 自定义属性
    var viewModel : StatusViewModel? {
        didSet {
            //1 nil值校验
            guard let viewModel = viewModel else {
                return
            }
            
            //2 设置头像
            iconImageView.sd_setImageWithURL(viewModel.profileURL, placeholderImage: UIImage(named: "avatar_default_small"))
            
            //3 设置认证图标
            verifiend.image = viewModel.verifiedImage
            
            //4 昵称
            nameLabel.text = viewModel.status?.user?.screen_name
            
            //5 会员图标
            vipView.image = viewModel.vipImage
            
            //6 设置时间
            timeLabel.text = viewModel.createAtText
            
            //7 设置来源
            if let sourceText = viewModel.sourceText {
                sourceLabel.text = "来自 " + sourceText
            }else {
                sourceLabel.text = nil
            }
            
            //8 正文
//            contentLabel.text = viewModel.status?.text
            contentLabel.attributedText = FindEmoticon.shareIntance.findAttrString(viewModel.status?.text, font: contentLabel.font)//设置正文的表情
            
            //9 设置昵称的颜色
            nameLabel.textColor = viewModel.vipImage == nil ? UIColor.blackColor() : UIColor.orangeColor()
         
            //10 计算picView的高度与宽度的约束
            let picViewSize = calculatePicViewSize(viewModel.picUrls.count)
            picViewWCons.constant = picViewSize.width
            picViewHCons.constant = picViewSize.height
            
            //11 将图片数据传递给子页面picView
            picView.picURLs = viewModel.picUrls
            
            //12 转发微博的正文
            if viewModel.status?.retweeted_status != nil {
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name, reweetedText = viewModel.status?.retweeted_status?.text {
//                    reweetedContentLabel.text = "@" + "\(screenName) : " + reweetedText
                    let reweetedText = "@" + "\(screenName) : " + reweetedText
                    reweetedContentLabel.attributedText = FindEmoticon.shareIntance.findAttrString(reweetedText, font: reweetedContentLabel.font)//设置转发正文的表情

                    //设置转发微博正文与顶部的约束
                    reweetedContentLabelTopCons.constant = 10
                }
                //设置转发微博的背景
                self.reweetedBgView.hidden = false
            }else {
                reweetedContentLabel.text = nil
                
                //设置转发微博正文与顶部的约束
                reweetedContentLabelTopCons.constant = 0
                
                //设置转发微博的背景
                self.reweetedBgView.hidden = true
            }
        }
    }
    
    // MARK: - 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置微博正文的宽度约束
        contentLabelCon.constant = UIScreen.mainScreen().bounds.width - 2 * edgeMargin
        reweetedContentLabelCon.constant = UIScreen.mainScreen().bounds.width - 2 * edgeMargin
        
        // 取出picView对应的layout
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
        let imageViewWH = (UIScreen.mainScreen().bounds.width - 2 * edgeMargin - 2 * itemMargin) / 3
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        
        // 设置HYLabel的内容
        contentLabel.matchTextColor = UIColor.blueColor()
        reweetedContentLabel.matchTextColor = UIColor.blueColor()
        
        // 监听HYlabel内容的点击
        // 监听@谁谁谁的点击
        contentLabel.userTapHandler = { (label, user, range) in
            print(user)
            print(range)
        }
        
        // 监听链接的点击
        contentLabel.linkTapHandler = { (label, link, range) in
            print(link)
            print(range)
        }
        
        // 监听话题的点击
        contentLabel.topicTapHandler = { (label, topic, range) in
            print(topic)
            print(range)
        }

        // 监听HYlabel内容的点击
        // 监听@谁谁谁的点击
        reweetedContentLabel.userTapHandler = { (label, user, range) in
            print(user)
            print(range)
        }
        
        // 监听链接的点击
        reweetedContentLabel.linkTapHandler = { (label, link, range) in
            print(link)
            print(range)
        }
        
        // 监听话题的点击
        reweetedContentLabel.topicTapHandler = { (label, topic, range) in
            print(topic)
            print(range)
        }
        
    }

}

extension HomeViewCell {
    private func calculatePicViewSize(count : Int) -> CGSize {
        //1 没有图片的情况
        if count == 0 {
//            bottomViewTopCons.constant = 0
            return CGSizeZero
        }
//        bottomViewTopCons.constant = 10
        
        // 2.取出picView对应的layout
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
        // 3.单张图片的时候 需要取出这张图片的实际宽高值
        if count == 1 {
            // 1.取出图片
            let urlString = viewModel?.picUrls.last?.absoluteString
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(urlString)
            
            // 2.设置一张图片是layout的itemSize
            layout.itemSize = CGSize(width: image.size.width * 2, height: image.size.height * 2)
            
            return CGSize(width: image.size.width * 2, height: image.size.height * 2)
        }
        
        //2 四张图片的情况
        //计算图片的高度与宽度
        let imageViewWH = (UIScreen.mainScreen().bounds.width - 2 * edgeMargin - 2 * itemMargin) / 3
        // 5.设置其他张图片时layout的itemSize
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        
        if count == 4 {
            let picViewWH = 2 * imageViewWH + itemMargin
            return CGSize(width: picViewWH + 1, height: picViewWH)
        }
        
        //3 其他数量图片的情况
        //行数
        let rows = CGFloat((count - 1) / 3 + 1)
        //高度
        let picViewH = rows * imageViewWH + (rows - 1) * itemMargin
        //宽度
        let picViewW = UIScreen.mainScreen().bounds.width - 2 * edgeMargin
        return CGSize(width: picViewW, height: picViewH)

        
   
    }
}