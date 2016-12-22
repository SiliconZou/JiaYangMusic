//
//  VBZhuanjiCell.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/25.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class VBZhuanjiCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var picImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
