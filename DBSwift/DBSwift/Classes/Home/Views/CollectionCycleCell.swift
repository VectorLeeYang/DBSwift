//
//  CollectionCycleCell.swift
//  DBSwift
//
//  Created by Young on 2018/1/19.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }

}
