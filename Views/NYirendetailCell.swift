//
//  NYirendetailCell.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/22.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class NYirendetailCell: UITableViewCell {
    @IBOutlet weak var nameLabe: UILabel!
    @IBOutlet weak var artistImg: UIImageView!

    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var vediocountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        artistImg.layer.masksToBounds = true
        artistImg.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
