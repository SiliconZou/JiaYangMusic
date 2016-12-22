//
//  HomeCell.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/17.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {

    @IBOutlet weak var picImage: UIImageView!
    
    @IBOutlet weak var playcountLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        picImage.layer.masksToBounds = true
        picImage.layer.cornerRadius = 2
    }

}
