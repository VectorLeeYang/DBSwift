//
//  BaseGameModel.swift
//  DBSwift
//
//  Created by Young on 2018/1/19.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import HandyJSON

class BaseGameModel: HandyJSON {
    // MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    required init() {}
}
