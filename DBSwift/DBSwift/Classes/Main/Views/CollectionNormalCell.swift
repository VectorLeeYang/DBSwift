//
//  CollectionNormalCell.swift
//  DBSwift
//
//  Created by Young on 2018/1/18.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: UICollectionViewCell {
    
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }
            var onlineStr: String = ""
            if anchor.online > 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineButton.setTitle(onlineStr, for: .normal)
            
            nicknameLabel.text = anchor.nickname
            
            roomNameLabel.text = anchor.room_name
            
            guard let iconURL = NSURL(string: anchor.vertical_src) else { return }
            
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL as URL))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
