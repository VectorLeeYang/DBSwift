//
//  CollectionPrettyCell.swift
//  DBSwift
//
//  Created by Young on 2018/1/18.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {

    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }
            var onlineStr: String = ""
            if anchor.online > 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            nickNameLabel.text = anchor.nickname
            
            cityBtn.setTitle(anchor.anchor_city, for: .normal)
            
            guard let iconURL = NSURL(string: anchor.vertical_src) else { return }
            
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL as URL))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
