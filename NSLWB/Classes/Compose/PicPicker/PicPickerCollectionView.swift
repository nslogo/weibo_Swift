//
//  PicPickerCollectionView.swift
//  NSLWB
//
//  Created by nie on 16/9/9.
//  Copyright © 2016年 ZoroNie. All rights reserved.
//

import UIKit

private let picPickerCell = "picPickerCell"
private let edgeMargin : CGFloat = 15

class PicPickerCollectionView: UICollectionView {

    //MARK : - 定义属性
    var images : [UIImage] = [UIImage]() {
        didSet {
            reloadData()
        }
    }
    
    //MARK : - 系统回调函数
    override func awakeFromNib() {
        //设置collectionView的一些属性
//        registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: picPickerCell)
        registerNib(UINib(nibName: "PicPickerViewCell",bundle: nil), forCellWithReuseIdentifier: picPickerCell)
        
        dataSource = self
        
        //设置collectionview的layout
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemWH = (UIScreen.mainScreen().bounds.width - 4 * edgeMargin) / 3
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumInteritemSpacing = edgeMargin
        layout.minimumLineSpacing = edgeMargin
        contentInset = UIEdgeInsets(top: edgeMargin, left: edgeMargin, bottom: 0, right: edgeMargin)
    
    }
}

extension PicPickerCollectionView : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(picPickerCell, forIndexPath: indexPath) as! PicPickerViewCell
        
        cell.backgroundColor  = UIColor.redColor()
        cell.image = indexPath.item <= images.count - 1 ? images[indexPath.item] : nil
        return cell
    }
}