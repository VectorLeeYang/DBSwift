//
//  CollectionHeaderView.swift
//  DBSwift
//
//  Created by Young on 2018/1/18.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    var group: AnchorGroup? {
        didSet {
            titleLabel.text! = group?.tag_name ?? "未知"
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
