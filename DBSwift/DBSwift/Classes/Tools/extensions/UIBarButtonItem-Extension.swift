//
//  UIBarButtonItem-Extension.swift
//  DBSwift
//
//  Created by Young on 2018/1/16.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
//    该方法类似OC 的UIBarButtonItem+xxx
//    但swift更推荐写便利构造函数
    class func createItem(imageName: String,
                          highImageName: String?,
                          size: CGSize = CGSize(width:0, height:0)) ->UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if let highName = highImageName {
            btn.setImage(UIImage(named: highName), for: .highlighted)
        }
        if size == CGSize(width:0, height:0) {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPoint(x:0, y:0), size: size)
        }
       
        return UIBarButtonItem(customView:btn)
    }
    
    convenience init(imageName: String, highImageName: String, size: CGSize) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint(x:0, y:0), size: size)
        self.init(customView:btn)
    }
}
