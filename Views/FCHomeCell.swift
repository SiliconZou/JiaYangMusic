//
//  FCHomeCell.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/26.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class FCHomeCell: UICollectionViewCell {

    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var picImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        picImg.layer.masksToBounds = true
        picImg.layer.cornerRadius = 3
    }

}
