//
//  VBChinaCell.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/25.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class VBChinaCell: UITableViewCell {

    @IBOutlet weak var picImg: UIImageView!
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        picImg.layer.masksToBounds = true
        picImg.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
