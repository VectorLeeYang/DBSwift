//
//  AnchorGroup.swift
//  DBSwift
//
//  Created by Young on 2018/1/19.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import HandyJSON
class AnchorGroup:  HandyJSON{
    // MARK:- 定义属性
    var tag_name : String = ""
    /// 该组中对应的房间信息
    var room_list : [AnchorModel]?
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    /// 游戏图标
    var icon_url : String = ""
    /// 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    // MARK:- 自定义构造函数
    required init() {
        
    }
    func didFinishMapping() {
        guard let room_list = room_list else { return }
        for dict in room_list {
            anchors.append(dict)
        }
    }
}

