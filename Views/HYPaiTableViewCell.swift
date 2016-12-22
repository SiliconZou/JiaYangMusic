//
//  HYPaiTableViewCell.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/21.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class HYPaiTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var favouriteLabel: UILabel!
    @IBOutlet weak var totalVedioLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var picImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        picImg.layer.masksToBounds = true
        picImg.layer.cornerRadius = 3
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.frame.size.width = UIScreen.main.bounds.size.width
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
