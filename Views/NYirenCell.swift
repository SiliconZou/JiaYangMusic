//
//  NYirenCell.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/22.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class NYirenCell: UITableViewCell {

    @IBOutlet weak var views: UIView!
    @IBOutlet weak var groupImg: UIImageView!
    @IBOutlet weak var artistImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var entitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        artistImg.layer.masksToBounds = true
        artistImg.layer.cornerRadius = 25
        
        groupImg.layer.masksToBounds = true
        groupImg.layer.cornerRadius = 25
        
        views.layer.masksToBounds = true
        views.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
