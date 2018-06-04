//
//  SinglePxLine.swift
//  XYWKit
//
//  Created by 薛永伟 on 2018/6/4.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

/** XueYongWei 2018.6
 SinglePxHLine：单像素横线
 SinglePxVLine：单像素竖线
 这两个类保证分割是单像素的分割线，支持代码和IB创建，任意布局方式。
 释疑：继承自UIImageView，且不是通过backgroundColor设置背景色，是因为一般都是在cell中使用分割线，但是cell在选中状态会清空子view的背景色，导致分割线“消失”。故使用了一个带颜色的图片来替代背景色，防止cell选中状态分割线消失的情况发生。
 **/

/// 单像素横线
class SinglePxHLine:UIImageView{
    //分割线的背景颜色
    let lineColor = UIColor.black
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage.imageWith(color: lineColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.image = UIImage.imageWith(color: lineColor)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let rect = self.frame
        let height:CGFloat = 1.0/(UIScreen.main.scale)
        self.frame = CGRect.init(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height:height )
    }
    
}

/// 单像素竖线
class SinglePxVLine:UIImageView{
    //分割线的背景颜色
    let lineColor = UIColor.black
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage.imageWith(color: lineColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.image = UIImage.imageWith(color: lineColor)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let rect = self.frame
        let width:CGFloat = 1.0/(UIScreen.main.scale)
        self.frame = CGRect.init(x: rect.origin.x, y: rect.origin.y, width: width, height:rect.size.width )
    }
}



extension UIImage{
    /// 写一个只能在本类用到的类方法，为分割线提供图片，同样避免污染其他类似YYKit的方法。
    fileprivate class func imageWith(color:UIColor) -> UIImage?{
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
