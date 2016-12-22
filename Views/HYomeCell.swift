//
//  HYomeCell.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/21.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class HYomeCell: UICollectionViewCell {

    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var picImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImg.layer.masksToBounds = true
        iconImg.layer.cornerRadius = 10
        picImg.layer.masksToBounds = true
        picImg.layer.cornerRadius = 3
    }

}
