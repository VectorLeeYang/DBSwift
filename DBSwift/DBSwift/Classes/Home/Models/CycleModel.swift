//
//  CycleModel.swift
//  DBSwift
//
//  Created by Young on 2018/1/19.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import HandyJSON
class CycleModel: HandyJSON {
    // 标题
    var title : String = ""
    // 展示的图片地址
    var pic_url : String = ""
    // 主播信息对应的字典
    var room : AnchorModel?
    // 主播信息对应的模型对象
    var anchor : AnchorModel?
    
    required init() {}
    
    func didFinishMapping() {
        guard let room = room else  { return }
        anchor = room
    }
}
