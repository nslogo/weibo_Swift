//
//  PicPickerViewCell.swift
//  NSLWB
//
//  Created by nie on 16/9/9.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

class PicPickerViewCell: UICollectionViewCell {
    //MARK : - 控件属性
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var DelPhotoBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    //MARK : - 定义属性
    var image : UIImage? {
        didSet {
            if image != nil {
//                addPhotoBtn.setBackgroundImage(image, forState: .Normal)
                imageView.image = image
                addPhotoBtn.userInteractionEnabled = false
                DelPhotoBtn.hidden = false
            }else {
//                addPhotoBtn.setBackgroundImage(UIImage(named: "compose_pic_add"), forState: .Normal)
                imageView.image = nil
                addPhotoBtn.userInteractionEnabled = true
                DelPhotoBtn.hidden = true
            }
        }
    }
    //添加图片的button事件
    @IBAction func addPhotoClick(sender: AnyObject) {
        //添加图片的事件通知，因为需要跨两个文件所以优先使用通知
        NSNotificationCenter.defaultCenter().postNotificationName(picPickerAddPhotoNote, object: nil)
    }
    //删除啊图片的事件
    @IBAction func delPhotoClick(sender: AnyObject) {
        //删除图片的通州，原因同上
        NSNotificationCenter.defaultCenter().postNotificationName(picPickerDelPhotoNote, object: imageView.image)
    }
}
